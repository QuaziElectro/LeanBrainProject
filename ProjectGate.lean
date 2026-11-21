import Lean
import Lake

namespace ProjectGate

/-- Auto-implemented by `genProjectWrappers` for every wrapped type. -/
class WrappedType (α : Type) where
  typeName : String

/-! ## 1. Compile-Time Auto-Wrapper Across All Imported Libraries -/

section Generator
open Lean Elab Command

/-- Always wrapped (covers `Init`-defined system/kernel types and Lake `abbrev`s). -/
private def alwaysWrapTypes : List Name := [
  ``Lean.Environment,
  ``Lean.Name,
  ``Lean.Expr,
  ``Lean.ConstantInfo,
  ``Lean.DefinitionVal,
  ``Lean.TheoremVal,
  ``Lean.InductiveVal,
  ``Lean.AxiomVal,
  ``Lake.Package,
  ``Lake.LeanLib,
  ``Lake.LeanExe,
  ``Lake.Module,
  ``System.FilePath
]

/-- Heavy internal compiler/LSP subtrees skipped during auto-discovery to keep builds fast. -/
private def skipAutoWrapPrefixes : List Name := [
  `Lean.Elab, `Lean.Meta, `Lean.Compiler, `Lean.Linter, `Lean.Server,
  `Lean.Parser, `Lean.PrettyPrinter, `Lean.Widget, `Lean.DocString,
  `Lean.Language, `Lean.Data, `Lean.Util, `Lean.Grind, `Lean.SubExpr,
  `Lean.HeadIndex, `Lean.PremiseSelection
]

private def reservedStructSuffixes : List String := [
  "mk", "raw", "rec", "recOn", "casesOn",
  "noConfusion", "noConfusionType", "below", "brecOn", "binductionOn"
]

private def isSimpleName : Name → Bool
  | .anonymous => false
  | .num _ _ => false
  | .str p s =>
    !s.isEmpty &&
    !reservedStructSuffixes.contains s &&
    s.all (fun c => c.isAlphanum || c == '_' || c == '\'') &&
    (p.isAnonymous || isSimpleName p)

private def discoverWrapTargets (env : Environment) : Array (Name × Name) := Id.run do
  let mut seen : NameSet := {}
  let mut targets : Array (Name × Name) := #[]

  for t in alwaysWrapTypes do
    if env.contains t && !seen.contains t then
      seen := seen.insert t
      targets := targets.push (`Wrap ++ t, t)

  let names := env.header.moduleNames
  let data  := env.header.moduleData
  for i in [:names.size] do
    let modName := names[i]!
    if modName.getRoot == `Init then continue
    if skipAutoWrapPrefixes.any (·.isPrefixOf modName) then continue
    if let some md := data[i]? then
      for ci in md.constants do
        match ci with
        | .inductInfo iv =>
          let n := iv.name
          if seen.contains n then continue
          if isPrivateName n || n.isInternal || n.isInternalDetail then continue
          if isClass env n || iv.isUnsafe || iv.isNested then continue
          if !iv.levelParams.isEmpty || iv.numParams != 0 || iv.numIndices != 0 then continue
          if iv.type != .sort (.succ .zero) then continue
          if !isSimpleName n then continue
          seen := seen.insert n
          targets := targets.push (`Wrap ++ n, n)
        | _ => pure ()

  return targets

private partial def translateType? (targetToWrap : NameMap Name) (e : Expr) :
    CommandElabM (Option (TSyntax `term × (TSyntax `term → CommandElabM (TSyntax `term)))) := do
  match e with
  | .const c [] =>
    if c == ``String || c == ``Nat || c == ``Bool || c == ``Int || c == ``Unit then
      return some (mkIdent (`_root_ ++ c), fun v => pure v)
    else if let some wrapName := targetToWrap.find? c then
      let wrapId := mkIdent wrapName
      let mkId := mkIdent (wrapName ++ `mk)
      return some (wrapId, fun v => `($mkId $v))
    else
      return none
  | .app (.const ``List [_]) arg =>
    let some (innerTy, wrapFn) ← translateType? targetToWrap arg | return none
    let ty ← `(List $innerTy)
    return some (ty, fun v => do
      let xId := mkIdent `x
      let body ← wrapFn xId
      `(List.map (fun $xId => $body) $v))
  | .app (.const ``Array [_]) arg =>
    let some (innerTy, wrapFn) ← translateType? targetToWrap arg | return none
    let ty ← `(Array $innerTy)
    return some (ty, fun v => do
      let xId := mkIdent `x
      let body ← wrapFn xId
      `(Array.map (fun $xId => $body) $v))
  | .app (.const ``Option [_]) arg =>
    let some (innerTy, wrapFn) ← translateType? targetToWrap arg | return none
    let ty ← `(Option $innerTy)
    return some (ty, fun v => do
      let xId := mkIdent `x
      let body ← wrapFn xId
      `(Option.map (fun $xId => $body) $v))
  | _ => return none

private def genProjectWrappers : CommandElabM Unit := do
  let env0 ← getEnv
  let targets := discoverWrapTargets env0
  let mut targetToWrap : NameMap Name := {}
  for (wrapName, targetName) in targets do
    targetToWrap := targetToWrap.insert targetName wrapName

  -- Pass 1: emit wrapper structures + `WrappedType` instances
  for (wrapName, targetName) in targets do
    let fullWrapName := `ProjectGate ++ wrapName
    if (← getEnv).contains fullWrapName then continue
    let wrapId := mkIdent wrapName
    let targetId := mkIdent (`_root_ ++ targetName)
    let nameStrLit : TSyntax `term := quote fullWrapName.toString
    let cmd1 ← `(command|
      structure $wrapId where
        raw : $targetId)
    elabCommand cmd1
    let cmd2 ← `(command|
      instance : WrappedType $wrapId where
        typeName := $nameStrLit)
    elabCommand cmd2

  -- Pass 2: forward safe, computable structure fields
  let env ← getEnv
  for (wrapName, targetName) in targets do
    if !isStructure env targetName then continue
    let fields := getStructureFieldsFlattened env targetName (includeSubobjectFields := false)
    for fieldName in fields do
      if fieldName == `raw || !isSimpleName fieldName then continue
      if (← getEnv).contains (`ProjectGate ++ (wrapName ++ fieldName)) then continue
      let some baseStruct := findField? env targetName fieldName | continue
      let some fieldInfo := getFieldInfo? env baseStruct fieldName | continue
      if isPrivateName fieldInfo.projFn then continue
      let some ci := env.find? fieldInfo.projFn | continue
      if !ci.levelParams.isEmpty || ci.isUnsafe || isNoncomputable env fieldInfo.projFn then continue
      let .forallE _ (.const domName []) retTy .default := ci.type | continue
      if domName != baseStruct || retTy.hasLooseBVars then continue
      let some (retTyStx, wrapFn) ← translateType? targetToWrap retTy | continue
      let some path :=
        if baseStruct == targetName then some []
        else getPathToBaseStructure? env baseStruct targetName | continue

      let wrapId := mkIdent wrapName
      let wId := mkIdent `w
      let rawProjId := mkIdent (wrapName ++ `raw)
      let mut acc ← `($rawProjId $wId)
      for stepFn in path do
        let stepId := mkIdent (`_root_ ++ stepFn)
        acc ← `($stepId $acc)
      let projId := mkIdent (`_root_ ++ fieldInfo.projFn)
      acc ← `($projId $acc)
      let bodyStx ← wrapFn acc
      let fnId := mkIdent (wrapName ++ fieldName)
      let cmd ← `(command|
        def $fnId ($wId : $wrapId) : $retTyStx := $bodyStx)
      elabCommand cmd

run_cmd genProjectWrappers

end Generator

/-! ## 2. Clean Aliases & Kernel Helpers -/

abbrev ProjectEnv       := Wrap.Lean.Environment
abbrev ProjectName      := Wrap.Lean.Name
abbrev ProjectExpr      := Wrap.Lean.Expr
abbrev ProjectConst     := Wrap.Lean.ConstantInfo
abbrev ProjectDef       := Wrap.Lean.DefinitionVal
abbrev ProjectTheorem   := Wrap.Lean.TheoremVal
abbrev ProjectInductive := Wrap.Lean.InductiveVal
abbrev ProjectAxiomVal  := Wrap.Lean.AxiomVal
abbrev ProjectPkg       := Wrap.Lake.Package
abbrev ProjectLib       := Wrap.Lake.LeanLib
abbrev ProjectExe       := Wrap.Lake.LeanExe
abbrev ProjectModule    := Wrap.Lake.Module
abbrev ProjectPath      := Wrap.System.FilePath

instance : BEq ProjectName where beq a b := a.raw == b.raw
instance : BEq ProjectExpr where beq a b := a.raw == b.raw
instance : BEq ProjectPath where beq a b := a.raw == b.raw

def mkProjectName (s : String) : ProjectName :=
  ⟨Lean.Name.mkSimple s⟩

private def collectParamTypes : Lean.Expr → List ProjectExpr
  | .forallE _ dom body .default => ⟨dom⟩ :: collectParamTypes body
  | .forallE _ _   body _        => collectParamTypes body
  | _ => []

def Wrap.Lean.Expr.paramTypes (e : ProjectExpr) : List ProjectExpr :=
  collectParamTypes e.raw

def Wrap.Lean.Expr.isFalse  (e : ProjectExpr) : Bool := e.raw.isFalse
def Wrap.Lean.Expr.hasSorry (e : ProjectExpr) : Bool := e.raw.hasSorry

def Wrap.Lean.Environment.find? (env : ProjectEnv) (n : ProjectName) : Option ProjectConst :=
  (env.raw.find? n.raw).map (⟨·⟩)

def leanVersion : String := Lean.versionString

/-! ## 3. Permanent Whitelist Gate + Cross-Module Rule Sweep -/

section Linter
open Lean Elab Command

private abbrev RawDeclRule := Environment → Name → ConstantInfo → Option String
private abbrev ValueRule   := String × (Name → Name → Meta.MetaM (Option String))

private builtin_initialize declRulesRef  : IO.Ref (Array RawDeclRule) ← IO.mkRef #[]
private builtin_initialize valueRulesRef : IO.Ref (Array ValueRule)   ← IO.mkRef #[]

private def addRawDeclRule (r : RawDeclRule) : IO Unit :=
  declRulesRef.modify (·.push r)

private unsafe def evalConstUnsafe (α : Type) (typeName declName : Name) :
    Meta.MetaM (Except String α) := do
  try
    let v ← Meta.evalExpr α (mkConst typeName) (mkConst declName)
    return .ok v
  catch e =>
    return .error (← e.toMessageData.toString)

@[implemented_by evalConstUnsafe]
private def evalConst (α : Type) (_ _ : Name) : Meta.MetaM (Except String α) :=
  return .error "value evaluator unavailable"

private def allowedCoreAxioms : NameSet :=
  ({} : NameSet)
    |>.insert ``propext
    |>.insert ``Classical.choice
    |>.insert ``Quot.sound

private def isLocalProjectModule (m : Name) : IO Bool := do
  if m == `ProjectGate || m.getRoot == `Init then
    return false
  let root := m.getRoot
  if root == `Lean || root == `Lake || root == `System || root == `Std then
    return false
  try
    let path ← Lean.findOLean m
    let p := path.toString.replace "\\" "/" |>.toLower
    let cwd := (← IO.currentDir).toString.replace "\\" "/" |>.toLower
    return p.startsWith (cwd ++ "/.lake/build/")
  catch _ =>
    return false

private def isAllowedImport (m : Name) : IO Bool := do
  if m == `ProjectGate || m.getRoot == `Init then
    return true
  isLocalProjectModule m

private def isAutoGenerated (env : Environment) (name : Name) : Bool :=
  name.isInternalDetail ||
  env.isProjectionFn name ||
  isAuxRecursor env name ||
  match name with
  | .str _ s =>
    s == "noConfusion" || s == "noConfusionType" || s == "sizeOf_spec" ||
    s.startsWith "initFn"
  | _ => false

/-- Runs all declaration rules and data-wrapper value rules on one constant. -/
private def runRegisteredRules (env : Environment) (declRules : Array RawDeclRule)
    (valueRules : Array ValueRule) (name : Name) (ci : ConstantInfo) : CommandElabM Unit := do
  if isAutoGenerated env name then return
  match ci with
  | .ctorInfo _ | .recInfo _ | .quotInfo _ | .axiomInfo _ | .opaqueInfo _ => return
  | _ => pure ()

  for r in declRules do
    if let some err := r env name ci then
      logError m!"[Gate] `{name}` failed: {err}"

  match ci with
  | .defnInfo dv =>
    if !valueRules.isEmpty && dv.levelParams.isEmpty && !isNoncomputable env name then
      let tyWhnf ← liftTermElabM (Meta.whnf dv.type)
      if let some tyName := tyWhnf.constName? then
        let tyStr := tyName.toString
        for (targetTyStr, checkVal) in valueRules do
          if targetTyStr == tyStr then
            if let some err ← liftTermElabM (checkVal tyName name) then
              logError m!"[Gate] `{name}` failed `{tyName}` limit: {err}"
  | _ => pure ()

def brainGateLinter : ModuleLinter where
  name := `ProjectGate.brainGateLinter
  run := fun _ => do
    let env ← getEnv
    if env.header.mainModule == `ProjectGate then
      return

    let declRules ← declRulesRef.get
    let valueRules ← valueRulesRef.get

    -- 1. Ban importing ANY external library directly
    for imp in env.header.imports do
      if !(← isAllowedImport imp.module) then
        logError m!"[Gate] Banned import `{imp.module}`: external libraries must go through `ProjectGate`"

    -- 2. Check every declaration in the CURRENT file
    for (name, ci) in env.constants.map₂.toList do
      match ci with
      | .axiomInfo _  => logError m!"[Gate] Banned `axiom`: `{name}`"; continue
      | .opaqueInfo _ => logError m!"[Gate] Banned `opaque`: `{name}`"; continue
      | .ctorInfo _ | .recInfo _ | .quotInfo _ => continue
      | _ => pure ()

      if isAutoGenerated env name then continue

      let axioms ← liftCoreM (Lean.collectAxioms name)
      let mut hasSorry := false
      for ax in axioms do
        if !allowedCoreAxioms.contains ax then
          logError m!"[Gate] `{name}` depends on disallowed axiom `{ax}`"
          if ax == ``sorryAx then hasSorry := true
      if hasSorry then continue

      for used in ci.getUsedConstantsAsSet do
        let root := used.getRoot
        if root == `Lean || root == `Lake || root == `System then
          logError m!"[Gate] Raw `{used}` is banned outside `ProjectGate` (in `{name}`)"
        else if let some modIdx := env.getModuleIdxFor? used then
          let modName := env.header.moduleNames[modIdx.toNat]!
          if !(← isAllowedImport modName) then
            logError m!"[Gate] Banned constant `{used}` from external module `{modName}` (in `{name}`)"

      runRegisteredRules env declRules valueRules name ci

    -- 3. Global sweep: enforce ALL currently loaded rules across ALL imported local project modules
    if !declRules.isEmpty || !valueRules.isEmpty then
      let modNames := env.header.moduleNames
      let modData  := env.header.moduleData
      for i in [:modNames.size] do
        if ← isLocalProjectModule modNames[i]! then
          if let some md := modData[i]? then
            for ci in md.constants do
              runRegisteredRules env declRules valueRules ci.name ci

builtin_initialize addModuleLinter brainGateLinter

def registerDefRule (msg : String) (rule : ProjectDef → Bool) : IO Unit :=
  addRawDeclRule fun _ _ ci => match ci with
    | .defnInfo dv => if rule ⟨dv⟩ then none else some msg
    | _            => none

def registerThmRule (msg : String) (rule : ProjectTheorem → Bool) : IO Unit :=
  addRawDeclRule fun _ _ ci => match ci with
    | .thmInfo tv => if rule ⟨tv⟩ then none else some msg
    | _           => none

def registerInductiveRule (msg : String) (rule : ProjectInductive → Bool) : IO Unit :=
  addRawDeclRule fun _ _ ci => match ci with
    | .inductInfo iv => if rule ⟨iv⟩ then none else some msg
    | _              => none

/-- Any project file can limit ANY wrapped data type (`ProjectName`, `ProjectPath`, `ProjectPkg`, etc.). -/
def registerValueRule {α : Type} [w : WrappedType α] (msg : String) (rule : α → Bool) : IO Unit :=
  valueRulesRef.modify fun arr =>
    arr.push (w.typeName, fun tyName declName => do
      match (← evalConst α tyName declName) with
      | .ok v      => return if rule v then none else some msg
      | .error err => return some s!"could not evaluate `{declName}`: {err}")

end Linter

end ProjectGate
