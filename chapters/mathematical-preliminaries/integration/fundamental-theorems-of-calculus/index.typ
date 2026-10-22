#import "/lib.typ": *
#show: docs-subsubchapter.with(
  title: [Fundamental Theorems of Calculus],
  route: "fundamental-theorems-of-calculus",
)

The historical significance in the Newton--Leibniz formula is the complete characterization of the fundamental relation between integration and differentiation, given by:
#theorem[Newton--Leibniz][
  $ dv(, x) integral_a^x f(t) dt = f(x), wide integral_a^b f'(x) dx = f(b) - f(a). $
]
By virtue of a suitable generalization of differentiation, the previous relation can then be extended to the following:
#theorem[Gradient Theorem][
  If $gamma$ is a curve between $a$ and $b$ in $RR^n$, then for $phi : C -> RR$, $ integral_gamma grad phi dot dif va(r) = phi(b) - phi(a). $
]
#theorem[Green's Theorem][
  If $S$ is a planar domain with boundary $partial S$, then for $va(F) : S -> RR^2$,
  $ integral_(partial S) va(F) dot dif va(r) = integral.double_S nabla times va(F) dif A $
]
and its generalization
#theorem[Stokes' Theorem][
  If $S subset RR^3$ is a surface with boundary $partial S$, then for $va(F) : S -> RR^3$,
  $ integral_(partial S) va(F) dot dif va(r) = integral.double_S (curl va(F)) dot dif va(S) $
]
and
#theorem[Divergence Theorem][
  If $V subset RR^3$ is a region with boundary $partial V$, then for $va(F) : V -> RR^3$,
  $ integral.double_(partial V) va(F) dot dif va(S) = integral.triple_V div va(F) dif V. $
]
Letting $va(c)$ be a constant vector, $phi(va(r))$ be a scalar, $va(A)(va(r))$ be a vector, choosing $va(F)(va(r)) = phi(va(r)) va(c)$ gives the additional identities:
#todo()
#todo[Green's first and second]

