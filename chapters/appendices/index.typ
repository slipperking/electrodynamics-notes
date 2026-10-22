#if sys.inputs.at("debug-build", default: none) != "true" {
  include "list-of-theorems/index.typ"
  include "table-of-figures/index.typ"
}
