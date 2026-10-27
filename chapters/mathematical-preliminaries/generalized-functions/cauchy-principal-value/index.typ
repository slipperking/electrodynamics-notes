#import "/lib.typ": *
#show: docs-subsubchapter.with(
  title: [Cauchy Principal Value],
  route: "cauchy-principal-value",
)
#theorem[Sokhotski--Plemelj Theorem][
  (Distributionally,)
  $
    lim_(epsilon -> oo) 1 / (x - x_0 plus.minus ii epsilon) = pv 1 / (x - x_0) minus.plus ii uppi delta(x - x_0).
  $
]
