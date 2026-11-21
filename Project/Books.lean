import ProjectGate
import Project.Concepts
open ProjectGate

namespace Books

-- [Page 1] "The Lean 4 Theorem Prover and Programming Language (System Description)" — Non-formalizable: document title; skipped
-- [Page 1] "Leonardo de Moura and Sebastian Ullrich" — Non-formalizable: author attribution; skipped
-- [Page 1] "Microsoft Research, Redmond WA, USA" — Non-formalizable: author affiliation; skipped
-- [Page 1] "Karlsruhe Institute of Technology, Karlsruhe, Germany" — Non-formalizable: author affiliation; skipped

/-- [Page 1]
"Lean 4 is a reimplementation of the Lean interactive theorem prover (ITP) in Lean itself."
-/
theorem lean4_is_reimplementation_of_lean_in_lean
    (leanITP : Concepts.InteractiveTheoremProver)
    (h_itp : leanITP.name = "Lean" ∧ leanITP.language = "Lean") :
    let lean4 : Concepts.InteractiveTheoremProver := Concepts.InteractiveTheoremProver_witness
    lean4.name = "Lean 4" ∧
    lean4.language = "Lean" ∧
    lean4.implLanguage = "Lean" ∧
    lean4.isSelfHosted ∧
    lean4.isReimplementationOf leanITP := by
  have h_reimpl : Concepts.InteractiveTheoremProver_witness.isReimplementationOf leanITP := by
    change some "Lean" = some leanITP.name
    rw [h_itp.1]
  exact ⟨rfl, rfl, rfl, rfl, h_reimpl⟩

-- [Page 1] "It addresses many shortcomings of the previous versions and contains many new features." — Non-formalizable: informal narrative transition containing zero technical specifications, rules, or definitions; skipped

/-- [Page 1]
"Lean 4 is fully extensible: users can modify and extend the parser, elaborator, tactics, decision procedures, pretty printer, and code generator."
-/
theorem lean4_is_fully_extensible
    (itp : Concepts.InteractiveTheoremProver) :
    (itp.isFullyExtensible ↔
      (itp.canModify .parser ∧ itp.canExtend .parser) ∧
      (itp.canModify .elaborator ∧ itp.canExtend .elaborator) ∧
      (itp.canModify .tactics ∧ itp.canExtend .tactics) ∧
      (itp.canModify .decisionProcedures ∧ itp.canExtend .decisionProcedures) ∧
      (itp.canModify .prettyPrinter ∧ itp.canExtend .prettyPrinter) ∧
      (itp.canModify .codeGenerator ∧ itp.canExtend .codeGenerator)) ∧
    (let lean4 := Concepts.InteractiveTheoremProver_witness
     lean4.name = "Lean 4" ∧
     lean4.isFullyExtensible ∧
     (lean4.canModify .parser ∧ lean4.canExtend .parser) ∧
     (lean4.canModify .elaborator ∧ lean4.canExtend .elaborator) ∧
     (lean4.canModify .tactics ∧ lean4.canExtend .tactics) ∧
     (lean4.canModify .decisionProcedures ∧ lean4.canExtend .decisionProcedures) ∧
     (lean4.canModify .prettyPrinter ∧ lean4.canExtend .prettyPrinter) ∧
     (lean4.canModify .codeGenerator ∧ lean4.canExtend .codeGenerator)) := by
  constructor
  · constructor
    · intro h
      exact ⟨h .parser, h .elaborator, h .tactics, h .decisionProcedures, h .prettyPrinter, h .codeGenerator⟩
    · intro ⟨hp, he, ht, hd, hpr, hc⟩ c
      cases c with
      | parser => exact hp
      | elaborator => exact he
      | tactics => exact ht
      | decisionProcedures => exact hd
      | prettyPrinter => exact hpr
      | codeGenerator => exact hc
  · decide

/-- [Page 1]
"The new system has a hygienic macro system custom-built for ITPs."
-/
theorem lean4_has_hygienic_macro_system_custom_built_for_itps
    (itp : Concepts.InteractiveTheoremProver) :
    (itp.hasHygienicMacroSystemCustomBuiltForITPs ↔
      ∃ ms, itp.macroSystem = some ms ∧ ms.isHygienic = true ∧ ms.customBuiltForITPs = true) ∧
    (itp.hasHygienicMacroSystemCustomBuiltForITPs →
      itp.hasMacroSystem ∧ itp.hasHygienicMacroSystem ∧ itp.hasMacroSystemCustomBuiltForITPs) ∧
    (let lean4 := Concepts.InteractiveTheoremProver_witness
     lean4.name = "Lean 4" ∧
     lean4.hasMacroSystem ∧
     lean4.hasHygienicMacroSystem ∧
     lean4.hasMacroSystemCustomBuiltForITPs ∧
     lean4.hasHygienicMacroSystemCustomBuiltForITPs) := by
  refine ⟨Iff.rfl, ?_, by decide⟩
  intro ⟨ms, h_eq, h_hyg, h_cb⟩
  refine ⟨?_, ⟨ms, h_eq, h_hyg⟩, ⟨ms, h_eq, h_cb⟩⟩
  dsimp [Concepts.InteractiveTheoremProver.hasMacroSystem]
  rw [h_eq]
  rfl

/-- [Page 1]
"It contains a new typeclass resolution procedure based on tabled resolution, addressing significant performance problems reported by the growing user base."
-/
theorem lean4_has_new_tabled_typeclass_resolution_addressing_performance
    (itp : Concepts.InteractiveTheoremProver) :
    (itp.hasNewTabledResolutionAddressingPerformance ↔
      ∃ tr, itp.typeclassResolution = some tr ∧ tr.isTabled = true ∧ tr.isNew = true ∧ tr.addressesPerformanceProblems = true) ∧
    (itp.hasNewTabledResolutionAddressingPerformance →
      itp.hasTypeclassResolution ∧
      itp.hasNewTypeclassResolution ∧
      itp.hasTabledTypeclassResolution ∧
      itp.addressesTypeclassPerformanceProblems) ∧
    (let lean4 := Concepts.InteractiveTheoremProver_witness
     lean4.name = "Lean 4" ∧
     lean4.hasTypeclassResolution ∧
     lean4.hasNewTypeclassResolution ∧
     lean4.hasTabledTypeclassResolution ∧
     lean4.addressesTypeclassPerformanceProblems ∧
     lean4.hasNewTabledResolutionAddressingPerformance) := by
  refine ⟨Iff.rfl, ?_, by decide⟩
  intro ⟨tr, h_eq, ht, hn, hp⟩
  refine ⟨?_, ⟨tr, h_eq, hn⟩, ⟨tr, h_eq, ht⟩, ⟨tr, h_eq, hp⟩⟩
  dsimp [Concepts.InteractiveTheoremProver.hasTypeclassResolution]
  rw [h_eq]
  rfl

/-- [Page 1]
"Lean 4 is also an efficient functional programming language based on a novel programming paradigm called functional but in-place."
-/
theorem lean4_is_efficient_functional_language_based_on_functional_but_in_place
    (itp : Concepts.InteractiveTheoremProver) :
    (itp.isNovelFunctionalButInPlace ↔
      ∃ p, itp.programmingParadigm = some p ∧ p.name = "functional but in-place" ∧ p.isNovel = true) ∧
    (itp.isNovelFunctionalButInPlace →
      itp.hasProgrammingParadigm ∧
      itp.hasNovelProgrammingParadigm ∧
      itp.isFunctionalButInPlace) ∧
    (let lean4 := Concepts.InteractiveTheoremProver_witness
     lean4.name = "Lean 4" ∧
     lean4.isEfficientFunctional ∧
     lean4.hasProgrammingParadigm ∧
     lean4.hasNovelProgrammingParadigm ∧
     lean4.isFunctionalButInPlace ∧
     lean4.isNovelFunctionalButInPlace) := by
  refine ⟨Iff.rfl, ?_, by decide⟩
  intro ⟨p, h_eq, h_name, h_nov⟩
  refine ⟨?_, ⟨p, h_eq, h_nov⟩, ⟨p, h_eq, h_name⟩⟩
  dsimp [Concepts.InteractiveTheoremProver.hasProgrammingParadigm]
  rw [h_eq]
  rfl

/-- [Page 1]
"Efficient code generation is crucial for Lean users because many write custom proof automation procedures in Lean itself."
-/
theorem efficient_code_generation_crucial_for_lean_users
    (itp : Concepts.InteractiveTheoremProver) :
    (itp.hasCustomProofAutomationInSelf ↔
      ∃ p ∈ itp.proofAutomationProcedures, p.isCustom = true ∧ p.language = itp.language) ∧
    (itp.isEfficientCodeGenerationCrucial ↔
      itp.isCodeGenerationCrucial = true) ∧
    (itp.hasCustomProofAutomationInSelf →
      ∃ p ∈ itp.proofAutomationProcedures, p.isCustomProcedure ∧ p.isImplementedIn itp) ∧
    (let lean := Concepts.InteractiveTheoremProver_witness
     lean.name = "Lean 4" ∧
     lean.language = "Lean" ∧
     lean.hasCustomProofAutomationInSelf ∧
     lean.isEfficientCodeGenerationCrucial) ∧
    (let leanProj := Concepts.leanProject_witness
     leanProj.name = "Lean" ∧
     leanProj.language = "Lean" ∧
     leanProj.hasCustomProofAutomationInSelf ∧
     leanProj.isEfficientCodeGenerationCrucial) := by
  refine ⟨Iff.rfl, Iff.rfl, ?_, by decide, by decide⟩
  intro ⟨p, hp_mem, hp_custom, hp_lang⟩
  exact ⟨p, hp_mem, hp_custom, hp_lang⟩

-- [Page 1] "1 Introduction" — Non-formalizable: section heading; skipped

/-- [Page 1]
"The Lean project started in 2013 [9] as an interactive theorem prover based on the Calculus of Inductive Constructions [4] (CIC)."
-/
theorem lean_project_started_in_2013_based_on_cic
    (itp : Concepts.InteractiveTheoremProver) :
    (itp.startedIn 2013 ↔ itp.startYear = some 2013) ∧
    (itp.isBasedOnCIC ↔ itp.logicalFramework = some .cic) ∧
    (let lean := Concepts.leanProject_witness
     lean.name = "Lean" ∧
     lean.startedIn 2013 ∧
     lean.isBasedOnCIC) ∧
    (let lean4 := Concepts.InteractiveTheoremProver_witness
     lean4.name = "Lean 4" ∧
     lean4.startedIn 2013 ∧
     lean4.isBasedOnCIC) := by
  refine ⟨Iff.rfl, Iff.rfl, by decide, by decide⟩

/-- [Page 1]
"In 2017, using Lean 3, a community of users with very different backgrounds started the Lean mathematical library project mathlib [13]."
-/
theorem mathlib_started_in_2017_using_lean3_by_diverse_community
    (lib : Concepts.MathematicalLibrary) :
    (lib.startedIn 2017 ↔ lib.startYear = 2017) ∧
    (lib.usedProver "Lean 3" ↔ lib.baseProver = "Lean 3") ∧
    (lib.hasDiverseCommunity ↔ lib.hasDiverseUserCommunity = true) ∧
    (let mathlib := Concepts.mathlib_witness
     mathlib.name = "mathlib" ∧
     mathlib.startedIn 2017 ∧
     mathlib.usedProver "Lean 3" ∧
     mathlib.hasDiverseCommunity) := by
  refine ⟨Iff.rfl, Iff.rfl, Iff.rfl, by decide⟩

/-- [Page 1]
"At the time of this writing, mathlib has roughly half a million lines of code, and contains many nontrivial mathematical objects such as Schemes [2]."
-/
theorem mathlib_has_half_million_lines_and_contains_schemes
    (lib : Concepts.MathematicalLibrary) :
    (lib.hasRoughlyHalfMillionLinesOfCode ↔
      400000 ≤ lib.linesOfCode ∧ lib.linesOfCode ≤ 600000) ∧
    (lib.containsNontrivialObject "Schemes" ↔
      ∃ obj ∈ lib.mathematicalObjects, obj.name = "Schemes" ∧ obj.isNontrivial = true) ∧
    (lib.containsNontrivialObject "Schemes" →
      ∃ obj ∈ lib.mathematicalObjects, obj.name = "Schemes" ∧ obj.isNontrivialObject) ∧
    (let mathlib := Concepts.mathlib_witness
     mathlib.name = "mathlib" ∧
     mathlib.hasRoughlyHalfMillionLinesOfCode ∧
     mathlib.containsNontrivialObject "Schemes") := by
  refine ⟨Iff.rfl, Iff.rfl, ?_, by decide⟩
  intro ⟨obj, h_mem, h_name, h_nontriv⟩
  exact ⟨obj, h_mem, h_name, h_nontriv⟩

/-- [Page 1]
"Mathlib is also the foundation for the Perfectoid Spaces in Lean project [1], and the Liquid Tensor challenge [11] posed by the renowned mathematician Peter Scholze."
-/
theorem mathlib_foundation_for_perfectoid_spaces_and_liquid_tensor_challenge
    (lib : Concepts.MathematicalLibrary)
    (proj : Concepts.FormalizationProject) :
    (lib.isFoundationFor proj ↔ proj ∈ lib.projectsFoundedOn) ∧
    (proj.isChallengeProject ↔ proj.isChallenge = true) ∧
    (proj.isPosedByRenownedMathematician "Peter Scholze" ↔
      proj.posedBy = some "Peter Scholze" ∧ proj.poserIsRenownedMathematician = true) ∧
    (let mathlib := Concepts.mathlib_witness
     let perfectoid := Concepts.perfectoidSpacesProject_witness
     let liquid := Concepts.liquidTensorChallenge_witness
     mathlib.name = "mathlib" ∧
     mathlib.isFoundationFor perfectoid ∧
     perfectoid.name = "Perfectoid Spaces in Lean" ∧
     mathlib.isFoundationFor liquid ∧
     liquid.name = "Liquid Tensor challenge" ∧
     liquid.isChallengeProject ∧
     liquid.isPosedByRenownedMathematician "Peter Scholze") := by
  refine ⟨Iff.rfl, Iff.rfl, Iff.rfl, by decide⟩

/-- [Page 1]
"Mathlib contains not only mathematical objects but also Lean metaprograms that extend the system [5]."
-/
theorem mathlib_contains_mathematical_objects_and_system_extending_metaprograms
    (lib : Concepts.MathematicalLibrary) :
    (lib.hasMetaprogramsExtendingSystem ↔
      ∃ mp ∈ lib.metaprograms, mp.extendsSystem = true) ∧
    (lib.hasMetaprogramsExtendingSystem →
      ∃ mp ∈ lib.metaprograms, mp.extendsTheSystem) ∧
    (let mathlib := Concepts.mathlib_witness
     mathlib.name = "mathlib" ∧
     (∃ obj ∈ mathlib.mathematicalObjects, obj.isNontrivialObject) ∧
     mathlib.hasMetaprogramsExtendingSystem ∧
     (∃ mp ∈ mathlib.metaprograms, mp.extendsTheSystem)) := by
  refine ⟨Iff.rfl, ?_, by decide⟩
  intro ⟨mp, h_mem, h_ext⟩
  exact ⟨mp, h_mem, h_ext⟩

/-- [Page 1]
"Some of these metaprograms implement nontrivial proof automation, such as a ring theory solver and a decision procedure for Presburger arithmetic."
-/
theorem mathlib_metaprograms_implement_nontrivial_proof_automation
    (lib : Concepts.MathematicalLibrary)
    (mp : Concepts.Metaprogram) :
    (mp.implementsNontrivialProofAutomation ↔
      mp.implementsProofAutomation = true ∧ mp.isNontrivialProofAutomation = true) ∧
    (lib.hasNontrivialProofAutomation ↔
      ∃ p ∈ lib.metaprograms, p.implementsProofAutomation = true ∧ p.isNontrivialProofAutomation = true) ∧
    (lib.hasNontrivialProofAutomation →
      ∃ p ∈ lib.metaprograms, p.implementsNontrivialProofAutomation) ∧
    (let mathlib := Concepts.mathlib_witness
     let ringSolver := Concepts.ringTheorySolver_witness
     let presburger := Concepts.presburgerArithmetic_witness
     mathlib.name = "mathlib" ∧
     mathlib.hasNontrivialProofAutomation ∧
     mathlib.containsMetaprogram ringSolver ∧
     ringSolver.name = "ring theory solver" ∧
     ringSolver.implementsNontrivialProofAutomation ∧
     mathlib.containsMetaprogram presburger ∧
     presburger.name = "decision procedure for Presburger arithmetic" ∧
     presburger.implementsNontrivialProofAutomation) := by
  refine ⟨Iff.rfl, Iff.rfl, ?_, by decide⟩
  intro ⟨p, h_mem, h_auto, h_nontriv⟩
  exact ⟨p, h_mem, ⟨h_auto, h_nontriv⟩⟩

/-- [Page 1]
"Lean metaprograms in mathlib also extend the system by adding new top-level command and features not related to proof automation."
-/
theorem mathlib_metaprograms_add_top_level_commands_and_non_automation_features
    (lib : Concepts.MathematicalLibrary)
    (mp : Concepts.Metaprogram) :
    (mp.addsTopLevelCommandsAndNonAutomation ↔
      mp.addsTopLevelCommands = true ∧ mp.isNonAutomationFeature = true) ∧
    (lib.hasNonAutomationExtensions ↔
      ∃ p ∈ lib.metaprograms, p.addsTopLevelCommands = true ∧ p.isNonAutomationFeature = true) ∧
    (lib.hasNonAutomationExtensions →
      ∃ p ∈ lib.metaprograms, p.addsTopLevelCommandsAndNonAutomation) ∧
    (let mathlib := Concepts.mathlib_witness
     let cmdExt := Concepts.topLevelCommandMetaprogram_witness
     mathlib.name = "mathlib" ∧
     mathlib.hasNonAutomationExtensions ∧
     mathlib.containsMetaprogram cmdExt ∧
     cmdExt.extendsTheSystem ∧
     cmdExt.addsTopLevelCommandsAndNonAutomation) := by
  refine ⟨Iff.rfl, Iff.rfl, ?_, by decide⟩
  intro ⟨p, h_mem, h_cmd, h_feat⟩
  exact ⟨p, h_mem, ⟨h_cmd, h_feat⟩⟩

/-- [Page 1]
"For example, it contains a package of semantic linters that alert users to many commonly made mistakes [5]."
-/
theorem mathlib_contains_package_of_semantic_linters_alerting_mistakes
    (lib : Concepts.MathematicalLibrary)
    (pkg : Concepts.SemanticLinterPackage) :
    (lib.containsSemanticLinterPackage pkg ↔
      pkg ∈ lib.semanticLinterPackages) ∧
    (pkg.alertsUsersToCommonMistakes ↔
      pkg.alertsCommonMistakes = true) ∧
    ((∃ p ∈ lib.semanticLinterPackages, p.alertsUsersToCommonMistakes) ↔
      ∃ p ∈ lib.semanticLinterPackages, p.alertsCommonMistakes = true) ∧
    (let mathlib := Concepts.mathlib_witness
     let linters := Concepts.SemanticLinterPackage_witness
     mathlib.name = "mathlib" ∧
     mathlib.containsSemanticLinterPackage linters ∧
     linters.name = "package of semantic linters" ∧
     linters.alertsUsersToCommonMistakes ∧
     (∃ p ∈ mathlib.semanticLinterPackages, p.alertsUsersToCommonMistakes)) := by
  refine ⟨Iff.rfl, Iff.rfl, Iff.rfl, by decide⟩

/-- [Page 2]
"Lean 3 metaprograms have been also instrumental in building standalone applications, such as a SQL query equivalence checker [3]."
-/
theorem lean3_metaprograms_instrumental_in_building_standalone_applications :
    let lean3 := Concepts.lean3_witness
    let sqlChecker := Concepts.sqlQueryEquivalenceChecker_witness
    lean3.name = "Lean 3" ∧
    sqlChecker.name = "SQL query equivalence checker" ∧
    sqlChecker.isBuiltUsingProverMetaprograms lean3 ∧
    lean3.metaprogramsInstrumentalFor sqlChecker ∧
    lean3.hasInstrumentalMetaprogramsForApplications ∧
    (∃ app ∈ lean3.standaloneApplications,
      app.name = "SQL query equivalence checker" ∧
      app.isBuiltUsingProverMetaprograms lean3) := by
  decide

/-- [Page 2]
"We believe the Lean 3 theorem prover's success is primarily due to its extensibility capabilities and metaprogramming framework [6]."
-/
theorem lean3_success_primarily_due_to_extensibility_and_metaprogramming :
    let lean3 := Concepts.lean3_witness
    lean3.name = "Lean 3" ∧
    lean3.hasPrimarySuccessFactor .extensibilityCapabilities ∧
    lean3.hasPrimarySuccessFactor .metaprogrammingFramework ∧
    lean3.successDueToExtensibilityAndMetaprogramming := by
  decide

/-- [Page 2]
"However, users cannot modify many parts of the system without changing Lean 3 source code written in C++."
-/
theorem users_cannot_modify_lean3_parts_without_changing_cpp_source_code :
    let lean3 := Concepts.lean3_witness
    let cpp := Concepts.cppLanguage_witness
    lean3.name = "Lean 3" ∧
    cpp.name = "C++" ∧
    lean3.implLanguage = cpp.name ∧
    lean3.cannotModifyWithoutChangingSourceCodeIn cpp .parser ∧
    lean3.cannotModifyWithoutChangingSourceCodeIn cpp .elaborator ∧
    lean3.cannotModifyWithoutChangingSourceCodeIn cpp .prettyPrinter ∧
    lean3.cannotModifyWithoutChangingSourceCodeIn cpp .codeGenerator ∧
    lean3.hasComponentsRequiringCppSourceChange := by
  decide

/-- [Page 2]
"Another issue is that many proof automation metaprograms are not competitive with similar proof automation implemented in programming languages with an efficient compiler such as C++ and OCaml."
-/
theorem lean3_proof_automation_not_competitive_with_compiled_languages :
    let lean3 := Concepts.lean3_witness
    let cpp := Concepts.cppLanguage_witness
    let ocaml := Concepts.ocamlLanguage_witness
    let mp := Concepts.lean3ProofAutomation_witness
    cpp.name = "C++" ∧
    cpp.hasAnEfficientCompiler ∧
    ocaml.name = "OCaml" ∧
    ocaml.hasAnEfficientCompiler ∧
    mp ∈ lean3.metaprograms ∧
    mp.implementsProofAutomation ∧
    mp.isNotCompetitiveWithCompiled ∧
    lean3.hasNonCompetitiveProofAutomation ∧
    lean3.proofAutomationNotCompetitiveWith cpp ∧
    lean3.proofAutomationNotCompetitiveWith ocaml := by
  decide

/-- [Page 2]
"The primary source of inefficiency in Lean 3 metaprograms is the virtual machine interpretation overhead."
-/
theorem primary_source_of_inefficiency_in_lean3_metaprograms :
    let lean3 := Concepts.lean3_witness
    lean3.name = "Lean 3" ∧
    lean3.hasPrimaryInefficiencySource .virtualMachineInterpretationOverhead ∧
    lean3.isVMInterpretationOverheadPrimaryInefficiency := by
  decide

/-- [Page 2]
"Lean 4 is a reimplementation of the Lean theorem prover in Lean itself."
-/
theorem lean4_is_reimplementation_of_lean_theorem_prover_in_lean
    (leanProver : Concepts.InteractiveTheoremProver)
    (h_prover : leanProver.name = "Lean" ∧ leanProver.language = "Lean") :
    let lean4 : Concepts.InteractiveTheoremProver := Concepts.InteractiveTheoremProver_witness
    lean4.name = "Lean 4" ∧
    lean4.language = "Lean" ∧
    lean4.implLanguage = "Lean" ∧
    lean4.isSelfHosted ∧
    lean4.isReimplementationOf leanProver ∧
    lean4.isReimplementationOf Concepts.leanProject_witness := by
  have h_reimpl : Concepts.InteractiveTheoremProver_witness.isReimplementationOf leanProver := by
    change some "Lean" = some leanProver.name
    rw [h_prover.1]
  exact ⟨rfl, rfl, rfl, rfl, h_reimpl, rfl⟩

/-- [Page 2]
"It is an extensible theorem prover and an efficient programming language."
-/
theorem lean4_is_extensible_theorem_prover_and_efficient_programming_language :
    let lean4 := Concepts.InteractiveTheoremProver_witness
    lean4.name = "Lean 4" ∧
    lean4.isExtensibleTheoremProver ∧
    lean4.isEfficientProgrammingLanguage := by
  decide

/-- [Page 2]
"The new compiler produces C code, and users can now implement efficient proof automation in Lean, compile it into efficient C code, and load it as a plugin."
-/
theorem new_compiler_produces_c_code_and_automation_plugin :
    let lean4 := Concepts.InteractiveTheoremProver_witness
    let compiler := Concepts.Compiler_witness
    let plugin := Concepts.Plugin_witness
    let cLang := Concepts.cLanguage_witness
    let auto := Concepts.ProofAutomationProcedure_witness
    lean4.name = "Lean 4" ∧
    compiler.name = "Lean 4 C compiler" ∧
    compiler.isNewCompiler ∧
    compiler.producesCCode ∧
    compiler.producesLanguage cLang ∧
    lean4.hasCompiler ∧
    lean4.hasNewCompiler ∧
    lean4.compilerProducesCCode ∧
    lean4.compilerProducesLanguage cLang ∧
    auto ∈ lean4.proofAutomationProcedures ∧
    auto.isCustomProcedure ∧
    auto.isEfficientAutomation ∧
    auto.language = "Lean" ∧
    lean4.canImplementEfficientProofAutomationIn "Lean" ∧
    plugin.isCompiledFromAutomation ∧
    plugin.sourceAutomation = some auto ∧
    plugin.isWrittenIn "C" ∧
    plugin.isWrittenInLanguage cLang ∧
    lean4.canLoadPlugin plugin := by
  decide

/-- [Page 2]
"In Lean 4, users can access all internal data structures used to implement Lean by merely importing the Lean package."
-/
theorem lean4_users_can_access_internal_data_structures_by_importing_lean_package :
    let lean4 := Concepts.InteractiveTheoremProver_witness
    let pkg := Concepts.ProverPackage_witness
    let ids := Concepts.InternalDataStructure_witness
    lean4.name = "Lean 4" ∧
    pkg.name = "Lean" ∧
    lean4.proverPackage = some pkg ∧
    ids ∈ lean4.internalDataStructures ∧
    ids.isUsedInImplementation ∧
    (∀ ds ∈ lean4.internalDataStructures, ds.isUsedInImplementation) ∧
    pkg.exportsAllInternalDataStructures ∧
    pkg.exportsDataStructure ids ∧
    pkg.exportsAllInternalDataStructuresOf lean4 ∧
    lean4.canAccessInternalDataStructuresByImporting pkg ∧
    lean4.canAccessInternalDataStructure pkg ids ∧
    lean4.hasAccessToAllInternalDataStructures := by
  decide

/-- [Page 2]
"Lean 4 is also a platform for developing efficient domain-specific automation."
-/
theorem lean4_platform_for_developing_efficient_domain_specific_automation :
    let lean4 := Concepts.InteractiveTheoremProver_witness
    let dsa := Concepts.DomainSpecificAutomation_witness
    lean4.name = "Lean 4" ∧
    dsa ∈ lean4.domainSpecificAutomations ∧
    dsa.isEfficientAutomation ∧
    lean4.isPlatformForDomainSpecificAutomation ∧
    lean4.hasEfficientDomainSpecificAutomation ∧
    lean4.isPlatformForDevelopingEfficientDomainSpecificAutomation ∧
    (∃ a ∈ lean4.domainSpecificAutomations, a.isEfficientAutomation) := by
  decide

/-- [Page 2]
"It has a more robust and extensible elaborator, and addresses many other shortcomings of Lean 3."
-/
theorem lean4_has_more_robust_and_extensible_elaborator_and_addresses_lean3_shortcomings :
    let lean4 := Concepts.InteractiveTheoremProver_witness
    lean4.name = "Lean 4" ∧
    lean4.hasMoreRobustAndExtensibleElaborator ∧
    lean4.addressesShortcomingsOfLean3 := by
  decide

/-- [Page 2]
"We expect the Lean community to extend and add new features without having to change the Lean source code."
-/
theorem lean_community_can_extend_and_add_new_features_without_changing_source_code :
    let lean4 := Concepts.InteractiveTheoremProver_witness
    lean4.name = "Lean 4" ∧
    lean4.communityCanExtendAndAddNewFeaturesWithoutChangingSourceCode := by
  decide

/-- [Page 2]
"We released Lean 4 at the beginning of 2021, it is open source, the community is already porting mathlib, and the number of applications is quickly growing."
-/
theorem lean4_released_in_2021_open_source_porting_mathlib_growing_applications :
    let lean4 := Concepts.InteractiveTheoremProver_witness
    lean4.name = "Lean 4" ∧
    lean4.releasedAtBeginningOf2021 ∧
    lean4.isOpenSourceProver ∧
    lean4.isPortingMathlib ∧
    lean4.hasQuicklyGrowingAppCount := by
  decide

/-- [Page 2]
"It includes a translation verifier for Reopt, a package for supporting inductive-inductive types, and a car controller."
-/
theorem lean4_applications_include_reopt_verifier_inductive_package_and_car_controller :
    let lean4 := Concepts.InteractiveTheoremProver_witness
    let reopt := Concepts.reoptTranslationVerifier_witness
    let indInd := Concepts.inductiveInductivePackage_witness
    let car := Concepts.carController_witness
    lean4.name = "Lean 4" ∧
    reopt.name = "translation verifier for Reopt" ∧
    indInd.name = "package for supporting inductive-inductive types" ∧
    car.name = "car controller" ∧
    lean4.hasApplication reopt ∧
    lean4.hasApplication indInd ∧
    lean4.hasApplication car := by
  decide

-- [Page 2] "2 Lean by Example" — Non-formalizable: section heading; skipped

-- [Page 2] "In this section, we introduce the Lean language using a series of examples." — Non-formalizable: informal narrative transition containing zero technical specifications, rules, or definitions; skipped

-- [Page 2] "The source code for the examples is available at https://github.com/leanprover/lean4/blob/cade2021/doc/BoolExpr.lean." — Non-formalizable: external URL pointer and narrative repository reference containing zero technical specifications, rules, or definitions; skipped

-- [Page 2] "For additional details and installation instructions, we recommend the reader consult the online manual." — Non-formalizable: informal recommendation to consult documentation containing zero technical specifications, rules, or definitions; skipped

/-- [Page 2]
"We define functions by using the def keyword followed by its name, a parameter list, return type, and body."
-/
theorem functions_defined_by_def_name_parameter_list_return_type_and_body :
    let fn := Concepts.FunctionDefinition_witness
    fn.usesDefKeyword ∧
    fn.hasName ∧
    fn.hasParameterList ∧
    fn.hasReturnType ∧
    fn.hasBody := by
  decide

/-- [Page 2]
"The parameter list consists of successive parameters that are separated by spaces."
-/
theorem parameter_list_consists_of_successive_parameters_separated_by_spaces :
    let pl := Concepts.ParameterList_witness
    pl.hasParameters ∧
    pl.isSeparatedBySpaces := by
  decide

/-- [Page 2]
"We can specify an explicit type for each parameter."
-/
theorem can_specify_explicit_type_for_each_parameter :
    let p := Concepts.Parameter_witness
    p.hasType := by
  decide

/-- [Page 2]
"If we do not specify a specific argument type, the elaborator tries to infer the function body's type."
-/
theorem elaborator_tries_to_infer_function_body_type :
    let el := Concepts.Elaborator_witness
    el.isInferringFunctionBodyType := by
  decide

/-- [Page 2]
"The Boolean or function is defined by pattern-matching as follows def or (a b : Bool) := match a with | true => true | false => b."
-/
theorem boolean_or_function_defined_by_pattern_matching :
    let fn := Concepts.booleanOrFunction_witness
    fn.usesDefKeyword ∧
    fn.name = "or" ∧
    fn.hasParameterList ∧
    fn.definedByPatternMatching ∧
    (∀ b : Bool, Concepts.booleanOr true b = true) ∧
    (∀ b : Bool, Concepts.booleanOr false b = b) := by
  decide

/-- [Page 3]
"We can use the command #check <term> to inspect the type of term, and #eval <term> to evaluate it."
-/
theorem check_inspects_type_and_eval_evaluates_term :
    let checkCmd := Concepts.checkCommand_witness
    let evalCmd := Concepts.evalCommand_witness
    checkCmd.isNamed "#check" ∧
    checkCmd.inspectsTypeOfTerm ∧
    evalCmd.isNamed "#eval" ∧
    evalCmd.evaluatesTermValue := by
  decide

/-- [Page 3]
"#check or true false -- Bool (this is a comment in Lean)"
-/
theorem check_or_example_and_lean_comment :
    let checkCmd := Concepts.checkCommand_witness
    let c := Concepts.leanComment_witness
    checkCmd.isNamed "#check" ∧
    checkCmd.inspectsTypeOfTerm ∧
    c.isCommentInLean := by
  decide

end Books
