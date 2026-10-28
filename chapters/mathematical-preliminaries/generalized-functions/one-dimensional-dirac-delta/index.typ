#import "/lib.typ": *
#show: docs-subsubchapter.with(
  title: [The One-Dimensional Dirac Delta],
  route: "one-dimensional-dirac-delta",
)
Define the Dirac Delta (generalized) function to be a function with the property that for any smooth compactly supported function (formally referred to as a _bump function_) $f: RR -> RR$ and $a in RR$,
$ integral_(-oo)^oo f(x) delta(x - a) dx = f(a), $ <eq:dirac-delta-filtering>
or the satisfaction of the _filtering_ property. It is commonly expressed and thought of colloquially as
$
  delta(x) = cases(0 & quad "if" x != 0, oo & quad "if" x = 0) quad "such that" quad integral_(-oo)^oo delta(x) dx = 1.
$
The above corresponds to the understanding thereof as the limit of a sequence of functions each integrating to $1$, such that the point at $0$ becomes more highly peaked at each iteration and that the values off $0$ vanish for sufficiently many iterations, including, but not limited to the following:
$
  delta(x) & = lim_(n -> oo) n / sqrt(uppi) ee^(-n^2 x^2), \
  delta(x) & = lim_(epsilon -> 0^+) epsilon / (uppi(x^2 + epsilon^2)),
$ <eq:delta-basic-identities>
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
    lim integral_RR f(x / n) (sin x) / (uppi x) dx - f(0) = integral_(-epsilon)^epsilon lim [f(x / n) - f(0)] (sin x) / (uppi x) dx = 0. #qedhere
  $
]
The same methodology can be used for the following identities:
#let dv-t(n) = math-markup(eref(<eq:dirac-delta-identities>)[(#{ [#sym.ast.op] * n })]);
#etarget(
  $
    delta(a x) = delta(x) / abs(a) quad "for" quad a != 0, #tag[#math-markup(link-wrap: true)[(#sym.ast.op)]] \
    integral_RR delta'(x - x') f(x) dx = -f'(x'), #tag[#math-markup(link-wrap: true)[(#sym.ast.op#sym.ast.op)]] \
    delta(g(x)) = sum_(
    x' in RR \ g(x') = 0,
    ) delta(x - x') / abs(g'(x')), #tag[(if $0 < abs(g') < oo$ at all zeros)]\
    delta(x) = 1 / (2 uppi) integral_RR ee^(ii k x) dif k,
  $,
  <eq:dirac-delta-identities>,
)
where the derivative in #dv-t(2) is formally the definition given to the _distributional derivative_. To understand its motivation, we appeal to integration by parts:
$
  integral_RR delta'(x - x') f(x) dx & = evaluated(delta(x - x') f(x))_(-oo)^oo - integral_RR delta(x-x') f'(x) dx \
                                     & = - integral_RR delta(x-x') f'(x) dx = -f'(x')
$
(the first term vanishes under the assumption $f$ has compact support). Strictly speaking, the composition identity is also by distributional definition; therefore the "proof" we shall proceed to give comprises a heuristic explanation. We also point out that the last identity does not converge as an integral; it behaves analogously to the $op("sinc")$ representation, as it shall transpire later.
#proof(collapsed: true)[of the scaling property #dv-t(1)][
  To ensure consistency in the substitution properties of integration,
  $
    integral_(-oo)^oo delta(a x) f(x) dx &= integral_(-oo sgn(a))^(oo sgn(a)) delta(x) f(x / a) dx / a =/*  sgn(a) */ integral_(-oo)^oo (delta(x)) / abs(a) f(x / a) dx \
    &= f(0) / abs(a) = integral_(-oo)^oo (delta(x)) / abs(a) f(x) dx.
  $
  By comparison of the left- and right-hand sides, $delta(a x) = (delta(x)) / abs(a)$ (recall that the utilization of the Dirac delta appertains exclusively to "integration").
]
#proof(collapsed: true)[of the composition identity (heuristic)][
  #lorem(1)
  Consider $g$ to be a function with zeros of multiplicities not exceeding $1$. Then
  $
    integral_(-oo)^oo delta(g(x))
  $
]
#proof(collapsed: true)[of the Fourier identity][
  Let $n > 0$ be arbitrary. Then
  $
    lim_(n -> oo) 1 / (2 uppi) integral_(-n)^n ee^(ii k x) dif k = lim_(n -> oo) 1 / (2 uppi ii x) evaluated(ee^(ii k x))_(-n)^n = lim_(n -> oo) sin(n x) / (uppi x) = delta(x)
  $
  by a previously proven identity.
]
#proof(collapsed: true)[of the Fourier identity (alternative 1)][
  By introduction of a convergence factor dampening the oscillation,
  $
    1 / (2 uppi) integral_RR ee^(ii k x) dif k &= 1 / (2 uppi) lim_(epsilon -> 0^+) integral_0^oo [ee^(ii k x - k epsilon) + ee^(-ii k x - k epsilon)] dif k \ &= 1 / (2 uppi) lim_(epsilon -> 0^+) evaluated([ee^(ii k x - k epsilon) / (ii x - epsilon) - ee^(-ii k x - k epsilon) / (ii x + epsilon)])_0^oo \ &= 1 / (2 uppi) lim_(epsilon -> 0^+) 1 / (ii x + epsilon) - 1 / (ii x - epsilon)\ &= 1 / (2 uppi) lim_(epsilon -> 0^+) epsilon / (uppi(x^2 + epsilon^2)) = delta(x)
  $
  by a previously proven identity.
]

#proof(collapsed: true)[of the Fourier identity (alternative 2)][
  #todo[Decide upon the prospect of doing an alternative one of greater directness.]
]
With consideration of the present coverage, it is natural to consider the result of integrating $delta$. In accordance, appealing somewhat to heuristics, let
$
  tilde(Theta)(x) = cases(0 & quad "if" x < 0, 1 & quad "if" x > 0),
$
so that
$
  Theta(x) = integral_(-oo)^x delta(x') dx' = integral_(-oo)^oo delta(x') tilde(Theta)(x - x') dx = tilde(Theta)(x),
$
The function $Theta$ is formally referred to as the _Heaviside function_, where popular convention dictates $Theta(0) = 1/2$. As a distribution, it is defined by $Theta' = delta$, with respect to the distributional derivative. It naturally transpires to be an affine transformation of the sign function:
$ sgn(x) = 2 Theta(x) - 1, wide sgn'(x) = 2 delta(x). $

// heaviside stuff, maybe appeal to distributions,
// maybe add distributions to an appendix!!!!!
