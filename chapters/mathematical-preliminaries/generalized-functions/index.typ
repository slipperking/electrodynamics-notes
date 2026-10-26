#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [Generalized Functions],
  route: "generalized-functions",
  children: {
    include "one-dimensional-dirac-delta/index.typ"
    include "cauchy-principal-value/index.typ"
    include "multi-dimensional-dirac-delta/index.typ"
  },
)
