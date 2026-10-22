#import "/lib.typ": *
#show: docs-subsubchapter.with(
  title: [Fundamental Theorems of Calculus],
  route: "fundamental-theorems-of-calculus",
)

The historical significance in the Newton--Leibniz formula is the complete characterization of the fundamental relation between integration and differentiation, given by:
#theorem[Newton--Leibniz][
  $ dv(, x) integral_a^x f(t) dt = f(x), wide integral_a^b f'(x) dx = f(b) - f(a). $
]
Let $va(c)$ be a constant vector, $phi(va(r))$ be a scalar, and $va(A)(va(r))$ be a vector.

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
] <thm:divergence>
#remark[
  Choose $va(F)(va(r)) = phi(va(r)) va(c)$ to get
  $
    integral.double_(partial V) phi(va(r)) va(c) dot dif va(S) = integral.triple_V div (phi(va(r)) va(c)) dif V = integral.triple_V grad phi(va(r)) dot va(c) dif V, \
    va(c) dot integral.double_(partial V) phi(va(r)) dif va(S) = va(c) dot integral.triple_V grad phi(va(r)) dif V, \
    (integral.double_(partial V) phi(va(r)) dif va(S) - integral.triple_V grad phi(va(r))) perp RR^3, \
    integral.double_(partial V) phi(va(r)) dif va(S) = integral.triple_V grad phi(va(r)) dif V;
  $
  and choose $va(F) (va(r)) = va(psi)(va(r)) times va(c)$ to get
  $
    &integral.double_(partial V) (va(psi)(va(r)) times va(c)) dot dif va(S) = integral.double_(partial V) (dif va(S) times va(psi)(va(r))) dot va(c) \
    &wide wide""=integral.triple_V div (va(psi)(va(r)) times va(c)) dif V = integral.triple_V va(c) dot (curl va(psi)(va(r))) dif V,
  $
  whence
  $
    va(c) dot integral.surf_(partial V) dif va(S) times va(psi)(va(r)) = va(c) dot integral.triple_V curl va(psi)(va(r)) dif V, \
    (integral.surf_(partial V) dif va(S) times va(psi)(va(r)) - integral.triple_V curl va(psi)(va(r)) dif V) perp RR^3, \
    integral.surf_(partial V) dif va(S) times va(psi)(va(r)) = integral.triple_V curl va(psi)(va(r)) dif V. // #qedhere
  $
]
#todo()
#todo[Green's first and second]

