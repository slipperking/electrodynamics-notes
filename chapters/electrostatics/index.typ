#import "/lib.typ": *
#show: docs-chapter.with(
  title: [Electrostatics],
  route: "electrostatics",
  children: {
    include "electric-charges/index.typ"
    include "current-density/index.typ"
    include "conservation-of-charge/index.typ"
    include "electric-field/index.typ"
    include "electric-potential/index.typ"
  },
)
