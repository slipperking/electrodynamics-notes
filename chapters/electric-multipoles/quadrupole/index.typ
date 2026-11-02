#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("The Electric Quadrupole"),
  children: {
    include "traceless-quadrupole-tensor/index.typ"
    include "quadrupole-force-and-torque/index.typ"
  },
)

