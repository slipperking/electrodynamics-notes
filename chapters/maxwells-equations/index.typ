#import "/lib.typ": *
#show: docs-chapter.with(
  ..dargs("Maxwell's Equations"),
  children: {
    include "electric-charges/index.typ"
    include "current-density/index.typ"
    include "conservation-of-charge/index.typ"
    include "electric-field/index.typ"
  },
)
