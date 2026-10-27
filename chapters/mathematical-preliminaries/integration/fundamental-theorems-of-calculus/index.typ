#import "/lib.typ": *
#show: docs-subsubchapter.with(
  title: [Fundamental Theorems of Calculus],
  route: "fundamental-theorems-of-calculus",
)

The historical significance in the Newton--Leibniz formula is the complete characterization of the fundamental relation between integration and differentiation, given by:
#theorem[Newton--Leibniz][
  $ dv(, x) integral_a^x f(t) dt = f(x), wide integral_a^b f'(x) dx = f(b) - f(a). $
]
Let $va(c)$ be a constant vector, $phi$ be a scalar, and $va(A) = A_k vu(e)_k$ be a vector.

By virtue of a suitable generalization of differentiation, the previous relation can then be extended to the following:
#theorem[Gradient Theorem][
  If $gamma$ is a curve between $a$ and $b$ in $RR^n$, then for $phi : C -> RR$, $ integral_gamma grad phi dot dif va(l) = phi(b) - phi(a). $
] <thm:gradient>
#theorem[Green's Theorem][
  If $S$ is a planar domain with boundary $partial S$, then for $va(F) : S -> RR^2$,
  $ integral_(partial S) va(F) dot dif va(l) = integral.double_S nabla times va(F) dif A $
]
and its generalization
#theorem[Stokes' Theorem][
  If $S subset RR^3$ is a surface with boundary $partial S$, then for $va(F) : S -> RR^3$,
  $ integral_(partial S) va(F) dot dif va(l) = integral.double_S (curl va(F)) dot dif va(S) $
] <thm:stokes>
#corollary[
  $ integral.cont_(partial S) phi dif va(l) = integral.double_S dif va(S) times grad phi $
  and
  $
    integral.cont_(partial S) dif va(l) times va(psi) = integral.double_S grad psi_k dif S_k - integral.double_S (div va(psi)) dif va(S).
  $
] <cor:stokes-substitutions>
#proof(collapsed: true)[
  Choose $va(F) = phi va(c)$ to get
  $
    integral.cont_(partial S) phi va(c) dot dif va(l) &= integral.double_S curl (phi va(c)) dot dif va(S) = integral.double_S (grad phi times va(c) + phi curl va(c)) dot dif va(S) \
    &=integral.double_S (grad phi times va(c)) dot dif va(S) = integral.double_S (dif va(S) times grad phi) dot va(c),
  $
  giving
  $
    va(c) dot integral.cont_(partial S) phi dif va(l) = va(c) dot integral.double_S dif va(S) times grad phi, \
    (integral.cont_(partial S) phi dif va(l) - integral.double_S dif va(S) times grad phi) perp RR^3, \
    integral.cont_(partial S) phi dif va(l) = integral.double_S dif va(S) times grad phi;
  $
  and choose $va(F) = va(psi) times va(c)$ to get
  $
    &integral.cont_(partial S) (va(psi) times va(c)) dot dif va(l) = integral.cont_(partial S) (dif va(l) times va(psi)) dot va(c) = integral.double_S [curl (va(psi) times va(c))] dot dif va(S) \
    &wide ""= integral.double_S [va(psi) (div va(c)) - va(c) (div va(psi)) + (va(c) dot grad) va(psi) -(va(psi) dot grad) va(c)] dot dif va(S),
  $
  whence
  $
    va(c) dot integral.cont_(partial S) dif va(l) times va(psi) &= integral.double_S [(va(c) dot grad) va(psi) - va(c) (div va(psi))] dot dif va(S) \
    &= integral.double_S (va(c) dot grad) va(psi) dot dif va(S) - va(c) dot integral.double_S (div va(psi)) dif va(S).
  $
  From the first integrand of the right-hand side giving
  $
    (va(c) dot grad) va(psi) dot dif va(S) = [(va(c) dot grad) va(psi)]_k dif S_k = va(c) dot grad psi_k dif S_k,
  $
  we have
  $
    va(c) dot integral.cont_(partial S) dif va(l) times va(psi) = va(c) dot integral.double_S grad psi_k dif S_k - va(c) dot integral.double_S (div va(psi)) dif va(S), \
    (integral.cont_(partial S) dif va(l) times va(psi) - va(c) dot integral.double_S grad psi_k dif S_k + va(c) dot integral.double_S (div va(psi)) dif va(S)) perp RR^3.\
    integral.cont_(partial S) dif va(l) times va(psi) = integral.double_S grad psi_k dif S_k - integral.double_S (div va(psi)) dif va(S). #qedhere
  $
]
and
#theorem[Divergence Theorem][
  If $V subset RR^3$ is a region with boundary $partial V$, then for $va(F) : V -> RR^3$,
  $ integral.surf_(partial V) va(F) dot dif va(S) = integral.triple_V div va(F) dif V. $ <eq:divergence>
] <thm:divergence>
#corollary[
  $ integral.surf_(partial V) phi dif va(S) = integral.triple_V grad phi dif V $
  and
  $ integral.surf_(partial V) dif va(S) times va(psi) = integral.triple_V curl va(psi) dif V $
] <cor:divergence-substitutions>
#proof(collapsed: true)[
  Choose $va(F) = phi va(c)$ to get
  $
    integral.double_(partial V) phi va(c) dot dif va(S) = integral.triple_V div (phi va(c)) dif V = integral.triple_V [grad phi dot va(c) + phi div va(c)] dif V, \
    va(c) dot integral.double_(partial V) phi dif va(S) = va(c) dot integral.triple_V grad phi dif V, \
    (integral.double_(partial V) phi dif va(S) - integral.triple_V grad phi) perp RR^3, \
    integral.double_(partial V) phi dif va(S) = integral.triple_V grad phi dif V;
  $
  and choose $va(F) = va(psi) times va(c)$ to get
  $
    &integral.double_(partial V) (va(psi) times va(c)) dot dif va(S) = integral.double_(partial V) (dif va(S) times va(psi)) dot va(c)=integral.triple_V div (va(psi) times va(c)) dif V \
    &wide wide"" = integral.triple_V [va(c) dot (curl va(psi)) - va(psi) dot (curl va(c))] dif V,
  $
  whence
  $
    va(c) dot integral.surf_(partial V) dif va(S) times va(psi) = va(c) dot integral.triple_V curl va(psi) dif V, \
    (integral.surf_(partial V) dif va(S) times va(psi) - integral.triple_V curl va(psi) dif V) perp RR^3, \
    integral.surf_(partial V) dif va(S) times va(psi) = integral.triple_V curl va(psi) dif V. #qedhere
  $
]
#corollary[Green's Identities][
  If $phi, psi$ are scalars and $va(P), va(Q)$ are vectors, then we have
  $
    integral.triple_V (phi laplacian psi + grad phi dot grad psi) dif V = integral.surf_(partial V) phi grad psi dot dif va(S)
  $
  (Green's first identity) and
  $
    integral.triple_V (phi laplacian psi - psi laplacian phi) dif V = integral.surf_(partial V) (phi grad psi - psi grad phi) dot dif va(S)
  $
  (Green's second identity) and their vector forms
  $
    integral.triple_V [-va(P) dot /* op(bold("curl"))^2 */ curl curl va(Q) + curl va(P) dot curl va(Q)] dif V = integral.surf_(partial V) va(P) times curl va(Q) dot dif va(S),
  $
  (Green's first identity) or less verbosely,
  $
    integral.triple_V [-va(P) dot op(bold("curl"))^2 va(Q) + op(bold("curl")) va(P) dot op(bold("curl")) va(Q)] dif V = integral.surf_(partial V) va(P) times op(bold("curl")) va(Q) dot dif va(S),
  $
  and Green's second identity
  $
    integral.triple_V [-va(P) dot curl curl va(Q) + va(Q) dot curl curl va(P)] dif V = integral.surf_(partial V) [va(P) times curl va(Q) - va(Q) times curl va(P)] dot dif va(S), \
    integral.triple_V [-va(P) dot op(bold("curl"))^2 va(Q) + va(Q) dot op(bold("curl"))^2 va(P)] dif V = integral.surf_(partial V) [va(P) times op(bold("curl")) va(Q) - va(Q) times op(bold("curl")) va(P)] dot dif va(S).
  $
] <cor:greens-identities>
#proof(collapsed: not false)[
  #todo[Green's first and second]
  Let $va(F) = phi grad psi$ in @thm:divergence to obtain Green's first identity:
  $
    integral.surf_(partial V) phi grad psi dot dif va(S) & = integral.triple_V div(phi grad psi) dif V= integral.triple_V [phi div grad psi + grad phi dot grad psi] dif V.
  $
  Now interchanging $phi$ and $psi$,
  $
    integral.surf_(partial V) psi grad phi dot dif va(S) = integral.triple_V [psi div grad phi + grad psi dot grad phi] dif V;
  $
  the difference of the two equations above gives the second identity.

  Let $va(F) = va(P) times curl va(Q)$ so that $div va(F) = curl va(Q) dot (curl va(P)) - va(P) dot (curl curl va(Q))$, yielding the vector first identity. After interchanging $va(P)$ and $va(Q)$, the difference between the two equations gives the second identity.
]

#todo[Stokes--Cartan]
