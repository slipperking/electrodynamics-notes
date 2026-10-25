#import "/lib.typ": *
#show: docs-subsubchapter.with(
  title: [The One-Dimensional Dirac Delta],
  route: "one-dimensional-dirac-delta",
)
Define the Dirac Delta (generalized) function to be a function with the property that for any smooth function $f: RR -> RR$ and $a in RR$,
$ integral_(-oo)^oo f(x) delta(x - a) dx = f(a), $ <eq:dirac-delta-filtering>
or the satisfaction of the _filtering_ property. It is commonly expressed and thought of colloquially as
$
  delta(x) = cases(0 & quad "if" x != 0, oo & quad "if" x = 0) quad "such that" quad integral_(-oo)^oo delta(x) dx = 1.
$
It can also be understood as the limit of a sequence of functions each integrating to $1$, such that the point at $0$ becomes more highly peaked at each iteration and the ones around it decrease to $0$ for sufficiently many iterations, including, but not limited to the following:
$ delta(x) = lim_(n -> oo) (sin (n x)) / (uppi x) $
