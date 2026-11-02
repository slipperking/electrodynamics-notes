#import "/lib.typ": *
#show: docs-chapter.with(
  ..dargs("Electrostatics"),
  children: {
    // include "electric-charges/index.typ"
    // include "current-density/index.typ"
    // include "conservation-of-charge/index.typ"
    // include "electric-field/index.typ"
    include "electric-potential/index.typ"
    include "work-and-energy/index.typ"
    include "electric-stress-tensor/index.typ"
  },
)
