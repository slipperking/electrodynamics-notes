#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("The Electric Dipole"),
  children: {
    include "singularity-at-origin/index.typ"
    include "dipole-force-and-torque/index.typ"
    include "dipole-potential-energy/index.typ"
    include "dipole-layers/index.typ"
  },
)

#thm-state.thm-restate("def:electric-dipole-moment")
