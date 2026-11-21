import ProjectGate

namespace Concepts

set_option genInjectivity false

/-- [Page 1]
"Lean 4 is fully extensible: users can modify and extend the parser, elaborator, tactics,
decision procedures, pretty printer, and code generator."

Architectural components of an interactive theorem prover that can be modified or extended.
-/
inductive SystemComponent where
  | parser
  | elaborator
  | tactics
  | decisionProcedures
  | prettyPrinter
  | codeGenerator
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity of `SystemComponent`. -/
def SystemComponent_witness : SystemComponent :=
  SystemComponent.parser

/-- Complete list of architectural components mentioned on Page 1. -/
def SystemComponent.all : List SystemComponent :=
  [.parser, .elaborator, .tactics, .decisionProcedures, .prettyPrinter, .codeGenerator]

/-- [Page 1]
"The new system has a hygienic macro system custom-built for ITPs."

A macro system for an interactive theorem prover, specifying hygiene
and whether it was custom-built for interactive theorem provers.
-/
structure MacroSystem where
  isHygienic : Bool := true
  customBuiltForITPs : Bool := true
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `MacroSystem`. -/
def MacroSystem_witness : MacroSystem := {
  isHygienic := true
  customBuiltForITPs := true
}

/-- [Page 1]
"It contains a new typeclass resolution procedure based on tabled resolution,
addressing significant performance problems reported by the growing user base."

A typeclass resolution procedure modeling the resolution mechanism, whether it is new,
and whether it addresses performance problems reported by users.
-/
structure TypeclassResolutionProcedure where
  isTabled : Bool := true
  isNew : Bool := true
  addressesPerformanceProblems : Bool := true
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `TypeclassResolutionProcedure`. -/
def TypeclassResolutionProcedure_witness : TypeclassResolutionProcedure := {
  isTabled := true
  isNew := true
  addressesPerformanceProblems := true
}

/-- Predicate checking whether a typeclass resolution procedure is based on tabled resolution. -/
def TypeclassResolutionProcedure.isBasedOnTabledResolution (tr : TypeclassResolutionProcedure) : Bool :=
  tr.isTabled

/-- [Page 1]
"Lean 4 is also an efficient functional programming language based on a novel
programming paradigm called functional but in-place."

A programming paradigm, capturing its designation and whether it is novel.
-/
structure ProgrammingParadigm where
  name : String := "functional but in-place"
  isNovel : Bool := true
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `ProgrammingParadigm`. -/
def ProgrammingParadigm_witness : ProgrammingParadigm := {
  name := "functional but in-place"
  isNovel := true
}

/-- [Page 1]
"Since users write custom proof automation procedures in Lean, and use Lean as a programming language,
efficient code generation is crucial."

A proof automation procedure written for an interactive theorem prover.
-/
structure ProofAutomationProcedure where
  name : String := "custom automation"
  isCustom : Bool := true
  language : String := "Lean"
  isEfficient : Bool := false
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `ProofAutomationProcedure`. -/
def ProofAutomationProcedure_witness : ProofAutomationProcedure := {
  name := "custom automation"
  isCustom := true
  language := "Lean"
  isEfficient := true
}

/-- [Page 1]
"Lean is based on the calculus of inductive constructions (CIC) [38]."

Foundational formal type systems and logical frameworks for interactive theorem provers.
-/
inductive LogicalFramework where
  | cic
  | other (name : String)
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity of `LogicalFramework`. -/
def LogicalFramework_witness : LogicalFramework :=
  LogicalFramework.cic

/-- [Page 2]
"We believe the Lean 3 theorem prover's success is primarily due to its extensibility capabilities and metaprogramming framework [6]."

Factors contributing to the success of an interactive theorem prover.
-/
inductive SuccessFactor where
  | extensibilityCapabilities
  | metaprogrammingFramework
  | other (description : String)
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity of `SuccessFactor`. -/
def SuccessFactor_witness : SuccessFactor :=
  SuccessFactor.extensibilityCapabilities

/-- [Page 2]
"The primary source of inefficiency in Lean 3 metaprograms is the virtual machine interpretation overhead."

Sources of inefficiency in interactive theorem prover metaprograms.
-/
inductive InefficiencySource where
  | virtualMachineInterpretationOverhead
  | other (description : String)
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity of `InefficiencySource`. -/
def InefficiencySource_witness : InefficiencySource :=
  InefficiencySource.virtualMachineInterpretationOverhead

/-- [Page 2]
"Another issue is that many proof automation metaprograms are not competitive with similar proof automation implemented in programming languages with an efficient compiler such as C++ and OCaml."

A programming language characterized by whether it has an efficient compiler.
-/
structure ProgrammingLanguage where
  name : String
  hasEfficientCompiler : Bool := false
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `ProgrammingLanguage`. -/
def ProgrammingLanguage_witness : ProgrammingLanguage := {
  name := "C++"
  hasEfficientCompiler := true
}

/-- Witness for C++ as a programming language with an efficient compiler. -/
def cppLanguage_witness : ProgrammingLanguage := {
  name := "C++"
  hasEfficientCompiler := true
}

/-- Witness for OCaml as a programming language with an efficient compiler. -/
def ocamlLanguage_witness : ProgrammingLanguage := {
  name := "OCaml"
  hasEfficientCompiler := true
}

/-- Witness for C as a programming language with an efficient compiler. -/
def cLanguage_witness : ProgrammingLanguage := {
  name := "C"
  hasEfficientCompiler := true
}

/-- Witness for Lean as a programming language with an efficient compiler. -/
def leanLanguage_witness : ProgrammingLanguage := {
  name := "Lean"
  hasEfficientCompiler := true
}

/-- Whether a programming language has an efficient compiler. -/
def ProgrammingLanguage.hasAnEfficientCompiler (lang : ProgrammingLanguage) : Prop :=
  lang.hasEfficientCompiler = true

instance (lang : ProgrammingLanguage) : Decidable lang.hasAnEfficientCompiler :=
  inferInstanceAs (Decidable (lang.hasEfficientCompiler = true))

/-- [Page 1]
"Mathlib contains not only mathematical objects but also Lean metaprograms that extend the system [5]."
"Some of these metaprograms implement nontrivial proof automation, such as a ring theory solver and a decision procedure for Presburger arithmetic."
"Lean metaprograms in mathlib also extend the system by adding new top-level command and features not related to proof automation."
[Page 2]
"Another issue is that many proof automation metaprograms are not competitive with similar proof automation implemented in programming languages with an efficient compiler such as C++ and OCaml."

A Lean metaprogram formalized within a mathematical library or extending the prover,
optionally implementing proof automation, top-level commands, or standalone applications,
and characterized by its performance competitiveness.
-/
structure Metaprogram where
  name : String
  extendsSystem : Bool := true
  implementsProofAutomation : Bool := false
  isNontrivialProofAutomation : Bool := false
  addsTopLevelCommands : Bool := false
  isNonAutomationFeature : Bool := false
  isCompetitiveWithCompiledAutomation : Bool := false
  deriving Inhabited, DecidableEq, Repr

/-- Whether a metaprogram extends the system. -/
def Metaprogram.extendsTheSystem (mp : Metaprogram) : Prop :=
  mp.extendsSystem = true

instance (mp : Metaprogram) : Decidable mp.extendsTheSystem :=
  inferInstanceAs (Decidable (mp.extendsSystem = true))

/-- Whether a metaprogram implements nontrivial proof automation. -/
def Metaprogram.implementsNontrivialProofAutomation (mp : Metaprogram) : Prop :=
  mp.implementsProofAutomation = true ∧ mp.isNontrivialProofAutomation = true

instance (mp : Metaprogram) : Decidable mp.implementsNontrivialProofAutomation :=
  inferInstanceAs (Decidable (mp.implementsProofAutomation = true ∧ mp.isNontrivialProofAutomation = true))

/-- Whether a metaprogram extends the system by adding new top-level commands
and features not related to proof automation. -/
def Metaprogram.addsTopLevelCommandsAndNonAutomation (mp : Metaprogram) : Prop :=
  mp.addsTopLevelCommands = true ∧ mp.isNonAutomationFeature = true

instance (mp : Metaprogram) : Decidable mp.addsTopLevelCommandsAndNonAutomation :=
  inferInstanceAs (Decidable (mp.addsTopLevelCommands = true ∧ mp.isNonAutomationFeature = true))

/-- Whether a metaprogram is competitive with proof automation implemented in compiled languages. -/
def Metaprogram.isCompetitiveWithCompiled (mp : Metaprogram) : Prop :=
  mp.isCompetitiveWithCompiledAutomation = true

instance (mp : Metaprogram) : Decidable mp.isCompetitiveWithCompiled :=
  inferInstanceAs (Decidable (mp.isCompetitiveWithCompiledAutomation = true))

/-- Whether a proof automation metaprogram is not competitive with proof automation
implemented in compiled languages. -/
def Metaprogram.isNotCompetitiveWithCompiled (mp : Metaprogram) : Prop :=
  mp.implementsProofAutomation = true ∧ mp.isCompetitiveWithCompiledAutomation = false

instance (mp : Metaprogram) : Decidable mp.isNotCompetitiveWithCompiled :=
  inferInstanceAs (Decidable (mp.implementsProofAutomation = true ∧ mp.isCompetitiveWithCompiledAutomation = false))

/-- Computable witness demonstrating non-vacuity and satisfiability of `Metaprogram`.
Represents the ring theory solver implementing nontrivial proof automation. -/
def ringTheorySolver_witness : Metaprogram := {
  name := "ring theory solver"
  extendsSystem := true
  implementsProofAutomation := true
  isNontrivialProofAutomation := true
  addsTopLevelCommands := false
  isNonAutomationFeature := false
  isCompetitiveWithCompiledAutomation := false
}

/-- Default witness alias for `Metaprogram`. -/
def Metaprogram_witness : Metaprogram :=
  ringTheorySolver_witness

/-- Computable witness representing the decision procedure for Presburger arithmetic. -/
def presburgerArithmetic_witness : Metaprogram := {
  name := "decision procedure for Presburger arithmetic"
  extendsSystem := true
  implementsProofAutomation := true
  isNontrivialProofAutomation := true
  addsTopLevelCommands := false
  isNonAutomationFeature := false
  isCompetitiveWithCompiledAutomation := false
}

/-- Computable witness representing a metaprogram adding top-level commands and non-automation features. -/
def topLevelCommandMetaprogram_witness : Metaprogram := {
  name := "top-level command and non-automation extension"
  extendsSystem := true
  implementsProofAutomation := false
  isNontrivialProofAutomation := false
  addsTopLevelCommands := true
  isNonAutomationFeature := true
  isCompetitiveWithCompiledAutomation := false
}

/-- Computable witness representing a Lean 3 proof automation metaprogram that is not competitive
with compiled implementations in C++ or OCaml. -/
def lean3ProofAutomation_witness : Metaprogram := {
  name := "Lean 3 proof automation"
  extendsSystem := true
  implementsProofAutomation := true
  isNontrivialProofAutomation := true
  addsTopLevelCommands := false
  isNonAutomationFeature := false
  isCompetitiveWithCompiledAutomation := false
}

/-- [Page 2]
"Lean 3 metaprograms have been also instrumental in building standalone applications, such as a SQL query equivalence checker [3]."

A standalone external application built using interactive theorem prover metaprograms.
-/
structure StandaloneApplication where
  name : String := ""
  builtUsingMetaprograms : Bool := false
  metaprogramProver : Option String := none
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `StandaloneApplication`.
Represents the SQL query equivalence checker mentioned on Page 2. -/
def sqlQueryEquivalenceChecker_witness : StandaloneApplication := {
  name := "SQL query equivalence checker"
  builtUsingMetaprograms := true
  metaprogramProver := some "Lean 3"
}

/-- Default witness alias for `StandaloneApplication`. -/
def StandaloneApplication_witness : StandaloneApplication :=
  sqlQueryEquivalenceChecker_witness

/-- Whether a standalone application was built using metaprograms. -/
def StandaloneApplication.isBuiltUsingMetaprograms (app : StandaloneApplication) : Prop :=
  app.builtUsingMetaprograms = true

instance (app : StandaloneApplication) : Decidable app.isBuiltUsingMetaprograms :=
  inferInstanceAs (Decidable (app.builtUsingMetaprograms = true))

/-- [Page 2]
"It includes a translation verifier for Reopt, a package for supporting inductive-inductive types, and a car controller."

An application or package built using an interactive theorem prover.
Extends `StandaloneApplication` to model applications of the prover.
-/
structure ProverApplication extends StandaloneApplication where
  category : String := ""
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `ProverApplication`.
Represents the translation verifier for Reopt. -/
def reoptTranslationVerifier_witness : ProverApplication := {
  name := "translation verifier for Reopt"
  category := "translation verifier"
  builtUsingMetaprograms := true
  metaprogramProver := some "Lean 4"
}

/-- Computable witness representing the package for supporting inductive-inductive types. -/
def inductiveInductivePackage_witness : ProverApplication := {
  name := "package for supporting inductive-inductive types"
  category := "package"
  builtUsingMetaprograms := true
  metaprogramProver := some "Lean 4"
}

/-- Computable witness representing the car controller application. -/
def carController_witness : ProverApplication := {
  name := "car controller"
  category := "car controller"
  builtUsingMetaprograms := true
  metaprogramProver := some "Lean 4"
}

/-- Default witness alias for `ProverApplication`. -/
def ProverApplication_witness : ProverApplication :=
  reoptTranslationVerifier_witness

/-- Whether a prover application belongs to a specific category. -/
def ProverApplication.hasCategory (app : ProverApplication) (cat : String) : Prop :=
  app.category = cat

instance (app : ProverApplication) (cat : String) : Decidable (app.hasCategory cat) :=
  inferInstanceAs (Decidable (app.category = cat))

/-- Whether a prover application has a specific name. -/
def ProverApplication.hasName (app : ProverApplication) (n : String) : Prop :=
  app.name = n

instance (app : ProverApplication) (n : String) : Decidable (app.hasName n) :=
  inferInstanceAs (Decidable (app.name = n))

/-- [Page 2]
"The new compiler produces C code, and users can now implement efficient proof automation in Lean, compile it into efficient C code, and load it as a plugin."

A compiler for an interactive theorem prover programming language.
-/
structure Compiler where
  name : String := ""
  isNew : Bool := false
  targetLanguage : String := ""
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `Compiler`.
Represents the new Lean 4 compiler producing C code. -/
def Compiler_witness : Compiler := {
  name := "Lean 4 C compiler"
  isNew := true
  targetLanguage := "C"
}

/-- Whether a compiler is a new compiler. -/
def Compiler.isNewCompiler (c : Compiler) : Prop :=
  c.isNew = true

instance (c : Compiler) : Decidable c.isNewCompiler :=
  inferInstanceAs (Decidable (c.isNew = true))

/-- Whether a compiler produces a specific target language. -/
def Compiler.producesTargetLanguage (c : Compiler) (lang : String) : Prop :=
  c.targetLanguage = lang

instance (c : Compiler) (lang : String) : Decidable (c.producesTargetLanguage lang) :=
  inferInstanceAs (Decidable (c.targetLanguage = lang))

/-- Whether a compiler produces C code. -/
def Compiler.producesCCode (c : Compiler) : Prop :=
  c.producesTargetLanguage "C"

instance (c : Compiler) : Decidable c.producesCCode :=
  inferInstanceAs (Decidable (c.producesTargetLanguage "C"))

/-- Whether a compiler produces a specific programming language. -/
def Compiler.producesLanguage (c : Compiler) (lang : ProgrammingLanguage) : Prop :=
  c.producesTargetLanguage lang.name

instance (c : Compiler) (lang : ProgrammingLanguage) : Decidable (c.producesLanguage lang) :=
  inferInstanceAs (Decidable (c.producesTargetLanguage lang.name))

/-- [Page 2]
"The new compiler produces C code, and users can now implement efficient proof automation in Lean, compile it into efficient C code, and load it as a plugin."

A dynamically loaded plugin compiled from proof automation code.
-/
structure Plugin where
  name : String := ""
  language : String := ""
  isCompiledFromProofAutomation : Bool := false
  sourceAutomation : Option ProofAutomationProcedure := none
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `Plugin`.
Represents a proof automation plugin compiled into C code. -/
def Plugin_witness : Plugin := {
  name := "proof automation plugin"
  language := "C"
  isCompiledFromProofAutomation := true
  sourceAutomation := some ProofAutomationProcedure_witness
}

/-- Whether a plugin is compiled from proof automation. -/
def Plugin.isCompiledFromAutomation (p : Plugin) : Prop :=
  p.isCompiledFromProofAutomation = true ∨ p.sourceAutomation.isSome

instance (p : Plugin) : Decidable p.isCompiledFromAutomation :=
  inferInstanceAs (Decidable (p.isCompiledFromProofAutomation = true ∨ p.sourceAutomation.isSome))

/-- Whether a plugin is written in or targeting a specific language. -/
def Plugin.isWrittenIn (p : Plugin) (lang : String) : Prop :=
  p.language = lang

instance (p : Plugin) (lang : String) : Decidable (p.isWrittenIn lang) :=
  inferInstanceAs (Decidable (p.language = lang))

/-- Whether a plugin is written in or targeting a specific programming language. -/
def Plugin.isWrittenInLanguage (p : Plugin) (lang : ProgrammingLanguage) : Prop :=
  p.isWrittenIn lang.name

instance (p : Plugin) (lang : ProgrammingLanguage) : Decidable (p.isWrittenInLanguage lang) :=
  inferInstanceAs (Decidable (p.isWrittenIn lang.name))

/-- [Page 2]
"In Lean 4, users can access all internal data structures used to implement Lean by merely importing the Lean package."

An internal data structure used in the implementation of an interactive theorem prover.
-/
structure InternalDataStructure where
  name : String := ""
  usedInImplementation : Bool := false
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `InternalDataStructure`.
Represents an internal data structure used in the implementation of Lean. -/
def InternalDataStructure_witness : InternalDataStructure := {
  name := "environment"
  usedInImplementation := true
}

/-- Whether an internal data structure is used in the implementation of the prover. -/
def InternalDataStructure.isUsedInImplementation (ids : InternalDataStructure) : Prop :=
  ids.usedInImplementation = true

instance (ids : InternalDataStructure) : Decidable ids.isUsedInImplementation :=
  inferInstanceAs (Decidable (ids.usedInImplementation = true))

/-- [Page 2]
"In Lean 4, users can access all internal data structures used to implement Lean by merely importing the Lean package."

A package provided by an interactive theorem prover, exporting its internal data structures.
-/
structure ProverPackage where
  name : String := ""
  exportsInternalDataStructures : Bool := false
  exportedDataStructures : List InternalDataStructure := []
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `ProverPackage`.
Represents the Lean package exporting all internal data structures. -/
def ProverPackage_witness : ProverPackage := {
  name := "Lean"
  exportsInternalDataStructures := true
  exportedDataStructures := [InternalDataStructure_witness]
}

/-- Whether a prover package exports all internal data structures. -/
def ProverPackage.exportsAllInternalDataStructures (pkg : ProverPackage) : Prop :=
  pkg.exportsInternalDataStructures = true

instance (pkg : ProverPackage) : Decidable pkg.exportsAllInternalDataStructures :=
  inferInstanceAs (Decidable (pkg.exportsInternalDataStructures = true))

/-- Whether a prover package exports a specific internal data structure used in implementation. -/
def ProverPackage.exportsDataStructure (pkg : ProverPackage) (ids : InternalDataStructure) : Prop :=
  ids ∈ pkg.exportedDataStructures ∧ ids.isUsedInImplementation

instance (pkg : ProverPackage) (ids : InternalDataStructure) : Decidable (pkg.exportsDataStructure ids) :=
  inferInstanceAs (Decidable (ids ∈ pkg.exportedDataStructures ∧ ids.isUsedInImplementation))

/-- [Page 2]
"Lean 4 is also a platform for developing efficient domain-specific automation."

A domain-specific automation procedure or tool developed for an interactive theorem prover.
Extends `ProofAutomationProcedure` to capture domain-specific automation procedures.
-/
structure DomainSpecificAutomation extends ProofAutomationProcedure where
  domain : String := ""
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `DomainSpecificAutomation`.
Represents an efficient domain-specific automation procedure developed for Lean 4. -/
def DomainSpecificAutomation_witness : DomainSpecificAutomation := {
  name := "domain automation"
  isCustom := true
  language := "Lean"
  isEfficient := true
  domain := "general"
}

/-- [Page 2]
"It has a more robust and extensible elaborator, and addresses many other shortcomings of Lean 3."

An elaborator component of an interactive theorem prover, characterized by robustness,
extensibility, and relative robustness compared to previous versions.
-/
structure Elaborator where
  name : String := ""
  isRobust : Bool := false
  isExtensible : Bool := false
  isMoreRobustThanPrevious : Bool := false
  triesToInferFunctionBodyType : Bool := false
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `Elaborator`.
Represents the Lean 4 elaborator as described on Page 2. -/
def Elaborator_witness : Elaborator := {
  name := "Lean 4 elaborator"
  isRobust := true
  isExtensible := true
  isMoreRobustThanPrevious := true
  triesToInferFunctionBodyType := true
}

/-- Whether an elaborator is robust. -/
def Elaborator.isRobustElaborator (el : Elaborator) : Prop :=
  el.isRobust = true

instance (el : Elaborator) : Decidable el.isRobustElaborator :=
  inferInstanceAs (Decidable (el.isRobust = true))

/-- Whether an elaborator is extensible. -/
def Elaborator.isExtensibleElaborator (el : Elaborator) : Prop :=
  el.isExtensible = true

instance (el : Elaborator) : Decidable el.isExtensibleElaborator :=
  inferInstanceAs (Decidable (el.isExtensible = true))

/-- Whether an elaborator is more robust than previous versions. -/
def Elaborator.isMoreRobustThanPreviousVersion (el : Elaborator) : Prop :=
  el.isMoreRobustThanPrevious = true

instance (el : Elaborator) : Decidable el.isMoreRobustThanPreviousVersion :=
  inferInstanceAs (Decidable (el.isMoreRobustThanPrevious = true))

/-- Whether an elaborator is both robust and extensible. -/
def Elaborator.isRobustAndExtensible (el : Elaborator) : Prop :=
  el.isRobustElaborator ∧ el.isExtensibleElaborator

instance (el : Elaborator) : Decidable el.isRobustAndExtensible :=
  inferInstanceAs (Decidable (el.isRobustElaborator ∧ el.isExtensibleElaborator))

/-- Whether an elaborator is more robust than previous versions and extensible. -/
def Elaborator.isMoreRobustAndExtensible (el : Elaborator) : Prop :=
  el.isRobustAndExtensible ∧ el.isMoreRobustThanPreviousVersion

instance (el : Elaborator) : Decidable el.isMoreRobustAndExtensible :=
  inferInstanceAs (Decidable (el.isRobustAndExtensible ∧ el.isMoreRobustThanPreviousVersion))

/-- [Page 2]
"If we do not specify a specific argument type, the elaborator tries to infer the function body's type."

Whether an elaborator tries to infer the function body's type.
-/
def Elaborator.isInferringFunctionBodyType (el : Elaborator) : Prop :=
  el.triesToInferFunctionBodyType = true

instance (el : Elaborator) : Decidable el.isInferringFunctionBodyType :=
  inferInstanceAs (Decidable (el.triesToInferFunctionBodyType = true))

abbrev Elaborator.robust := Elaborator.isRobustElaborator
abbrev Elaborator.extensible := Elaborator.isExtensibleElaborator
abbrev Elaborator.moreRobustThanPrevious := Elaborator.isMoreRobustThanPreviousVersion
abbrev Elaborator.robustAndExtensible := Elaborator.isRobustAndExtensible
abbrev Elaborator.moreRobustAndExtensible := Elaborator.isMoreRobustAndExtensible

/-- [Page 1]
"Lean 4 is a reimplementation of the Lean interactive theorem prover (ITP) in Lean itself."

An interactive theorem prover (ITP) and programming language system.
-/
structure InteractiveTheoremProver where
  name : String
  language : String
  implLanguage : String
  reimplementationOf : Option String := none
  modifiableComponents : List SystemComponent := []
  extensibleComponents : List SystemComponent := []
  macroSystem : Option MacroSystem := none
  typeclassResolution : Option TypeclassResolutionProcedure := none
  isEfficientFunctionalLanguage : Bool := false
  programmingParadigm : Option ProgrammingParadigm := none
  proofAutomationProcedures : List ProofAutomationProcedure := []
  isCodeGenerationCrucial : Bool := false
  startYear : Option Nat := none
  logicalFramework : Option LogicalFramework := none
  standaloneApplications : List StandaloneApplication := []
  primarySuccessFactors : List SuccessFactor := []
  componentsRequiringSourceCodeChange : List SystemComponent := []
  metaprograms : List Metaprogram := []
  primaryInefficiencySource : Option InefficiencySource := none
  isExtensible : Bool := false
  isEfficientProgLanguage : Bool := false
  compiler : Option Compiler := none
  plugins : List Plugin := []
  supportsPluginLoading : Bool := false
  internalDataStructures : List InternalDataStructure := []
  proverPackage : Option ProverPackage := none
  isPlatformForAutomation : Bool := false
  domainSpecificAutomations : List DomainSpecificAutomation := []
  elaborator : Option Elaborator := none
  addressesShortcomingsOfPreviousVersion : Bool := false
  canExtendWithoutChangingSourceCode : Bool := false
  canAddNewFeaturesWithoutChangingSourceCode : Bool := false
  releaseYear : Option Nat := none
  releasePeriod : Option String := none
  isOpenSource : Bool := false
  isPortingLibrary : Bool := false
  hasQuicklyGrowingApplications : Bool := false
  applications : List ProverApplication := []
  deriving Inhabited, DecidableEq, Repr

/-- A system is self-hosted if its implementation language matches its language. -/
def InteractiveTheoremProver.isSelfHosted (itp : InteractiveTheoremProver) : Prop :=
  itp.implLanguage = itp.language

instance (itp : InteractiveTheoremProver) : Decidable itp.isSelfHosted :=
  inferInstanceAs (Decidable (itp.implLanguage = itp.language))

/-- Relates a reimplemented ITP system to an earlier system it reimplements. -/
def InteractiveTheoremProver.isReimplementationOf (newSys oldSys : InteractiveTheoremProver) : Prop :=
  newSys.reimplementationOf = some oldSys.name

instance (newSys oldSys : InteractiveTheoremProver) : Decidable (newSys.isReimplementationOf oldSys) :=
  inferInstanceAs (Decidable (newSys.reimplementationOf = some oldSys.name))

/-- A user can modify a component in an ITP if it is in its list of modifiable components. -/
def InteractiveTheoremProver.canModify (itp : InteractiveTheoremProver) (c : SystemComponent) : Prop :=
  c ∈ itp.modifiableComponents

instance (itp : InteractiveTheoremProver) (c : SystemComponent) : Decidable (itp.canModify c) :=
  inferInstanceAs (Decidable (c ∈ itp.modifiableComponents))

abbrev canModify := InteractiveTheoremProver.canModify

/-- A user can extend a component in an ITP if it is in its list of extensible components. -/
def InteractiveTheoremProver.canExtend (itp : InteractiveTheoremProver) (c : SystemComponent) : Prop :=
  c ∈ itp.extensibleComponents

instance (itp : InteractiveTheoremProver) (c : SystemComponent) : Decidable (itp.canExtend c) :=
  inferInstanceAs (Decidable (c ∈ itp.extensibleComponents))

abbrev canExtend := InteractiveTheoremProver.canExtend

/-- An interactive theorem prover is fully extensible if users can both modify and extend
all of its architectural components. -/
def InteractiveTheoremProver.isFullyExtensible (itp : InteractiveTheoremProver) : Prop :=
  ∀ c : SystemComponent, itp.canModify c ∧ itp.canExtend c

instance (itp : InteractiveTheoremProver) : Decidable itp.isFullyExtensible :=
  if h : (itp.canModify .parser ∧ itp.canExtend .parser) ∧
         (itp.canModify .elaborator ∧ itp.canExtend .elaborator) ∧
         (itp.canModify .tactics ∧ itp.canExtend .tactics) ∧
         (itp.canModify .decisionProcedures ∧ itp.canExtend .decisionProcedures) ∧
         (itp.canModify .prettyPrinter ∧ itp.canExtend .prettyPrinter) ∧
         (itp.canModify .codeGenerator ∧ itp.canExtend .codeGenerator) then
    isTrue (fun c => match c with
      | .parser => h.1
      | .elaborator => h.2.1
      | .tactics => h.2.2.1
      | .decisionProcedures => h.2.2.2.1
      | .prettyPrinter => h.2.2.2.2.1
      | .codeGenerator => h.2.2.2.2.2)
  else
    isFalse (fun h_all => h ⟨h_all .parser, h_all .elaborator, h_all .tactics,
                             h_all .decisionProcedures, h_all .prettyPrinter, h_all .codeGenerator⟩)

abbrev isFullyExtensible := InteractiveTheoremProver.isFullyExtensible

/-- Whether an ITP has an associated macro system. -/
def InteractiveTheoremProver.hasMacroSystem (itp : InteractiveTheoremProver) : Prop :=
  itp.macroSystem.isSome

instance (itp : InteractiveTheoremProver) : Decidable itp.hasMacroSystem :=
  inferInstanceAs (Decidable itp.macroSystem.isSome)

abbrev hasMacroSystem := InteractiveTheoremProver.hasMacroSystem

/-- Whether an ITP has a hygienic macro system. -/
def InteractiveTheoremProver.hasHygienicMacroSystem (itp : InteractiveTheoremProver) : Prop :=
  ∃ ms, itp.macroSystem = some ms ∧ ms.isHygienic = true

instance (itp : InteractiveTheoremProver) : Decidable itp.hasHygienicMacroSystem :=
  match h : itp.macroSystem with
  | some ms =>
    if h_hyg : ms.isHygienic = true then
      isTrue ⟨ms, h, h_hyg⟩
    else
      isFalse (by
        intro ⟨ms', h_eq, h_ms'_hyg⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_hyg h_ms'_hyg)
  | none =>
    isFalse (by
      intro ⟨ms', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

abbrev hasHygienicMacroSystem := InteractiveTheoremProver.hasHygienicMacroSystem

/-- Whether an ITP has a macro system custom-built for ITPs. -/
def InteractiveTheoremProver.hasMacroSystemCustomBuiltForITPs (itp : InteractiveTheoremProver) : Prop :=
  ∃ ms, itp.macroSystem = some ms ∧ ms.customBuiltForITPs = true

instance (itp : InteractiveTheoremProver) : Decidable itp.hasMacroSystemCustomBuiltForITPs :=
  match h : itp.macroSystem with
  | some ms =>
    if h_cb : ms.customBuiltForITPs = true then
      isTrue ⟨ms, h, h_cb⟩
    else
      isFalse (by
        intro ⟨ms', h_eq, h_ms'_cb⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_cb h_ms'_cb)
  | none =>
    isFalse (by
      intro ⟨ms', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

abbrev hasMacroSystemCustomBuiltForITPs := InteractiveTheoremProver.hasMacroSystemCustomBuiltForITPs

/-- Whether an ITP has a hygienic macro system custom-built for ITPs. -/
def InteractiveTheoremProver.hasHygienicMacroSystemCustomBuiltForITPs (itp : InteractiveTheoremProver) : Prop :=
  ∃ ms, itp.macroSystem = some ms ∧ ms.isHygienic = true ∧ ms.customBuiltForITPs = true

instance (itp : InteractiveTheoremProver) : Decidable itp.hasHygienicMacroSystemCustomBuiltForITPs :=
  match h : itp.macroSystem with
  | some ms =>
    if h_both : ms.isHygienic = true ∧ ms.customBuiltForITPs = true then
      isTrue ⟨ms, h, h_both.1, h_both.2⟩
    else
      isFalse (by
        intro ⟨ms', h_eq, h_hyg, h_cb⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_both ⟨h_hyg, h_cb⟩)
  | none =>
    isFalse (by
      intro ⟨ms', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

abbrev hasHygienicMacroSystemCustomBuiltForITPs := InteractiveTheoremProver.hasHygienicMacroSystemCustomBuiltForITPs

/-- Whether an ITP has an associated typeclass resolution procedure. -/
def InteractiveTheoremProver.hasTypeclassResolution (itp : InteractiveTheoremProver) : Prop :=
  itp.typeclassResolution.isSome

instance (itp : InteractiveTheoremProver) : Decidable itp.hasTypeclassResolution :=
  inferInstanceAs (Decidable itp.typeclassResolution.isSome)

abbrev hasTypeclassResolution := InteractiveTheoremProver.hasTypeclassResolution

/-- Whether an ITP has a typeclass resolution procedure based on tabled resolution. -/
def InteractiveTheoremProver.hasTabledTypeclassResolution (itp : InteractiveTheoremProver) : Prop :=
  ∃ tr, itp.typeclassResolution = some tr ∧ tr.isTabled = true

instance (itp : InteractiveTheoremProver) : Decidable itp.hasTabledTypeclassResolution :=
  match h : itp.typeclassResolution with
  | some tr =>
    if h_t : tr.isTabled = true then
      isTrue ⟨tr, h, h_t⟩
    else
      isFalse (by
        intro ⟨tr', h_eq, h_tr'_t⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_t h_tr'_t)
  | none =>
    isFalse (by
      intro ⟨tr', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

abbrev hasTabledTypeclassResolution := InteractiveTheoremProver.hasTabledTypeclassResolution

/-- Whether an ITP has a new typeclass resolution procedure. -/
def InteractiveTheoremProver.hasNewTypeclassResolution (itp : InteractiveTheoremProver) : Prop :=
  ∃ tr, itp.typeclassResolution = some tr ∧ tr.isNew = true

instance (itp : InteractiveTheoremProver) : Decidable itp.hasNewTypeclassResolution :=
  match h : itp.typeclassResolution with
  | some tr =>
    if h_n : tr.isNew = true then
      isTrue ⟨tr, h, h_n⟩
    else
      isFalse (by
        intro ⟨tr', h_eq, h_tr'_n⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_n h_tr'_n)
  | none =>
    isFalse (by
      intro ⟨tr', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

abbrev hasNewTypeclassResolution := InteractiveTheoremProver.hasNewTypeclassResolution

/-- Whether an ITP has a typeclass resolution procedure addressing performance problems. -/
def InteractiveTheoremProver.addressesTypeclassPerformanceProblems (itp : InteractiveTheoremProver) : Prop :=
  ∃ tr, itp.typeclassResolution = some tr ∧ tr.addressesPerformanceProblems = true

instance (itp : InteractiveTheoremProver) : Decidable itp.addressesTypeclassPerformanceProblems :=
  match h : itp.typeclassResolution with
  | some tr =>
    if h_p : tr.addressesPerformanceProblems = true then
      isTrue ⟨tr, h, h_p⟩
    else
      isFalse (by
        intro ⟨tr', h_eq, h_tr'_p⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_p h_tr'_p)
  | none =>
    isFalse (by
      intro ⟨tr', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

abbrev addressesTypeclassPerformanceProblems := InteractiveTheoremProver.addressesTypeclassPerformanceProblems

/-- Whether an ITP has a new typeclass resolution procedure based on tabled resolution,
addressing performance problems. -/
def InteractiveTheoremProver.hasNewTabledResolutionAddressingPerformance (itp : InteractiveTheoremProver) : Prop :=
  ∃ tr, itp.typeclassResolution = some tr ∧ tr.isTabled = true ∧ tr.isNew = true ∧ tr.addressesPerformanceProblems = true

instance (itp : InteractiveTheoremProver) : Decidable itp.hasNewTabledResolutionAddressingPerformance :=
  match h : itp.typeclassResolution with
  | some tr =>
    if h_all : tr.isTabled = true ∧ tr.isNew = true ∧ tr.addressesPerformanceProblems = true then
      isTrue ⟨tr, h, h_all.1, h_all.2.1, h_all.2.2⟩
    else
      isFalse (by
        intro ⟨tr', h_eq, ht, hn, hp⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_all ⟨ht, hn, hp⟩)
  | none =>
    isFalse (by
      intro ⟨tr', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

abbrev hasNewTabledResolutionAddressingPerformance := InteractiveTheoremProver.hasNewTabledResolutionAddressingPerformance

/-- Whether an ITP has an associated programming paradigm. -/
def InteractiveTheoremProver.hasProgrammingParadigm (itp : InteractiveTheoremProver) : Prop :=
  itp.programmingParadigm.isSome

instance (itp : InteractiveTheoremProver) : Decidable itp.hasProgrammingParadigm :=
  inferInstanceAs (Decidable itp.programmingParadigm.isSome)

abbrev hasProgrammingParadigm := InteractiveTheoremProver.hasProgrammingParadigm

/-- Whether an ITP is based on a novel programming paradigm. -/
def InteractiveTheoremProver.hasNovelProgrammingParadigm (itp : InteractiveTheoremProver) : Prop :=
  ∃ p, itp.programmingParadigm = some p ∧ p.isNovel = true

instance (itp : InteractiveTheoremProver) : Decidable itp.hasNovelProgrammingParadigm :=
  match h : itp.programmingParadigm with
  | some p =>
    if h_nov : p.isNovel = true then
      isTrue ⟨p, h, h_nov⟩
    else
      isFalse (by
        intro ⟨p', h_eq, h_p'_nov⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_nov h_p'_nov)
  | none =>
    isFalse (by
      intro ⟨p', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

abbrev hasNovelProgrammingParadigm := InteractiveTheoremProver.hasNovelProgrammingParadigm

/-- Whether an ITP is based on the programming paradigm called "functional but in-place". -/
def InteractiveTheoremProver.isFunctionalButInPlace (itp : InteractiveTheoremProver) : Prop :=
  ∃ p, itp.programmingParadigm = some p ∧ p.name = "functional but in-place"

instance (itp : InteractiveTheoremProver) : Decidable itp.isFunctionalButInPlace :=
  match h : itp.programmingParadigm with
  | some p =>
    if h_name : p.name = "functional but in-place" then
      isTrue ⟨p, h, h_name⟩
    else
      isFalse (by
        intro ⟨p', h_eq, h_p'_name⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_name h_p'_name)
  | none =>
    isFalse (by
      intro ⟨p', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

abbrev isFunctionalButInPlace := InteractiveTheoremProver.isFunctionalButInPlace

/-- Whether an ITP is based on a novel programming paradigm called "functional but in-place". -/
def InteractiveTheoremProver.isNovelFunctionalButInPlace (itp : InteractiveTheoremProver) : Prop :=
  ∃ p, itp.programmingParadigm = some p ∧ p.name = "functional but in-place" ∧ p.isNovel = true

instance (itp : InteractiveTheoremProver) : Decidable itp.isNovelFunctionalButInPlace :=
  match h : itp.programmingParadigm with
  | some p =>
    if h_both : p.name = "functional but in-place" ∧ p.isNovel = true then
      isTrue ⟨p, h, h_both.1, h_both.2⟩
    else
      isFalse (by
        intro ⟨p', h_eq, h_name, h_nov⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_both ⟨h_name, h_nov⟩)
  | none =>
    isFalse (by
      intro ⟨p', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

abbrev isNovelFunctionalButInPlace := InteractiveTheoremProver.isNovelFunctionalButInPlace

/-- Whether an ITP is an efficient functional programming language. -/
def InteractiveTheoremProver.isEfficientFunctional (itp : InteractiveTheoremProver) : Prop :=
  itp.isEfficientFunctionalLanguage = true

instance (itp : InteractiveTheoremProver) : Decidable itp.isEfficientFunctional :=
  inferInstanceAs (Decidable (itp.isEfficientFunctionalLanguage = true))

abbrev isEfficientFunctional := InteractiveTheoremProver.isEfficientFunctional

/-- Whether a proof automation procedure is custom-written. -/
def ProofAutomationProcedure.isCustomProcedure (proc : ProofAutomationProcedure) : Prop :=
  proc.isCustom = true

instance (proc : ProofAutomationProcedure) : Decidable proc.isCustomProcedure :=
  inferInstanceAs (Decidable (proc.isCustom = true))

/-- Whether a proof automation procedure is implemented in the language of a given ITP. -/
def ProofAutomationProcedure.isImplementedIn (proc : ProofAutomationProcedure) (itp : InteractiveTheoremProver) : Prop :=
  proc.language = itp.language

instance (proc : ProofAutomationProcedure) (itp : InteractiveTheoremProver) : Decidable (proc.isImplementedIn itp) :=
  inferInstanceAs (Decidable (proc.language = itp.language))

/-- Whether a proof automation procedure is efficient. -/
def ProofAutomationProcedure.isEfficientAutomation (proc : ProofAutomationProcedure) : Prop :=
  proc.isEfficient = true

instance (proc : ProofAutomationProcedure) : Decidable proc.isEfficientAutomation :=
  inferInstanceAs (Decidable (proc.isEfficient = true))

/-- Whether users write custom proof automation in the prover's own language. -/
def InteractiveTheoremProver.hasCustomProofAutomationInSelf (itp : InteractiveTheoremProver) : Prop :=
  ∃ p ∈ itp.proofAutomationProcedures, p.isCustom = true ∧ p.language = itp.language

instance (itp : InteractiveTheoremProver) : Decidable itp.hasCustomProofAutomationInSelf :=
  inferInstanceAs (Decidable (∃ p ∈ itp.proofAutomationProcedures, p.isCustom = true ∧ p.language = itp.language))

abbrev hasCustomProofAutomationInSelf := InteractiveTheoremProver.hasCustomProofAutomationInSelf

/-- Whether efficient code generation is crucial for users of the prover. -/
def InteractiveTheoremProver.isEfficientCodeGenerationCrucial (itp : InteractiveTheoremProver) : Prop :=
  itp.isCodeGenerationCrucial = true

instance (itp : InteractiveTheoremProver) : Decidable itp.isEfficientCodeGenerationCrucial :=
  inferInstanceAs (Decidable (itp.isCodeGenerationCrucial = true))

abbrev isEfficientCodeGenerationCrucial := InteractiveTheoremProver.isEfficientCodeGenerationCrucial

/-- Whether an ITP project was started in a given year. -/
def InteractiveTheoremProver.startedIn (itp : InteractiveTheoremProver) (year : Nat) : Prop :=
  itp.startYear = some year

instance (itp : InteractiveTheoremProver) (year : Nat) : Decidable (itp.startedIn year) :=
  inferInstanceAs (Decidable (itp.startYear = some year))

/-- Whether an ITP is based on the Calculus of Inductive Constructions (CIC). -/
def InteractiveTheoremProver.isBasedOnCIC (itp : InteractiveTheoremProver) : Prop :=
  itp.logicalFramework = some .cic

instance (itp : InteractiveTheoremProver) : Decidable itp.isBasedOnCIC :=
  inferInstanceAs (Decidable (itp.logicalFramework = some .cic))

abbrev isBasedOnCIC := InteractiveTheoremProver.isBasedOnCIC

/-- Whether an ITP's metaprograms were instrumental in building a standalone application. -/
def InteractiveTheoremProver.metaprogramsInstrumentalFor (itp : InteractiveTheoremProver) (app : StandaloneApplication) : Prop :=
  app ∈ itp.standaloneApplications ∧ app.isBuiltUsingMetaprograms

instance (itp : InteractiveTheoremProver) (app : StandaloneApplication) : Decidable (itp.metaprogramsInstrumentalFor app) :=
  inferInstanceAs (Decidable (app ∈ itp.standaloneApplications ∧ app.isBuiltUsingMetaprograms))

/-- Whether an ITP's metaprograms have been instrumental in building standalone applications. -/
def InteractiveTheoremProver.hasInstrumentalMetaprogramsForApplications (itp : InteractiveTheoremProver) : Prop :=
  ∃ app ∈ itp.standaloneApplications, app.isBuiltUsingMetaprograms

instance (itp : InteractiveTheoremProver) : Decidable itp.hasInstrumentalMetaprogramsForApplications :=
  inferInstanceAs (Decidable (∃ app ∈ itp.standaloneApplications, app.isBuiltUsingMetaprograms))

/-- Whether a standalone application was built using metaprograms from a specific prover. -/
def StandaloneApplication.isBuiltUsingProverMetaprograms (app : StandaloneApplication) (itp : InteractiveTheoremProver) : Prop :=
  app.isBuiltUsingMetaprograms ∧ app.metaprogramProver = some itp.name

instance (app : StandaloneApplication) (itp : InteractiveTheoremProver) : Decidable (app.isBuiltUsingProverMetaprograms itp) :=
  inferInstanceAs (Decidable (app.isBuiltUsingMetaprograms ∧ app.metaprogramProver = some itp.name))

/-- Whether an ITP's success is attributed to a specific primary success factor. -/
def InteractiveTheoremProver.hasPrimarySuccessFactor (itp : InteractiveTheoremProver) (factor : SuccessFactor) : Prop :=
  factor ∈ itp.primarySuccessFactors

instance (itp : InteractiveTheoremProver) (factor : SuccessFactor) : Decidable (itp.hasPrimarySuccessFactor factor) :=
  inferInstanceAs (Decidable (factor ∈ itp.primarySuccessFactors))

/-- Whether an ITP's success is primarily due to both extensibility capabilities and its metaprogramming framework. -/
def InteractiveTheoremProver.successDueToExtensibilityAndMetaprogramming (itp : InteractiveTheoremProver) : Prop :=
  itp.hasPrimarySuccessFactor .extensibilityCapabilities ∧
  itp.hasPrimarySuccessFactor .metaprogrammingFramework

instance (itp : InteractiveTheoremProver) : Decidable itp.successDueToExtensibilityAndMetaprogramming :=
  inferInstanceAs (Decidable (itp.hasPrimarySuccessFactor .extensibilityCapabilities ∧
                             itp.hasPrimarySuccessFactor .metaprogrammingFramework))

/-- Whether a user cannot modify a system component in an ITP without changing source code. -/
def InteractiveTheoremProver.cannotModifyWithoutChangingSourceCode (itp : InteractiveTheoremProver) (c : SystemComponent) : Prop :=
  c ∈ itp.componentsRequiringSourceCodeChange

instance (itp : InteractiveTheoremProver) (c : SystemComponent) : Decidable (itp.cannotModifyWithoutChangingSourceCode c) :=
  inferInstanceAs (Decidable (c ∈ itp.componentsRequiringSourceCodeChange))

/-- Whether modifying a component requires changing source code written in a specific implementation language. -/
def InteractiveTheoremProver.cannotModifyWithoutChangingSourceCodeIn (itp : InteractiveTheoremProver) (lang : ProgrammingLanguage) (c : SystemComponent) : Prop :=
  itp.implLanguage = lang.name ∧ itp.cannotModifyWithoutChangingSourceCode c

instance (itp : InteractiveTheoremProver) (lang : ProgrammingLanguage) (c : SystemComponent) : Decidable (itp.cannotModifyWithoutChangingSourceCodeIn lang c) :=
  inferInstanceAs (Decidable (itp.implLanguage = lang.name ∧ itp.cannotModifyWithoutChangingSourceCode c))

/-- Whether an ITP has components that users cannot modify without changing source code written in C++. -/
def InteractiveTheoremProver.hasComponentsRequiringCppSourceChange (itp : InteractiveTheoremProver) : Prop :=
  ∃ c ∈ itp.componentsRequiringSourceCodeChange, itp.cannotModifyWithoutChangingSourceCodeIn cppLanguage_witness c

instance (itp : InteractiveTheoremProver) : Decidable itp.hasComponentsRequiringCppSourceChange :=
  inferInstanceAs (Decidable (∃ c ∈ itp.componentsRequiringSourceCodeChange, itp.cannotModifyWithoutChangingSourceCodeIn cppLanguage_witness c))

/-- Whether an ITP contains proof automation metaprograms that are not competitive
with compiled implementations. -/
def InteractiveTheoremProver.hasNonCompetitiveProofAutomation (itp : InteractiveTheoremProver) : Prop :=
  ∃ mp ∈ itp.metaprograms, mp.isNotCompetitiveWithCompiled

instance (itp : InteractiveTheoremProver) : Decidable itp.hasNonCompetitiveProofAutomation :=
  inferInstanceAs (Decidable (∃ mp ∈ itp.metaprograms, mp.isNotCompetitiveWithCompiled))

/-- Relates proof automation metaprograms lacking competitiveness to a programming language
possessing an efficient compiler. -/
def InteractiveTheoremProver.proofAutomationNotCompetitiveWith (itp : InteractiveTheoremProver) (lang : ProgrammingLanguage) : Prop :=
  lang.hasAnEfficientCompiler ∧ itp.hasNonCompetitiveProofAutomation

instance (itp : InteractiveTheoremProver) (lang : ProgrammingLanguage) : Decidable (itp.proofAutomationNotCompetitiveWith lang) :=
  inferInstanceAs (Decidable (lang.hasAnEfficientCompiler ∧ itp.hasNonCompetitiveProofAutomation))

/-- Whether an ITP designates a specific source as its primary source of inefficiency in metaprograms. -/
def InteractiveTheoremProver.hasPrimaryInefficiencySource (itp : InteractiveTheoremProver) (src : InefficiencySource) : Prop :=
  itp.primaryInefficiencySource = some src

instance (itp : InteractiveTheoremProver) (src : InefficiencySource) : Decidable (itp.hasPrimaryInefficiencySource src) :=
  inferInstanceAs (Decidable (itp.primaryInefficiencySource = some src))

/-- Whether the virtual machine interpretation overhead is the primary source of inefficiency
in an ITP's metaprograms. -/
def InteractiveTheoremProver.isVMInterpretationOverheadPrimaryInefficiency (itp : InteractiveTheoremProver) : Prop :=
  itp.hasPrimaryInefficiencySource .virtualMachineInterpretationOverhead

instance (itp : InteractiveTheoremProver) : Decidable itp.isVMInterpretationOverheadPrimaryInefficiency :=
  inferInstanceAs (Decidable (itp.hasPrimaryInefficiencySource .virtualMachineInterpretationOverhead))

/-- [Page 2]
"It is an extensible theorem prover and an efficient programming language."

Whether an ITP is an extensible theorem prover.
Hierarchically composed from explicit extensibility or full extensibility across all components.
-/
def InteractiveTheoremProver.isExtensibleTheoremProver (itp : InteractiveTheoremProver) : Prop :=
  itp.isExtensible = true ∨ itp.isFullyExtensible

instance (itp : InteractiveTheoremProver) : Decidable itp.isExtensibleTheoremProver :=
  inferInstanceAs (Decidable (itp.isExtensible = true ∨ itp.isFullyExtensible))

/-- [Page 2]
"It is an extensible theorem prover and an efficient programming language."

Whether an ITP is an efficient programming language.
Hierarchically composed from explicit efficient programming language or efficient functional language.
-/
def InteractiveTheoremProver.isEfficientProgrammingLanguage (itp : InteractiveTheoremProver) : Prop :=
  itp.isEfficientProgLanguage = true ∨ itp.isEfficientFunctional

instance (itp : InteractiveTheoremProver) : Decidable itp.isEfficientProgrammingLanguage :=
  inferInstanceAs (Decidable (itp.isEfficientProgLanguage = true ∨ itp.isEfficientFunctional))

/-- [Page 2]
"The new compiler produces C code, and users can now implement efficient proof automation in Lean, compile it into efficient C code, and load it as a plugin."

Whether an ITP has an associated compiler.
-/
def InteractiveTheoremProver.hasCompiler (itp : InteractiveTheoremProver) : Prop :=
  itp.compiler.isSome

instance (itp : InteractiveTheoremProver) : Decidable itp.hasCompiler :=
  inferInstanceAs (Decidable itp.compiler.isSome)

/-- Whether an ITP has a new compiler. -/
def InteractiveTheoremProver.hasNewCompiler (itp : InteractiveTheoremProver) : Prop :=
  ∃ c, itp.compiler = some c ∧ c.isNewCompiler

instance (itp : InteractiveTheoremProver) : Decidable itp.hasNewCompiler :=
  match h : itp.compiler with
  | some c =>
    if hc : c.isNewCompiler then
      isTrue ⟨c, h, hc⟩
    else
      isFalse (by
        intro ⟨c', heq, hc'⟩
        rw [h] at heq
        injection heq with heq'
        subst heq'
        exact hc hc')
  | none =>
    isFalse (by
      intro ⟨c', heq, _⟩
      rw [h] at heq
      contradiction)

/-- Whether an ITP's compiler produces a given target language. -/
def InteractiveTheoremProver.compilerProducesTargetLanguage (itp : InteractiveTheoremProver) (lang : String) : Prop :=
  ∃ c, itp.compiler = some c ∧ c.producesTargetLanguage lang

instance (itp : InteractiveTheoremProver) (lang : String) : Decidable (itp.compilerProducesTargetLanguage lang) :=
  match h : itp.compiler with
  | some c =>
    if hc : c.producesTargetLanguage lang then
      isTrue ⟨c, h, hc⟩
    else
      isFalse (by
        intro ⟨c', heq, hc'⟩
        rw [h] at heq
        injection heq with heq'
        subst heq'
        exact hc hc')
  | none =>
    isFalse (by
      intro ⟨c', heq, _⟩
      rw [h] at heq
      contradiction)

/-- Whether an ITP's compiler produces C code. -/
def InteractiveTheoremProver.compilerProducesCCode (itp : InteractiveTheoremProver) : Prop :=
  itp.compilerProducesTargetLanguage "C"

instance (itp : InteractiveTheoremProver) : Decidable itp.compilerProducesCCode :=
  inferInstanceAs (Decidable (itp.compilerProducesTargetLanguage "C"))

/-- Whether an ITP's compiler produces a given programming language. -/
def InteractiveTheoremProver.compilerProducesLanguage (itp : InteractiveTheoremProver) (lang : ProgrammingLanguage) : Prop :=
  ∃ c ∈ itp.compiler, c.producesLanguage lang

instance (itp : InteractiveTheoremProver) (lang : ProgrammingLanguage) : Decidable (itp.compilerProducesLanguage lang) :=
  inferInstanceAs (Decidable (∃ c ∈ itp.compiler, c.producesLanguage lang))

/-- Whether an ITP has the capability to load plugins. -/
def InteractiveTheoremProver.canLoadPlugins (itp : InteractiveTheoremProver) : Prop :=
  itp.supportsPluginLoading = true

instance (itp : InteractiveTheoremProver) : Decidable itp.canLoadPlugins :=
  inferInstanceAs (Decidable (itp.supportsPluginLoading = true))

/-- Whether an ITP can load a specific plugin. -/
def InteractiveTheoremProver.canLoadPlugin (itp : InteractiveTheoremProver) (p : Plugin) : Prop :=
  itp.canLoadPlugins ∧ p ∈ itp.plugins

instance (itp : InteractiveTheoremProver) (p : Plugin) : Decidable (itp.canLoadPlugin p) :=
  inferInstanceAs (Decidable (itp.canLoadPlugins ∧ p ∈ itp.plugins))

/-- Whether users can implement efficient proof automation in a language for the prover.
Defaults to the prover's own language. -/
def InteractiveTheoremProver.canImplementEfficientProofAutomationIn (itp : InteractiveTheoremProver) (lang : String := itp.language) : Prop :=
  ∃ p ∈ itp.proofAutomationProcedures, p.isEfficientAutomation ∧ p.language = lang

instance (itp : InteractiveTheoremProver) (lang : String) : Decidable (itp.canImplementEfficientProofAutomationIn lang) :=
  inferInstanceAs (Decidable (∃ p ∈ itp.proofAutomationProcedures, p.isEfficientAutomation ∧ p.language = lang))

/-- Whether a prover package exports all internal data structures of a given ITP. -/
def ProverPackage.exportsAllInternalDataStructuresOf (pkg : ProverPackage) (itp : InteractiveTheoremProver) : Prop :=
  pkg.exportsAllInternalDataStructures ∧ (∀ ids ∈ itp.internalDataStructures, ids ∈ pkg.exportedDataStructures)

instance (pkg : ProverPackage) (itp : InteractiveTheoremProver) : Decidable (pkg.exportsAllInternalDataStructuresOf itp) :=
  inferInstanceAs (Decidable (pkg.exportsAllInternalDataStructures ∧ (∀ ids ∈ itp.internalDataStructures, ids ∈ pkg.exportedDataStructures)))

/-- [Page 2]
"In Lean 4, users can access all internal data structures used to implement Lean by merely importing the Lean package."

Whether users can access all internal data structures used to implement the prover by importing a given prover package.
-/
def InteractiveTheoremProver.canAccessInternalDataStructuresByImporting (itp : InteractiveTheoremProver) (pkg : ProverPackage) : Prop :=
  itp.proverPackage = some pkg ∧ pkg.exportsAllInternalDataStructuresOf itp

instance (itp : InteractiveTheoremProver) (pkg : ProverPackage) : Decidable (itp.canAccessInternalDataStructuresByImporting pkg) :=
  inferInstanceAs (Decidable (itp.proverPackage = some pkg ∧ pkg.exportsAllInternalDataStructuresOf itp))

/-- Whether users can access a specific internal data structure used in implementation by importing a prover package. -/
def InteractiveTheoremProver.canAccessInternalDataStructure (itp : InteractiveTheoremProver) (pkg : ProverPackage) (ids : InternalDataStructure) : Prop :=
  itp.proverPackage = some pkg ∧ ids ∈ itp.internalDataStructures ∧ pkg.exportsDataStructure ids

instance (itp : InteractiveTheoremProver) (pkg : ProverPackage) (ids : InternalDataStructure) : Decidable (itp.canAccessInternalDataStructure pkg ids) :=
  inferInstanceAs (Decidable (itp.proverPackage = some pkg ∧ ids ∈ itp.internalDataStructures ∧ pkg.exportsDataStructure ids))

/-- Whether an ITP provides access to all its internal data structures by importing some package. -/
def InteractiveTheoremProver.hasAccessToAllInternalDataStructures (itp : InteractiveTheoremProver) : Prop :=
  ∃ pkg, itp.canAccessInternalDataStructuresByImporting pkg

instance (itp : InteractiveTheoremProver) : Decidable itp.hasAccessToAllInternalDataStructures :=
  match h : itp.proverPackage with
  | some pkg =>
    if hp : pkg.exportsAllInternalDataStructuresOf itp then
      isTrue ⟨pkg, h, hp⟩
    else
      isFalse (by
        intro ⟨pkg', heq, hp'⟩
        rw [h] at heq
        injection heq with heq'
        subst heq'
        exact hp hp')
  | none =>
    isFalse (by
      intro ⟨pkg', heq, _⟩
      rw [h] at heq
      contradiction)

/-- [Page 2]
"Lean 4 is also a platform for developing efficient domain-specific automation."

Whether an ITP is a platform for domain-specific automation.
-/
def InteractiveTheoremProver.isPlatformForDomainSpecificAutomation (itp : InteractiveTheoremProver) : Prop :=
  itp.isPlatformForAutomation = true

instance (itp : InteractiveTheoremProver) : Decidable itp.isPlatformForDomainSpecificAutomation :=
  inferInstanceAs (Decidable (itp.isPlatformForAutomation = true))

/-- Whether an ITP has efficient domain-specific automation. -/
def InteractiveTheoremProver.hasEfficientDomainSpecificAutomation (itp : InteractiveTheoremProver) : Prop :=
  ∃ dsa ∈ itp.domainSpecificAutomations, dsa.isEfficientAutomation

instance (itp : InteractiveTheoremProver) : Decidable itp.hasEfficientDomainSpecificAutomation :=
  inferInstanceAs (Decidable (∃ dsa ∈ itp.domainSpecificAutomations, dsa.isEfficientAutomation))

/-- Whether an ITP is a platform for developing efficient domain-specific automation. -/
def InteractiveTheoremProver.isPlatformForDevelopingEfficientDomainSpecificAutomation (itp : InteractiveTheoremProver) : Prop :=
  itp.isPlatformForDomainSpecificAutomation ∧ itp.hasEfficientDomainSpecificAutomation

instance (itp : InteractiveTheoremProver) : Decidable itp.isPlatformForDevelopingEfficientDomainSpecificAutomation :=
  inferInstanceAs (Decidable (itp.isPlatformForDomainSpecificAutomation ∧ itp.hasEfficientDomainSpecificAutomation))

/-- [Page 2]
"It has a more robust and extensible elaborator, and addresses many other shortcomings of Lean 3."

Whether an ITP has an associated elaborator.
-/
def InteractiveTheoremProver.hasElaborator (itp : InteractiveTheoremProver) : Prop :=
  itp.elaborator.isSome

instance (itp : InteractiveTheoremProver) : Decidable itp.hasElaborator :=
  inferInstanceAs (Decidable itp.elaborator.isSome)

/-- Whether an ITP has a robust elaborator. -/
def InteractiveTheoremProver.hasRobustElaborator (itp : InteractiveTheoremProver) : Prop :=
  ∃ el, itp.elaborator = some el ∧ el.isRobustElaborator

instance (itp : InteractiveTheoremProver) : Decidable itp.hasRobustElaborator :=
  match h : itp.elaborator with
  | some el =>
    if h_r : el.isRobustElaborator then
      isTrue ⟨el, h, h_r⟩
    else
      isFalse (by
        intro ⟨el', h_eq, h_r'⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_r h_r')
  | none =>
    isFalse (by
      intro ⟨el', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

/-- Whether an ITP has an extensible elaborator. -/
def InteractiveTheoremProver.hasExtensibleElaborator (itp : InteractiveTheoremProver) : Prop :=
  ∃ el, itp.elaborator = some el ∧ el.isExtensibleElaborator

instance (itp : InteractiveTheoremProver) : Decidable itp.hasExtensibleElaborator :=
  match h : itp.elaborator with
  | some el =>
    if h_e : el.isExtensibleElaborator then
      isTrue ⟨el, h, h_e⟩
    else
      isFalse (by
        intro ⟨el', h_eq, h_e'⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_e h_e')
  | none =>
    isFalse (by
      intro ⟨el', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

/-- Whether an ITP has an elaborator that is more robust than previous versions. -/
def InteractiveTheoremProver.hasMoreRobustElaborator (itp : InteractiveTheoremProver) : Prop :=
  ∃ el, itp.elaborator = some el ∧ el.isMoreRobustThanPreviousVersion

instance (itp : InteractiveTheoremProver) : Decidable itp.hasMoreRobustElaborator :=
  match h : itp.elaborator with
  | some el =>
    if h_mr : el.isMoreRobustThanPreviousVersion then
      isTrue ⟨el, h, h_mr⟩
    else
      isFalse (by
        intro ⟨el', h_eq, h_mr'⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_mr h_mr')
  | none =>
    isFalse (by
      intro ⟨el', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

/-- Whether an ITP has a robust and extensible elaborator. -/
def InteractiveTheoremProver.hasRobustAndExtensibleElaborator (itp : InteractiveTheoremProver) : Prop :=
  ∃ el, itp.elaborator = some el ∧ el.isRobustAndExtensible

instance (itp : InteractiveTheoremProver) : Decidable itp.hasRobustAndExtensibleElaborator :=
  match h : itp.elaborator with
  | some el =>
    if h_re : el.isRobustAndExtensible then
      isTrue ⟨el, h, h_re⟩
    else
      isFalse (by
        intro ⟨el', h_eq, h_re'⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_re h_re')
  | none =>
    isFalse (by
      intro ⟨el', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

/-- Whether an ITP has an elaborator that is more robust than previous versions and extensible. -/
def InteractiveTheoremProver.hasMoreRobustAndExtensibleElaborator (itp : InteractiveTheoremProver) : Prop :=
  ∃ el, itp.elaborator = some el ∧ el.isMoreRobustAndExtensible

instance (itp : InteractiveTheoremProver) : Decidable itp.hasMoreRobustAndExtensibleElaborator :=
  match h : itp.elaborator with
  | some el =>
    if h_re : el.isMoreRobustAndExtensible then
      isTrue ⟨el, h, h_re⟩
    else
      isFalse (by
        intro ⟨el', h_eq, h_re'⟩
        rw [h] at h_eq
        injection h_eq with h_eq'
        subst h_eq'
        exact h_re h_re')
  | none =>
    isFalse (by
      intro ⟨el', h_eq, _⟩
      rw [h] at h_eq
      contradiction)

/-- Whether an ITP addresses shortcomings of previous versions. -/
def InteractiveTheoremProver.addressesShortcomingsOfPrevious (itp : InteractiveTheoremProver) : Prop :=
  itp.addressesShortcomingsOfPreviousVersion = true

instance (itp : InteractiveTheoremProver) : Decidable itp.addressesShortcomingsOfPrevious :=
  inferInstanceAs (Decidable (itp.addressesShortcomingsOfPreviousVersion = true))

/-- Whether an ITP addresses shortcomings of Lean 3. -/
def InteractiveTheoremProver.addressesShortcomingsOfLean3 (itp : InteractiveTheoremProver) : Prop :=
  itp.addressesShortcomingsOfPrevious

instance (itp : InteractiveTheoremProver) : Decidable itp.addressesShortcomingsOfLean3 :=
  inferInstanceAs (Decidable itp.addressesShortcomingsOfPrevious)

/-- [Page 2]
"We expect the Lean community to extend and add new features without having to change the Lean source code."

Whether users or community can extend the ITP without changing its source code.
-/
def InteractiveTheoremProver.canExtendWithoutChangingSource (itp : InteractiveTheoremProver) : Prop :=
  itp.canExtendWithoutChangingSourceCode = true

instance (itp : InteractiveTheoremProver) : Decidable itp.canExtendWithoutChangingSource :=
  inferInstanceAs (Decidable (itp.canExtendWithoutChangingSourceCode = true))

/-- Whether users or community can add new features without changing the ITP source code. -/
def InteractiveTheoremProver.canAddNewFeaturesWithoutChangingSource (itp : InteractiveTheoremProver) : Prop :=
  itp.canAddNewFeaturesWithoutChangingSourceCode = true

instance (itp : InteractiveTheoremProver) : Decidable itp.canAddNewFeaturesWithoutChangingSource :=
  inferInstanceAs (Decidable (itp.canAddNewFeaturesWithoutChangingSourceCode = true))

/-- Whether the community can both extend and add new features without changing the Lean source code. -/
def InteractiveTheoremProver.communityCanExtendAndAddNewFeaturesWithoutChangingSourceCode (itp : InteractiveTheoremProver) : Prop :=
  itp.canExtendWithoutChangingSource ∧ itp.canAddNewFeaturesWithoutChangingSource

instance (itp : InteractiveTheoremProver) : Decidable itp.communityCanExtendAndAddNewFeaturesWithoutChangingSourceCode :=
  inferInstanceAs (Decidable (itp.canExtendWithoutChangingSource ∧ itp.canAddNewFeaturesWithoutChangingSource))

/-- [Page 2]
"We released Lean 4 at the beginning of 2021, it is open source, the community is already porting mathlib, and the number of applications is quickly growing."

Whether an ITP was released in a specific year.
-/
def InteractiveTheoremProver.releasedInYear (itp : InteractiveTheoremProver) (year : Nat) : Prop :=
  itp.releaseYear = some year

instance (itp : InteractiveTheoremProver) (year : Nat) : Decidable (itp.releasedInYear year) :=
  inferInstanceAs (Decidable (itp.releaseYear = some year))

/-- Whether an ITP was released in a specific period description. -/
def InteractiveTheoremProver.releasedInPeriod (itp : InteractiveTheoremProver) (period : String) : Prop :=
  itp.releasePeriod = some period

instance (itp : InteractiveTheoremProver) (period : String) : Decidable (itp.releasedInPeriod period) :=
  inferInstanceAs (Decidable (itp.releasePeriod = some period))

/-- Whether an ITP was released at the beginning of 2021. -/
def InteractiveTheoremProver.releasedAtBeginningOf2021 (itp : InteractiveTheoremProver) : Prop :=
  itp.releasedInYear 2021 ∧ itp.releasedInPeriod "beginning of 2021"

instance (itp : InteractiveTheoremProver) : Decidable itp.releasedAtBeginningOf2021 :=
  inferInstanceAs (Decidable (itp.releasedInYear 2021 ∧ itp.releasedInPeriod "beginning of 2021"))

/-- Whether an ITP is open source. -/
def InteractiveTheoremProver.isOpenSourceProver (itp : InteractiveTheoremProver) : Prop :=
  itp.isOpenSource = true

instance (itp : InteractiveTheoremProver) : Decidable itp.isOpenSourceProver :=
  inferInstanceAs (Decidable (itp.isOpenSource = true))

/-- Whether the community is porting mathlib to this ITP. -/
def InteractiveTheoremProver.isPortingMathlib (itp : InteractiveTheoremProver) : Prop :=
  itp.isPortingLibrary = true

instance (itp : InteractiveTheoremProver) : Decidable itp.isPortingMathlib :=
  inferInstanceAs (Decidable (itp.isPortingLibrary = true))

/-- Whether the number of applications of this ITP is quickly growing. -/
def InteractiveTheoremProver.hasQuicklyGrowingAppCount (itp : InteractiveTheoremProver) : Prop :=
  itp.hasQuicklyGrowingApplications = true

instance (itp : InteractiveTheoremProver) : Decidable itp.hasQuicklyGrowingAppCount :=
  inferInstanceAs (Decidable (itp.hasQuicklyGrowingApplications = true))

/-- [Page 2]
"It includes a translation verifier for Reopt, a package for supporting inductive-inductive types, and a car controller."

Whether an ITP includes a specific application.
-/
def InteractiveTheoremProver.hasApplication (itp : InteractiveTheoremProver) (app : ProverApplication) : Prop :=
  app ∈ itp.applications

instance (itp : InteractiveTheoremProver) (app : ProverApplication) : Decidable (itp.hasApplication app) :=
  inferInstanceAs (Decidable (app ∈ itp.applications))

/-- Whether an ITP includes an application with a given name. -/
def InteractiveTheoremProver.hasApplicationNamed (itp : InteractiveTheoremProver) (appName : String) : Prop :=
  ∃ app ∈ itp.applications, app.name = appName

instance (itp : InteractiveTheoremProver) (appName : String) : Decidable (itp.hasApplicationNamed appName) :=
  inferInstanceAs (Decidable (∃ app ∈ itp.applications, app.name = appName))

/-- Computable witness demonstrating non-vacuity and satisfiability of `InteractiveTheoremProver`.
Represents Lean 4 as described on Page 1 and Page 2: implemented in Lean itself, reimplementing Lean,
fully extensible across all architectural components, featuring a hygienic macro system
custom-built for ITPs, a new tabled typeclass resolution procedure addressing performance problems,
an efficient functional programming language based on functional but in-place,
custom proof automation in Lean itself with crucial efficient code generation,
an extensible theorem prover and efficient programming language, equipped with a new C compiler,
plugin loading, export of internal data structures via the Lean package,
platform for developing efficient domain-specific automation,
more robust and extensible elaborator, addressing shortcomings of Lean 3,
community extensibility without changing source code,
released at the beginning of 2021, open source, porting mathlib, quickly growing applications,
including Reopt translation verifier, inductive-inductive package, and car controller,
and originating from the Lean project started in 2013 based on the Calculus of Inductive Constructions. -/
def InteractiveTheoremProver_witness : InteractiveTheoremProver := {
  name := "Lean 4"
  language := "Lean"
  implLanguage := "Lean"
  reimplementationOf := some "Lean"
  modifiableComponents := SystemComponent.all
  extensibleComponents := SystemComponent.all
  macroSystem := some MacroSystem_witness
  typeclassResolution := some TypeclassResolutionProcedure_witness
  isEfficientFunctionalLanguage := true
  programmingParadigm := some ProgrammingParadigm_witness
  proofAutomationProcedures := [ProofAutomationProcedure_witness]
  isCodeGenerationCrucial := true
  startYear := some 2013
  logicalFramework := some .cic
  isExtensible := true
  isEfficientProgLanguage := true
  compiler := some Compiler_witness
  plugins := [Plugin_witness]
  supportsPluginLoading := true
  internalDataStructures := [InternalDataStructure_witness]
  proverPackage := some ProverPackage_witness
  isPlatformForAutomation := true
  domainSpecificAutomations := [DomainSpecificAutomation_witness]
  elaborator := some Elaborator_witness
  addressesShortcomingsOfPreviousVersion := true
  canExtendWithoutChangingSourceCode := true
  canAddNewFeaturesWithoutChangingSourceCode := true
  releaseYear := some 2021
  releasePeriod := some "beginning of 2021"
  isOpenSource := true
  isPortingLibrary := true
  hasQuicklyGrowingApplications := true
  applications := [
    reoptTranslationVerifier_witness,
    inductiveInductivePackage_witness,
    carController_witness
  ]
}

/-- Computable witness demonstrating the Lean project inception and framework.
Represents the Lean project started in 2013 based on the Calculus of Inductive Constructions. -/
def leanProject_witness : InteractiveTheoremProver := {
  name := "Lean"
  language := "Lean"
  implLanguage := "C++"
  reimplementationOf := none
  startYear := some 2013
  logicalFramework := some .cic
  isCodeGenerationCrucial := true
  proofAutomationProcedures := [ProofAutomationProcedure_witness]
}

/-- [Page 2]
"Lean 3 metaprograms have been also instrumental in building standalone applications, such as a SQL query equivalence checker [3]."
"We believe the Lean 3 theorem prover's success is primarily due to its extensibility capabilities and metaprogramming framework [6]."
"However, users cannot modify many parts of the system without changing Lean 3 source code written in C++."
"Another issue is that many proof automation metaprograms are not competitive with similar proof automation implemented in programming languages with an efficient compiler such as C++ and OCaml."
"The primary source of inefficiency in Lean 3 metaprograms is the virtual machine interpretation overhead."

Computable witness representing the Lean 3 theorem prover as described on Page 2:
an interactive theorem prover implemented in C++, whose success is primarily due to its
extensibility capabilities and metaprogramming framework, where users cannot modify many parts
of the system (such as parser, elaborator, pretty printer, code generator) without changing C++
source code, whose proof automation metaprograms are not competitive with similar proof automation
implemented in compiled languages such as C++ and OCaml, whose metaprograms were instrumental
in building standalone applications (such as a SQL query equivalence checker), and whose primary
source of inefficiency in metaprograms is virtual machine interpretation overhead. -/
def lean3_witness : InteractiveTheoremProver := {
  name := "Lean 3"
  language := "Lean"
  implLanguage := "C++"
  reimplementationOf := none
  modifiableComponents := [.tactics, .decisionProcedures]
  extensibleComponents := [.tactics, .decisionProcedures]
  macroSystem := none
  typeclassResolution := none
  isEfficientFunctionalLanguage := false
  programmingParadigm := none
  proofAutomationProcedures := [ProofAutomationProcedure_witness]
  isCodeGenerationCrucial := false
  startYear := some 2013
  logicalFramework := some .cic
  standaloneApplications := [sqlQueryEquivalenceChecker_witness]
  primarySuccessFactors := [.extensibilityCapabilities, .metaprogrammingFramework]
  componentsRequiringSourceCodeChange := [.parser, .elaborator, .prettyPrinter, .codeGenerator]
  metaprograms := [lean3ProofAutomation_witness]
  primaryInefficiencySource := some .virtualMachineInterpretationOverhead
}

/-- [Page 1]
"and contains nontrivial mathematical objects such as schemes."

A mathematical object formalized within a mathematical library. -/
structure MathematicalObject where
  name : String
  isNontrivial : Bool := true
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `MathematicalObject`. -/
def MathematicalObject_witness : MathematicalObject := {
  name := "schemes"
  isNontrivial := true
}

/-- Whether a mathematical object is nontrivial. -/
def MathematicalObject.isNontrivialObject (obj : MathematicalObject) : Prop :=
  obj.isNontrivial = true

instance (obj : MathematicalObject) : Decidable obj.isNontrivialObject :=
  inferInstanceAs (Decidable (obj.isNontrivial = true))

abbrev isNontrivialObject := MathematicalObject.isNontrivialObject

/-- [Page 1]
"Mathlib is also the foundation for the Perfectoid Spaces in Lean project [1],
and the Liquid Tensor challenge [11] posed by the renowned mathematician Peter Scholze."

A formalization project founded on a mathematical library. -/
structure FormalizationProject where
  name : String
  isChallenge : Bool := false
  posedBy : Option String := none
  poserIsRenownedMathematician : Bool := false
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `FormalizationProject`.
Represents the "Perfectoid Spaces in Lean" project. -/
def perfectoidSpacesProject_witness : FormalizationProject := {
  name := "Perfectoid Spaces in Lean"
  isChallenge := false
  posedBy := none
  poserIsRenownedMathematician := false
}

/-- Default witness alias for `FormalizationProject`. -/
def FormalizationProject_witness : FormalizationProject :=
  perfectoidSpacesProject_witness

/-- Computable witness representing the "Liquid Tensor challenge" founded on mathlib,
posed by the renowned mathematician Peter Scholze. -/
def liquidTensorChallenge_witness : FormalizationProject := {
  name := "Liquid Tensor challenge"
  isChallenge := true
  posedBy := some "Peter Scholze"
  poserIsRenownedMathematician := true
}

/-- Whether a formalization project is a challenge project. -/
def FormalizationProject.isChallengeProject (proj : FormalizationProject) : Prop :=
  proj.isChallenge = true

instance (proj : FormalizationProject) : Decidable proj.isChallengeProject :=
  inferInstanceAs (Decidable (proj.isChallenge = true))

/-- Whether a formalization project was posed by a renowned mathematician. -/
def FormalizationProject.isPosedByRenownedMathematician (proj : FormalizationProject) (person : String) : Prop :=
  proj.posedBy = some person ∧ proj.poserIsRenownedMathematician = true

instance (proj : FormalizationProject) (person : String) : Decidable (proj.isPosedByRenownedMathematician person) :=
  inferInstanceAs (Decidable (proj.posedBy = some person ∧ proj.poserIsRenownedMathematician = true))

/-- [Page 1]
"For example, it contains a package of semantic linters that alert users to many commonly made mistakes [5]."

A package of semantic linters that alert users to commonly made mistakes. -/
structure SemanticLinterPackage where
  name : String := "package of semantic linters"
  alertsCommonMistakes : Bool := true
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `SemanticLinterPackage`. -/
def SemanticLinterPackage_witness : SemanticLinterPackage := {
  name := "package of semantic linters"
  alertsCommonMistakes := true
}

/-- Whether a semantic linter package alerts users to commonly made mistakes. -/
def SemanticLinterPackage.alertsUsersToCommonMistakes (slp : SemanticLinterPackage) : Prop :=
  slp.alertsCommonMistakes = true

instance (slp : SemanticLinterPackage) : Decidable slp.alertsUsersToCommonMistakes :=
  inferInstanceAs (Decidable (slp.alertsCommonMistakes = true))

/-- [Page 1]
"mathlib, a mathematical library started in 2017 using Lean 3, contains roughly half a million lines of code."
"It is developed by a community of users with very different backgrounds, and contains nontrivial mathematical objects such as schemes."
"Mathlib is also the foundation for the Perfectoid Spaces in Lean project [1], and the Liquid Tensor challenge [11] posed by the renowned mathematician Peter Scholze."
"Mathlib contains not only mathematical objects but also Lean metaprograms that extend the system [5]."

A mathematical library project formalized in an interactive theorem prover. -/
structure MathematicalLibrary where
  name : String := "mathlib"
  startYear : Nat := 2017
  baseProver : String := "Lean 3"
  hasDiverseUserCommunity : Bool := true
  linesOfCode : Nat := 500000
  mathematicalObjects : List MathematicalObject := []
  projectsFoundedOn : List FormalizationProject := []
  metaprograms : List Metaprogram := []
  semanticLinterPackages : List SemanticLinterPackage := []
  deriving Inhabited, DecidableEq, Repr

/-- Whether a mathematical library project was started in a given year. -/
def MathematicalLibrary.startedIn (lib : MathematicalLibrary) (year : Nat) : Prop :=
  lib.startYear = year

instance (lib : MathematicalLibrary) (year : Nat) : Decidable (lib.startedIn year) :=
  inferInstanceAs (Decidable (lib.startYear = year))

/-- Whether a mathematical library project was implemented using a given base prover. -/
def MathematicalLibrary.usedProver (lib : MathematicalLibrary) (proverName : String) : Prop :=
  lib.baseProver = proverName

instance (lib : MathematicalLibrary) (proverName : String) : Decidable (lib.usedProver proverName) :=
  inferInstanceAs (Decidable (lib.baseProver = proverName))

/-- Whether a mathematical library is developed by a diverse user community. -/
def MathematicalLibrary.hasDiverseCommunity (lib : MathematicalLibrary) : Prop :=
  lib.hasDiverseUserCommunity = true

instance (lib : MathematicalLibrary) : Decidable lib.hasDiverseCommunity :=
  inferInstanceAs (Decidable (lib.hasDiverseUserCommunity = true))

/-- Whether a mathematical library contains roughly half a million lines of code. -/
def MathematicalLibrary.hasRoughlyHalfMillionLinesOfCode (lib : MathematicalLibrary) : Prop :=
  400000 ≤ lib.linesOfCode ∧ lib.linesOfCode ≤ 600000

instance (lib : MathematicalLibrary) : Decidable lib.hasRoughlyHalfMillionLinesOfCode :=
  inferInstanceAs (Decidable (400000 ≤ lib.linesOfCode ∧ lib.linesOfCode ≤ 600000))

/-- Whether a mathematical library contains a specified nontrivial mathematical object. -/
def MathematicalLibrary.containsNontrivialObject (lib : MathematicalLibrary) (objName : String) : Prop :=
  ∃ obj ∈ lib.mathematicalObjects, obj.name = objName ∧ obj.isNontrivial = true

instance (lib : MathematicalLibrary) (objName : String) : Decidable (lib.containsNontrivialObject objName) :=
  inferInstanceAs (Decidable (∃ obj ∈ lib.mathematicalObjects, obj.name = objName ∧ obj.isNontrivial = true))

/-- Whether a mathematical library is the foundation for a formalization project. -/
def MathematicalLibrary.isFoundationFor (lib : MathematicalLibrary) (proj : FormalizationProject) : Prop :=
  proj ∈ lib.projectsFoundedOn

instance (lib : MathematicalLibrary) (proj : FormalizationProject) : Decidable (lib.isFoundationFor proj) :=
  inferInstanceAs (Decidable (proj ∈ lib.projectsFoundedOn))

/-- Whether a mathematical library contains a specified metaprogram. -/
def MathematicalLibrary.containsMetaprogram (lib : MathematicalLibrary) (mp : Metaprogram) : Prop :=
  mp ∈ lib.metaprograms

instance (lib : MathematicalLibrary) (mp : Metaprogram) : Decidable (lib.containsMetaprogram mp) :=
  inferInstanceAs (Decidable (mp ∈ lib.metaprograms))

/-- Whether a mathematical library contains Lean metaprograms extending the system. -/
def MathematicalLibrary.hasMetaprogramsExtendingSystem (lib : MathematicalLibrary) : Prop :=
  ∃ mp ∈ lib.metaprograms, mp.extendsSystem = true

instance (lib : MathematicalLibrary) : Decidable lib.hasMetaprogramsExtendingSystem :=
  inferInstanceAs (Decidable (∃ mp ∈ lib.metaprograms, mp.extendsSystem = true))

/-- Whether a mathematical library contains metaprograms implementing nontrivial proof automation. -/
def MathematicalLibrary.hasNontrivialProofAutomation (lib : MathematicalLibrary) : Prop :=
  ∃ mp ∈ lib.metaprograms, mp.implementsProofAutomation = true ∧ mp.isNontrivialProofAutomation = true

instance (lib : MathematicalLibrary) : Decidable lib.hasNontrivialProofAutomation :=
  inferInstanceAs (Decidable (∃ mp ∈ lib.metaprograms, mp.implementsProofAutomation = true ∧ mp.isNontrivialProofAutomation = true))

/-- Whether a mathematical library contains metaprograms adding top-level commands and non-automation features. -/
def MathematicalLibrary.hasNonAutomationExtensions (lib : MathematicalLibrary) : Prop :=
  ∃ mp ∈ lib.metaprograms, mp.addsTopLevelCommands = true ∧ mp.isNonAutomationFeature = true

instance (lib : MathematicalLibrary) : Decidable lib.hasNonAutomationExtensions :=
  inferInstanceAs (Decidable (∃ mp ∈ lib.metaprograms, mp.addsTopLevelCommands = true ∧ mp.isNonAutomationFeature = true))

/-- Whether a mathematical library contains a specified semantic linter package. -/
def MathematicalLibrary.containsSemanticLinterPackage (lib : MathematicalLibrary) (slp : SemanticLinterPackage) : Prop :=
  slp ∈ lib.semanticLinterPackages

instance (lib : MathematicalLibrary) (slp : SemanticLinterPackage) : Decidable (lib.containsSemanticLinterPackage slp) :=
  inferInstanceAs (Decidable (slp ∈ lib.semanticLinterPackages))

/-- Computable witness demonstrating non-vacuity and satisfiability of `MathematicalLibrary`.
Represents `mathlib` as described on Page 1: started in 2017 using Lean 3,
with roughly half a million lines of code, a diverse community of users,
containing nontrivial mathematical objects including schemes, serving as the foundation
for Perfectoid Spaces in Lean and the Liquid Tensor challenge, containing Lean metaprograms
that extend the system (such as a ring theory solver, Presburger arithmetic decision procedure,
and top-level command extensions), and a package of semantic linters. -/
def MathematicalLibrary_witness : MathematicalLibrary := {
  name := "mathlib"
  startYear := 2017
  baseProver := "Lean 3"
  hasDiverseUserCommunity := true
  linesOfCode := 500000
  mathematicalObjects := [
    MathematicalObject_witness,
    { name := "Schemes", isNontrivial := true }
  ]
  projectsFoundedOn := [
    perfectoidSpacesProject_witness,
    liquidTensorChallenge_witness
  ]
  metaprograms := [
    ringTheorySolver_witness,
    presburgerArithmetic_witness,
    topLevelCommandMetaprogram_witness
  ]
  semanticLinterPackages := [
    SemanticLinterPackage_witness
  ]
}

/-- Convenience witness alias for mathlib. -/
def mathlib_witness : MathematicalLibrary := MathematicalLibrary_witness

abbrev libStartedIn := MathematicalLibrary.startedIn
abbrev usedProver := MathematicalLibrary.usedProver
abbrev hasDiverseCommunity := MathematicalLibrary.hasDiverseCommunity
abbrev hasRoughlyHalfMillionLinesOfCode := MathematicalLibrary.hasRoughlyHalfMillionLinesOfCode
abbrev containsNontrivialObject := MathematicalLibrary.containsNontrivialObject
abbrev isFoundationFor := MathematicalLibrary.isFoundationFor
abbrev containsMetaprogram := MathematicalLibrary.containsMetaprogram
abbrev containsSemanticLinterPackage := MathematicalLibrary.containsSemanticLinterPackage
abbrev isChallengeProject := FormalizationProject.isChallengeProject
abbrev isPosedByRenownedMathematician := FormalizationProject.isPosedByRenownedMathematician
abbrev extendsTheSystem := Metaprogram.extendsTheSystem
abbrev implementsNontrivialProofAutomation := Metaprogram.implementsNontrivialProofAutomation
abbrev addsTopLevelCommandsAndNonAutomation := Metaprogram.addsTopLevelCommandsAndNonAutomation
abbrev alertsUsersToCommonMistakes := SemanticLinterPackage.alertsUsersToCommonMistakes
abbrev isBuiltUsingMetaprograms := StandaloneApplication.isBuiltUsingMetaprograms
abbrev isBuiltUsingProverMetaprograms := StandaloneApplication.isBuiltUsingProverMetaprograms
abbrev metaprogramsInstrumentalFor := InteractiveTheoremProver.metaprogramsInstrumentalFor
abbrev hasInstrumentalMetaprogramsForApplications := InteractiveTheoremProver.hasInstrumentalMetaprogramsForApplications
abbrev hasPrimarySuccessFactor := InteractiveTheoremProver.hasPrimarySuccessFactor
abbrev successDueToExtensibilityAndMetaprogramming := InteractiveTheoremProver.successDueToExtensibilityAndMetaprogramming
abbrev cannotModifyWithoutChangingSourceCode := InteractiveTheoremProver.cannotModifyWithoutChangingSourceCode
abbrev cannotModifyWithoutChangingSourceCodeIn := InteractiveTheoremProver.cannotModifyWithoutChangingSourceCodeIn
abbrev hasComponentsRequiringCppSourceChange := InteractiveTheoremProver.hasComponentsRequiringCppSourceChange
abbrev hasAnEfficientCompiler := ProgrammingLanguage.hasAnEfficientCompiler
abbrev isCompetitiveWithCompiled := Metaprogram.isCompetitiveWithCompiled
abbrev isNotCompetitiveWithCompiled := Metaprogram.isNotCompetitiveWithCompiled
abbrev hasNonCompetitiveProofAutomation := InteractiveTheoremProver.hasNonCompetitiveProofAutomation
abbrev proofAutomationNotCompetitiveWith := InteractiveTheoremProver.proofAutomationNotCompetitiveWith
abbrev hasPrimaryInefficiencySource := InteractiveTheoremProver.hasPrimaryInefficiencySource
abbrev isVMInterpretationOverheadPrimaryInefficiency := InteractiveTheoremProver.isVMInterpretationOverheadPrimaryInefficiency
abbrev isNewCompiler := Compiler.isNewCompiler
abbrev producesTargetLanguage := Compiler.producesTargetLanguage
abbrev producesCCode := Compiler.producesCCode
abbrev producesLanguage := Compiler.producesLanguage
abbrev isCompiledFromAutomation := Plugin.isCompiledFromAutomation
abbrev isWrittenIn := Plugin.isWrittenIn
abbrev isWrittenInLanguage := Plugin.isWrittenInLanguage
abbrev isEfficientAutomation := ProofAutomationProcedure.isEfficientAutomation
abbrev isUsedInImplementation := InternalDataStructure.isUsedInImplementation
abbrev exportsAllInternalDataStructures := ProverPackage.exportsAllInternalDataStructures
abbrev exportsDataStructure := ProverPackage.exportsDataStructure
abbrev exportsAllInternalDataStructuresOf := ProverPackage.exportsAllInternalDataStructuresOf
abbrev isExtensibleTheoremProver := InteractiveTheoremProver.isExtensibleTheoremProver
abbrev isEfficientProgrammingLanguage := InteractiveTheoremProver.isEfficientProgrammingLanguage
abbrev hasCompiler := InteractiveTheoremProver.hasCompiler
abbrev hasNewCompiler := InteractiveTheoremProver.hasNewCompiler
abbrev compilerProducesTargetLanguage := InteractiveTheoremProver.compilerProducesTargetLanguage
abbrev compilerProducesCCode := InteractiveTheoremProver.compilerProducesCCode
abbrev compilerProducesLanguage := InteractiveTheoremProver.compilerProducesLanguage
abbrev canLoadPlugins := InteractiveTheoremProver.canLoadPlugins
abbrev canLoadPlugin := InteractiveTheoremProver.canLoadPlugin
abbrev canImplementEfficientProofAutomationIn := InteractiveTheoremProver.canImplementEfficientProofAutomationIn
abbrev canAccessInternalDataStructuresByImporting := InteractiveTheoremProver.canAccessInternalDataStructuresByImporting
abbrev canAccessInternalDataStructure := InteractiveTheoremProver.canAccessInternalDataStructure
abbrev hasAccessToAllInternalDataStructures := InteractiveTheoremProver.hasAccessToAllInternalDataStructures
abbrev isPlatformForDomainSpecificAutomation := InteractiveTheoremProver.isPlatformForDomainSpecificAutomation
abbrev hasEfficientDomainSpecificAutomation := InteractiveTheoremProver.hasEfficientDomainSpecificAutomation
abbrev isPlatformForDevelopingEfficientDomainSpecificAutomation := InteractiveTheoremProver.isPlatformForDevelopingEfficientDomainSpecificAutomation
abbrev isRobustElaborator := Elaborator.isRobustElaborator
abbrev isExtensibleElaborator := Elaborator.isExtensibleElaborator
abbrev isMoreRobustThanPreviousVersion := Elaborator.isMoreRobustThanPreviousVersion
abbrev isRobustAndExtensible := Elaborator.isRobustAndExtensible
abbrev isMoreRobustAndExtensible := Elaborator.isMoreRobustAndExtensible
abbrev isInferringFunctionBodyType := Elaborator.isInferringFunctionBodyType
abbrev hasElaborator := InteractiveTheoremProver.hasElaborator
abbrev hasRobustElaborator := InteractiveTheoremProver.hasRobustElaborator
abbrev hasExtensibleElaborator := InteractiveTheoremProver.hasExtensibleElaborator
abbrev hasMoreRobustElaborator := InteractiveTheoremProver.hasMoreRobustElaborator
abbrev hasRobustAndExtensibleElaborator := InteractiveTheoremProver.hasRobustAndExtensibleElaborator
abbrev hasMoreRobustAndExtensibleElaborator := InteractiveTheoremProver.hasMoreRobustAndExtensibleElaborator
abbrev addressesShortcomingsOfPrevious := InteractiveTheoremProver.addressesShortcomingsOfPrevious
abbrev addressesShortcomingsOfLean3 := InteractiveTheoremProver.addressesShortcomingsOfLean3
abbrev canExtendWithoutChangingSource := InteractiveTheoremProver.canExtendWithoutChangingSource
abbrev canAddNewFeaturesWithoutChangingSource := InteractiveTheoremProver.canAddNewFeaturesWithoutChangingSource
abbrev communityCanExtendAndAddNewFeaturesWithoutChangingSourceCode := InteractiveTheoremProver.communityCanExtendAndAddNewFeaturesWithoutChangingSourceCode
abbrev releasedInYear := InteractiveTheoremProver.releasedInYear
abbrev releasedInPeriod := InteractiveTheoremProver.releasedInPeriod
abbrev releasedAtBeginningOf2021 := InteractiveTheoremProver.releasedAtBeginningOf2021
abbrev isOpenSourceProver := InteractiveTheoremProver.isOpenSourceProver
abbrev isPortingMathlib := InteractiveTheoremProver.isPortingMathlib
abbrev hasQuicklyGrowingAppCount := InteractiveTheoremProver.hasQuicklyGrowingAppCount
abbrev hasApplication := InteractiveTheoremProver.hasApplication
abbrev hasApplicationNamed := InteractiveTheoremProver.hasApplicationNamed
abbrev isPortingLibrary := InteractiveTheoremProver.isPortingMathlib
abbrev hasQuicklyGrowingApplications := InteractiveTheoremProver.hasQuicklyGrowingAppCount
abbrev canExtendWithoutChangingSourceCode := InteractiveTheoremProver.canExtendWithoutChangingSource
abbrev canAddNewFeaturesWithoutChangingSourceCode := InteractiveTheoremProver.canAddNewFeaturesWithoutChangingSource

/-- [Page 2]
"We define functions by using the def keyword followed by its name, a parameter list, return type, and body."

A function parameter, specifying its name and optional type annotation.
-/
structure Parameter where
  name : String := ""
  type : Option String := none
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `Parameter`. -/
def Parameter_witness : Parameter := {
  name := "x"
  type := some "Nat"
}

/-- Whether a parameter has a non-empty name. -/
def Parameter.hasName (p : Parameter) : Prop :=
  p.name ≠ ""

instance (p : Parameter) : Decidable p.hasName :=
  inferInstanceAs (Decidable (p.name ≠ ""))

/-- Whether a parameter has an explicitly specified type. -/
def Parameter.hasType (p : Parameter) : Prop :=
  p.type.isSome

instance (p : Parameter) : Decidable p.hasType :=
  inferInstanceAs (Decidable p.type.isSome)

/-- [Page 2]
"We define functions by using the def keyword followed by its name, a parameter list, return type, and body."

A parameter list for a function definition, containing a list of parameters and a separator string.
-/
structure ParameterList where
  parameters : List Parameter := []
  separator : String := ""
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `ParameterList`. -/
def ParameterList_witness : ParameterList := {
  parameters := [Parameter_witness]
  separator := " "
}

/-- Whether a parameter list has at least one parameter. -/
def ParameterList.hasParameters (pl : ParameterList) : Prop :=
  !pl.parameters.isEmpty

instance (pl : ParameterList) : Decidable pl.hasParameters :=
  inferInstanceAs (Decidable (!pl.parameters.isEmpty))

/-- Whether a parameter list includes a specific parameter. -/
def ParameterList.hasParameter (pl : ParameterList) (p : Parameter) : Prop :=
  p ∈ pl.parameters

instance (pl : ParameterList) (p : Parameter) : Decidable (pl.hasParameter p) :=
  inferInstanceAs (Decidable (p ∈ pl.parameters))

/-- Whether a parameter list is separated by spaces. -/
def ParameterList.isSeparatedBySpaces (pl : ParameterList) : Prop :=
  pl.separator = " "

instance (pl : ParameterList) : Decidable pl.isSeparatedBySpaces :=
  inferInstanceAs (Decidable (pl.separator = " "))

/-- [Page 2]
"We define functions by using the def keyword followed by its name, a parameter list, return type, and body."

A function definition modeling Lean function definition syntax and its constituent components.
-/
structure FunctionDefinition where
  keyword : String := ""
  name : String := ""
  parameterList : ParameterList := {}
  returnType : Option String := none
  body : Option String := none
  isDefinedByPatternMatching : Bool := false
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `FunctionDefinition`. -/
def FunctionDefinition_witness : FunctionDefinition := {
  keyword := "def"
  name := "f"
  parameterList := ParameterList_witness
  returnType := some "Nat"
  body := some "x"
}

/-- Whether a function definition uses the `def` keyword. -/
def FunctionDefinition.usesDefKeyword (fn : FunctionDefinition) : Prop :=
  fn.keyword = "def"

instance (fn : FunctionDefinition) : Decidable fn.usesDefKeyword :=
  inferInstanceAs (Decidable (fn.keyword = "def"))

/-- Whether a function definition has a non-empty name. -/
def FunctionDefinition.hasName (fn : FunctionDefinition) : Prop :=
  fn.name ≠ ""

instance (fn : FunctionDefinition) : Decidable fn.hasName :=
  inferInstanceAs (Decidable (fn.name ≠ ""))

/-- Whether a function definition has a non-empty parameter list. -/
def FunctionDefinition.hasParameterList (fn : FunctionDefinition) : Prop :=
  fn.parameterList.hasParameters

instance (fn : FunctionDefinition) : Decidable fn.hasParameterList :=
  inferInstanceAs (Decidable fn.parameterList.hasParameters)

/-- Whether a function definition includes a specific parameter. -/
def FunctionDefinition.hasParameter (fn : FunctionDefinition) (p : Parameter) : Prop :=
  fn.parameterList.hasParameter p

instance (fn : FunctionDefinition) (p : Parameter) : Decidable (fn.hasParameter p) :=
  inferInstanceAs (Decidable (fn.parameterList.hasParameter p))

/-- Whether a function definition specifies a return type. -/
def FunctionDefinition.hasReturnType (fn : FunctionDefinition) : Prop :=
  fn.returnType.isSome

instance (fn : FunctionDefinition) : Decidable fn.hasReturnType :=
  inferInstanceAs (Decidable fn.returnType.isSome)

/-- Whether a function definition specifies a body. -/
def FunctionDefinition.hasBody (fn : FunctionDefinition) : Prop :=
  fn.body.isSome

instance (fn : FunctionDefinition) : Decidable fn.hasBody :=
  inferInstanceAs (Decidable fn.body.isSome)

/-- Whether a function definition is defined by pattern-matching. -/
def FunctionDefinition.definedByPatternMatching (fn : FunctionDefinition) : Prop :=
  fn.isDefinedByPatternMatching = true

instance (fn : FunctionDefinition) : Decidable fn.definedByPatternMatching :=
  inferInstanceAs (Decidable (fn.isDefinedByPatternMatching = true))

/-- [Page 2]
"The Boolean or function is defined by pattern-matching as follows
def or (a b : Bool) := match a with | true => true | false => b."

Computable witness representing the Boolean `or` function definition defined by pattern-matching.
-/
def booleanOrFunction_witness : FunctionDefinition := {
  keyword := "def"
  name := "or"
  parameterList := {
    parameters := [
      { name := "a", type := some "Bool" },
      { name := "b", type := some "Bool" }
    ]
    separator := " "
  }
  returnType := none
  body := some "match a with | true => true | false => b"
  isDefinedByPatternMatching := true
}

/-- [Page 2]
"The Boolean or function is defined by pattern-matching as follows
def or (a b : Bool) := match a with | true => true | false => b."

The Boolean `or` function defined by pattern-matching.
-/
def booleanOr (a b : Bool) : Bool :=
  match a with
  | true => true
  | false => b

/-- [Page 3]
"We can use the command #check <term> to inspect the type of term, and #eval <term> to evaluate it."

A top-level command in an interactive theorem prover, specifying its name
and whether it inspects the type of a term or evaluates a term.
-/
structure Command where
  name : String := ""
  inspectsType : Bool := false
  evaluatesTerm : Bool := false
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `Command`.
Represents the `#check` command used to inspect the type of a term. -/
def checkCommand_witness : Command := {
  name := "#check"
  inspectsType := true
  evaluatesTerm := false
}

/-- Computable witness representing the `#eval` command used to evaluate a term. -/
def evalCommand_witness : Command := {
  name := "#eval"
  inspectsType := false
  evaluatesTerm := true
}

/-- Default witness alias for `Command`. -/
def Command_witness : Command :=
  checkCommand_witness

/-- Whether a command has a non-empty name. -/
def Command.hasName (cmd : Command) : Prop :=
  cmd.name ≠ ""

instance (cmd : Command) : Decidable cmd.hasName :=
  inferInstanceAs (Decidable (cmd.name ≠ ""))

/-- Whether a command has a specific name. -/
def Command.isNamed (cmd : Command) (n : String) : Prop :=
  cmd.name = n

instance (cmd : Command) (n : String) : Decidable (cmd.isNamed n) :=
  inferInstanceAs (Decidable (cmd.name = n))

/-- Method-syntax predicate checking whether a command inspects the type of a term. -/
def Command.inspectsTypeOfTerm (cmd : Command) : Prop :=
  cmd.inspectsType = true

instance (cmd : Command) : Decidable cmd.inspectsTypeOfTerm :=
  inferInstanceAs (Decidable (cmd.inspectsType = true))

/-- Method-syntax predicate checking whether a command evaluates a term. -/
def Command.evaluatesTermValue (cmd : Command) : Prop :=
  cmd.evaluatesTerm = true

instance (cmd : Command) : Decidable cmd.evaluatesTermValue :=
  inferInstanceAs (Decidable (cmd.evaluatesTerm = true))

/-- [Page 3]
"#check or true false -- Bool (this is a comment in Lean)"

A comment in source code, specifying its text, whether it is a comment,
and the language in which it is considered a comment.
-/
structure Comment where
  text : String := ""
  isComment : Bool := false
  language : String := ""
  deriving Inhabited, DecidableEq, Repr

/-- Computable witness demonstrating non-vacuity and satisfiability of `Comment`.
Represents a comment in Lean source code as illustrated on Page 3. -/
def leanComment_witness : Comment := {
  text := "-- Bool (this is a comment in Lean)"
  isComment := true
  language := "Lean"
}

/-- Default witness alias for `Comment`. -/
def Comment_witness : Comment :=
  leanComment_witness

/-- Whether an entity is marked as a comment. -/
def Comment.isAComment (c : Comment) : Prop :=
  c.isComment = true

instance (c : Comment) : Decidable c.isAComment :=
  inferInstanceAs (Decidable (c.isComment = true))

/-- Whether a comment has non-empty text. -/
def Comment.hasText (c : Comment) : Prop :=
  c.text ≠ ""

instance (c : Comment) : Decidable c.hasText :=
  inferInstanceAs (Decidable (c.text ≠ ""))

/-- Whether a comment is a comment in a specified language. -/
def Comment.isCommentIn (c : Comment) (lang : String) : Prop :=
  c.isAComment ∧ c.language = lang

instance (c : Comment) (lang : String) : Decidable (c.isCommentIn lang) :=
  inferInstanceAs (Decidable (c.isAComment ∧ c.language = lang))

/-- Whether a comment is a comment in a specified programming language. -/
def Comment.isCommentInLanguage (c : Comment) (lang : ProgrammingLanguage) : Prop :=
  c.isCommentIn lang.name

instance (c : Comment) (lang : ProgrammingLanguage) : Decidable (c.isCommentInLanguage lang) :=
  inferInstanceAs (Decidable (c.isCommentIn lang.name))

/-- Whether a comment is a comment in Lean. -/
def Comment.isCommentInLean (c : Comment) : Prop :=
  c.isCommentIn "Lean"

instance (c : Comment) : Decidable c.isCommentInLean :=
  inferInstanceAs (Decidable (c.isCommentIn "Lean"))

abbrev isSeparatedBySpaces := ParameterList.isSeparatedBySpaces
abbrev hasParameters := ParameterList.hasParameters
abbrev usesDefKeyword := FunctionDefinition.usesDefKeyword
abbrev hasParameterList := FunctionDefinition.hasParameterList
abbrev hasReturnType := FunctionDefinition.hasReturnType
abbrev hasBody := FunctionDefinition.hasBody
abbrev definedByPatternMatching := FunctionDefinition.definedByPatternMatching
abbrev inspectsTypeOfTerm := Command.inspectsTypeOfTerm
abbrev evaluatesTermValue := Command.evaluatesTermValue
abbrev isAComment := Comment.isAComment
abbrev isCommentIn := Comment.isCommentIn
abbrev isCommentInLanguage := Comment.isCommentInLanguage
abbrev isCommentInLean := Comment.isCommentInLean
abbrev hasCommentText := Comment.hasText

end Concepts
