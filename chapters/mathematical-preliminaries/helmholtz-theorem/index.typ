#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [Helmholtz Decomposition Theorem],
  route: "Helmholtz-theorem",
)
#theorem[Helmholtz Decomposition Theorem][
  For a sufficiently smooth time-static vector field $va(F) : V subset.eq RR^3 -> RR^3$, the Helmholtz Decomposition Theorem guarentees the existence of a decomposition of $va(F)$ by an irrotational field $va(F)_parallel$ with zero curl and a solenoidal field $va(F)_perp$ with zero divergence. Moreover, $exists phi$ such that $-grad phi = va(F)_parallel$, known as the _scalar potential_ of $va(F)_parallel$; and $exists va(A)$, the _vector potential_ of $va(F)_perp$, such that $va(F)_perp = curl va(A)$. Then
  $ va(F) = curl va(A) - grad phi. $
]
A given decomposition may be explicitly given by:
$
  phi(va(r)) = 1 / (4 uppi) [integral.triple_V (divp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V' - integral.surf_(partial V) (va(F)(va(r)')) / norm(va(r)' - va(r)) dot dif va(S)']
$
and
$
  va(A)(va(r)) = 1 / (4 uppi) [integral.triple_V (curlp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V' + integral.surf_(partial V) (va(F)(va(r)')) / norm(va(r)' - va(r)) times dif va(S)'],
$
where $divp(dot), curlp(dot)$ are the respective divergence and curl with respect to the integration variable $va(r)'$. The given representations are valid only if the integrals converge.

If $V = RR^3$, then the surface terms may be elided when $va(F)(va(r)) = order(1 / r)$:
$
  phi(va(r)) = 1 / (4 uppi) integral.triple_(RR^3) (divp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V', wide va(A)(va(r)) = 1 / (4 uppi) integral.triple_(RR^3) (curlp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V'.
$
Moreover, the representation above is unique for all decompositions with potentials $phi$ and $va(A)$ that vanish at $oo$.
#proof[
  By the filtering property, letting $grad(dot), curl(dot), div(dot), laplacian(dot)$ denote the differential operators with respect to $va(r)$, we have
  $
    va(F)(va(r)) & = integral.triple_V va(F)(va(r)') delta(va(r)' - va(r)) dif V' \
    & = - 1 / (4 uppi) integral.triple_V va(F)(va(r)') laplacian 1 / norm(va(r)' - va(r)) dif V' \
    & = 1 / (4 uppi) integral.triple_V [curl[curl (va(F)(va(r)')) / norm(va(r)' - va(r))] - grad(div (va(F)(va(r)')) / norm(va(r)' - va(r)))] dif V' \
    & = curl 1 / (4 uppi) integral.triple_V curl (va(F)(va(r)')) / norm(va(r)' - va(r)) dif V' - grad 1 / (4 uppi) integral.triple_V div (va(F)(va(r)')) / norm(va(r)' - va(r)) dif V' \
    & = curl 1 / (4 uppi) integral.triple_V (curl va(F)(va(r)')) / norm(va(r)' - va(r)) dif V' + curl 1 / (4 uppi) integral.triple_V grad 1 / norm(va(r)' - va(r)) times va(F)(va(r)') dif V' \
    & wide "" - grad 1 / (4 uppi) integral.triple_V (div va(F)(va(r)')) / norm(va(r)' - va(r)) dif V' - grad 1/ (4 uppi) integral.triple_V grad 1 / (norm(va(r)' - va(r))) dot va(F) (va(r)') dif V'.
  $
  Since $div va(F)(va(r)') = 0 = curl va(F) (va(r)')$, it follows
  $
    va(F)(va(r)) & = curl 1 / (4 uppi) integral.triple_V grad 1 / (norm(va(r)' - va(r))) times va(F)(va(r)') dif V' \
                 & wide "" - grad 1/ (4 uppi) integral.triple_V grad 1 / (norm(va(r)' - va(r))) dot va(F) (va(r)') dif V'.
  $
  Using $grad f(va(r) - va(r)') = -gradp f(va(r)' - va(r))$, we have
  $
    va(F)(va(r)) & = -curl 1 / (4 uppi) integral.triple_V gradp 1 / (norm(va(r)' - va(r))) times va(F)(va(r)') dif V' \
    & wide "" + grad 1/ (4 uppi) integral.triple_V gradp 1 / (norm(va(r)' - va(r))) dot va(F) (va(r)') dif V' \
    & = -curl 1 / (4 uppi) integral.triple_V [curlp (va(F)(va(r)')) / (norm(va(r)' - va(r))) - (curlp va(F)(va(r)')) / (norm(va(r)' - va(r)))]dif V' \
    & wide "" + grad 1/ (4 uppi) integral.triple_V [divp (va(F)(va(r)')) / (norm(va(r)' - va(r))) - (divp va(F)(va(r)')) / (norm(va(r)' - va(r)))] dif V'. \
  $
  Applying variations of the Divergence Theorem (c.f. @thm:divergence, @cor:divergence-substitutions),
  $
    va(F)(va(r)) & = curl 1 / (4 uppi) [
      integral.triple_V (curlp va(F)(va(r)')) / (norm(va(r)' - va(r))) dif V' - integral.surf_(partial V) dif va(S)' times (va(F)(va(r)')) / (norm(va(r)' - va(r)))
    ] \
    & wide "" - grad 1/ (4 uppi) [integral.triple_V (divp va(F)(va(r)')) / (norm(va(r)' - va(r))) dif V' - integral.surf_(partial V) (va(F)(va(r)')) / (norm(va(r)' - va(r))) dot dif va(S)'].
  $
  If $V = RR^3$, then the surface integrals may be expressed as the limit of concentric spheres of radius $R -> oo$. Then assuming $va(F)(va(r)) = order(1 / r)$,
  $
    integral.surf_(r' = R) (va(F)(va(r)')) / (norm(va(r)' - va(r))) dot dif va(S)' = integral.surf_(r' = R) order(1 / r'^2) dif S' = order(1) -> 0,
  $
  (the result follows similarly for the second surface integral) permitting the ellision of both in this case.

  Now assume $V = RR^3$ and $va(F)(va(r)) = order(1 / r)$; if there exist two decompositions $ va(F) = curl va(A)_1 - grad phi_1 = curl va(A)_2 - grad phi_2 $ such that $va(A)_1, va(A)_2, phi_1, phi_2$ vanish at $oo$, then writing /* $va(W) = curl(va(A)_1 - va(A)_2) = grad(phi_1 - phi_2)$, it must follow that $div va(W) = 0$ and $curl va(W) = 0$. */$W = phi_1 - phi_2$, we obtain that $ laplacian (phi_1 - phi_2) = div [grad(phi_1 - phi_2)] = div [curl(va(A)_1 - va(A)_2)] = 0. $
  /* Applying Green's first identity (see @cor:greens-identities) with $psi = phi = W$, where $W_i = va(W) dot vu(e)_i$ is an arbitrary Cartesian component of $va(W)$, we have
  $
    integral.triple_V [W_i laplacian W_i + (grad W_i)^2] dif V = integral.surf_(partial V) W_i grad W_i dot dif va(S) -> 0
  $
  #todo[Justify vanishes]
  as $V -> RR^3$.  */
  // Let $W_i = va(W) dot vu(e)_i$ be an arbitrary Cartesian component of $va(W)$.

  // Since $curl(curl va(W)) = grad(div va(W)) - laplacian va(W) = 0$, it follows that $laplacian va(W) = 0$, implying $laplacian W_i = 0$. Therefore the harmonicity of $W_i$, implying harmonicity of any of $W_i$'s derivatives, yields the following representation for any $R > 0$ and fixed $j$:
  Then for any $i$, by the Divergence Theorem (@thm:divergence)
  $
    abs(partial_i W(va(r))) &= abs(1 / (4 / 3 uppi R^3) integral.triple_(norm(va(r)' - va(r)) <= R) partial_i W(va(r)') dif V') \
    &=1 / (4 / 3 uppi R^3) abs(integral.triple_(norm(va(r)' - va(r)) <= R) div [W(va(r)') vu(e)_i] dif V') \
    & = 3 / (4 uppi R^3) abs(integral.surf_(norm(va(r)' - va(r)) = R) W(va(r)') vu(e)_i dot dif va(S)') \
    & <= 3 / (4 uppi R^3) sup_(va(r)' in RR^3) abs(W(va(r)')) 4 uppi R^2 = 3 / R sup_(va(r)' in RR^3) abs(W(va(r)')).
  $
  The supremum is finite from the decay condition. Since this holds for arbitrary $R > 0$, letting $R -> oo$ gives $partial_i W = 0$ for all $i$. Therefore $W$ is constant.

  // $
  //   integral.triple_(RR^3) (grad W_i)^2 dif V = 0.
  // $
  // Notice the nonnegativity of the integrand. Since the integral vanishes, we forcibly have $grad W_i = 0,$ or that $W_i$ is constant. Since $va(W) -> 0$, we have $W_i = 0$ everywhere, whence $va(W) = W_i vu(e)_i = 0$ everywhere.
  //
  Hence, the irrotational field $-grad phi_1=-grad phi_2$ of the decomposition is uniquely determined, as is the solenoidal field $curl va(A)_1 = curl va(A)_2$.
]
