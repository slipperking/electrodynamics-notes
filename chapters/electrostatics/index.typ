#import "/lib.typ": *
#show: docs-chapter.with(
  ..dargs("Electrostatics"),
  children: {
    include "electric-potential/index.typ"
    include "work-and-energy/index.typ"
    include "electric-stress-tensor/index.typ"
  },
)
