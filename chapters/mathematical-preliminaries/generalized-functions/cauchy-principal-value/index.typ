#import "/lib.typ": *
#show: docs-subsubchapter.with(
  title: [Cauchy Principal Value],
  route: "cauchy-principal-value",
)
It is trivially known that the integral
$ integral_(-a)^a dx / x $
is divergent, despite its integrand being odd. This is due to the incumbent convergence of the integrals $integral_0^a dx/x$ and $integral_(-a)^0 dx/x$. But in a symmetric sense, it should prove plausible that a secondary notion exists wherein this symmetry is accounted for. For this purpose the Cauchy Principal Value is defined as such:
$ pv integral_(-a)^a dx / x = lim_(epsilon -> 0^+) (integral_(-a)^(-epsilon) + integral_epsilon^a) dx / x = 0. $
For an arbitrary test function,
$
  pv integral_(-oo)^oo f(x) / (x - x_0) dx = lim_(epsilon -> 0^+) (integral_(-oo)^(x_0 - epsilon) + integral_(x_0 + epsilon)^oo) f(x) / (x - x_0) dx.
$
#claim[
  (Distributionally,)
  $
    lim_(epsilon -> 0^+) x /(x^2 + epsilon^2) = pv 1 / x,
  $
  which we interpret in the distributional sense, which is to say that for any test function $f$,
  $
    lim_(epsilon -> 0^+) integral_RR (x f(x)) / (x^2 + epsilon^2) dx = pv integral_(-oo)^oo f(x) / x dx.
  $ <eq:real-plemelj>
]
#proof[
  $
    lim_(epsilon -> 0^+) integral_RR (x f(x)) / (x^2 + epsilon^2) dx &= lim_(epsilon -> 0^+) integral_0^oo (x f(x)) / (x^2 + epsilon^2) dx + integral_(-oo)^0 (x f(x)) / (x^2 + epsilon^2) dx \
    & = lim_(epsilon -> 0^+) integral_0^oo (x f(x)) / (x^2 + epsilon^2) dx + integral_0^oo (x f(-x)) / (x^2 + epsilon^2) dx\
    & = lim_(epsilon -> 0^+) integral_0^oo [f(x) + f(-x)] x / (x^2 + epsilon^2) dx\
    & = integral_0^oo (f(x) + f(-x)) / x dx = lim_(delta -> 0^+) integral_delta^oo (f(x) + f(-x)) / x dx \
    & = lim_(delta -> 0^+) (integral_(-oo)^(-delta) + integral_delta^oo) f(x) / x dx = pv integral_(-oo)^oo f(x) / x dx. qedhere
  $
]
#theorem[Sokhotski--Plemelj Theorem][
  (Distributionally,)
  $
    lim_(epsilon -> 0^+) 1 / (x - x_0 plus.minus ii epsilon) = pv 1 / (x - x_0) minus.plus ii uppi delta(x - x_0),
  $
  whence for any test function $f$,
  $
    lim_(epsilon -> 0^+) integral_RR f(x) / (x - x_0 plus.minus ii epsilon) dx = pv integral_RR f(x) / (x - x_0) dx minus.plus ii uppi integral_RR f(x) delta(x - x_0) dx.
  $
] <thm:plemelj>
#proof[
  To eschew any pedantry, let $x' = x - x_0$. Then due to @eq:delta-basic-identities and @eq:real-plemelj,
  $
    lim_(epsilon -> 0^+) integral_RR f(x) / (x - x_0 plus.minus ii epsilon) dx &= lim_(epsilon -> 0^+) integral_RR (f(x) (x' minus.plus ii epsilon)) / (x'^2 + epsilon^2) dx' \
    &= lim_(epsilon -> 0^+) integral_RR (x' f(x)) / (x'^2 + epsilon^2) dx' minus.plus ii lim_(epsilon -> 0^+) integral_RR epsilon / (x'^2 + epsilon^2) f(x) dx' \
    &= pv integral_RR f(x) / x' dx' minus.plus ii uppi integral_RR delta(x') f(x) dx' \
    &= pv integral_RR f(x) / (x - x_0) dx minus.plus ii uppi integral_RR delta(x - x_0) f(x) dx. qedhere
  $
]
