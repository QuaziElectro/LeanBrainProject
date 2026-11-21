import Lake
open Lake DSL

package «LeanBrainProject» where
  version := v!"0.1.0"

lean_lib «ProjectGate»

@[default_target]
lean_lib «Project» where
  roots := #[`Project]
  plugins := #[`@/ProjectGate:shared]
  precompileModules := true
