#import "/lib.typ": *
#show: docs-subsubchapter.with(
  title: [The One-Dimensional Dirac Delta],
  route: "one-dimensional-dirac-delta",
)
Define the Dirac Delta (generalized) function to be a function with the property that for any smooth (compactly supported) function $f: RR -> RR$ and $a in RR$,
$ integral_(-oo)^oo f(x) delta(x - a) dx = f(a), $ <eq:dirac-delta-filtering>
or the satisfaction of the _filtering_ property. It is commonly expressed and thought of colloquially as
$
  delta(x) = cases(0 & quad "if" x != 0, oo & quad "if" x = 0) quad "such that" quad integral_(-oo)^oo delta(x) dx = 1.
$
The above corresponds to the understanding thereof as the limit of a sequence of functions each integrating to $1$, such that the point at $0$ becomes more highly peaked at each iteration and that the values off $0$ vanish for sufficiently many iterations, including, but not limited to the following:
$
  delta(x) & = lim_(n -> oo) n / sqrt(uppi) ee^(-n^2 x^2), \
  delta(x) & = lim_(epsilon -> 0^+) epsilon / (uppi(x^2 + epsilon^2)),
$
(where we note that the given limits are evaluated _distributionally_.) The proof of the the two given representations is the involved process of proving the filtering property.
#proof(collapsed: true)[of the Gaussian representation][
  For any such function,
  $
    lim_(n -> oo) integral_RR f(x) n / sqrt(uppi) ee^(-n^2 x^2) dx &= integral_RR lim_(n -> oo) f(x / n) n / sqrt(uppi) ee^(-x^2) dx / n \ &= f(0) integral_RR ee^(-x^2) / sqrt(uppi) dx = f(0). qedhere
  $
]
#proof(collapsed: true)[of the Cauchy representation][
  Similar to the previous representation,
  $
    lim_(epsilon -> 0^+) integral_RR f(x) (epsilon dx) / (uppi(x^2 + epsilon^2)) &= integral_RR lim_(epsilon -> 0^+) f(x epsilon) (epsilon^2 dx) / (uppi(epsilon^2 x^2 + epsilon^2)) \ &= f(0) integral_RR dx / (uppi(x^2 + 1)) = f(0). qedhere
  $
]
However, it is also paramount to note that it is insufficient to extend the colloquial model of the Dirac delta to all possible representations, nor can it replace the definition by the filtering property. For this we note
$
  delta(x) & = lim_(n -> oo) (sin (n x)) / (uppi x),
$
whose values do not vanish away from $0$: for any $epsilon > 0$, $exists delta > 0 : exists N in NN$ such that $forall n > N$, $exists x' : abs(x') > delta$ such that $abs((sin (n x)) / (uppi x)) > epsilon$. (The previously discussed representations do not have this irregularity.) Graphically, it is the limit of increasingly oscillatory functions dampened by $uppi / x$.
#proof(collapsed: true)[of the $sinc$ representation][
  //
  We have
  $
    lim_(n -> oo) integral_RR f(x) sin(n x) / (uppi x) dx & = lim_(n -> oo) integral_RR f(x / n) (sin x) / (uppi x) dx.
  $
  More involvedly, we avoid directly transmuting the limit into the integral as it is not absolutely integrable (we will avoid paying attention into details as such in future sections. For our purposes this is to emphasize a singularity). Thence in
  $
    lim integral_RR f(x / n) (sin x) / (uppi x) dx - f(0) &= lim integral_RR f(x / n) (sin x) / (uppi x) dx - f(0) integral_RR (sin x) / (uppi x) dx \
    &= lim (integral_(-oo)^(-epsilon) + integral_(-epsilon)^epsilon + integral_epsilon^oo) [f(x / n) - f(0)] (sin x) / (uppi x) dx,
  $
  the middle integral allows for such a transmutation, while the outer two tails vanish by the Riemann--Lebesgue Lemma (or even by integration by parts). Then
  $
    lim integral_RR f(x / n) (sin x) / (uppi x) dx - f(0) = integral_(-epsilon)^epsilon lim [f(x / n) - f(0)] (sin x) / (uppi x) dx = 0 #qedhere
  $
]
The same methodology can be used for the following identities:
#let dv-t = math-markup(eref(<eq:dirac-delta-derivative>)[(#sym.ast.op)]);
#etarget(
  $
    delta(a x) = - delta(x) / abs(a) quad "for" quad a != 0, \
    integral_RR delta'(x - x') f(x) dx = -f'(x'), #tag[#math-markup(link-wrap: true)[(#sym.ast.op)]] \
    delta(g(x)) = sum_(x' in RR \ g(x') = 0, \
    g'(x') != 0) delta(x - x') / abs(g'(x')), \
    delta(x) = 1 / (2 uppi) integral_RR ee^(ii x x') dif x',
  $,
  <eq:dirac-delta-derivative>,
)
where the derivative in #dv-t is formally the definition given to the _distributional derivative_. To understand its motivation, we appeal to integration by parts:
