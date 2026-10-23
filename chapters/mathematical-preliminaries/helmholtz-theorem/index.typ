#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [Helmholtz Decomposition Theorem],
  route: "Helmholtz-theorem",
)
#theorem[Helmholtz Decomposition Theorem][
  For a sufficiently smooth time-static vector field $va(F) : V subset.eq RR^3 -> RR^3$, the Helmholtz Decomposition Theorem guarentees the existence of a decomposition of $va(F)$ by an irrotational field $va(F)_parallel$ with zero curl and a solenoidal field $va(F)_perp$ with zero divergence. Moreover, $exists phi$ such that $-grad phi = va(F)_parallel$, known as the _scalar potential_ of $va(F)_parallel$; and $exists va(psi)$, the _vector potential_ of $va(F)_perp$, such that $va(F)_perp = curl va(psi)$. Then
  $ va(F) = curl va(psi) - grad phi. $
]
A given decomposition may be explicitly given by:
$
  phi(va(r)) = 1 / (4 uppi) [integral.triple_V (divp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V' - integral.surf_(partial V) (va(F)(va(r)')) / norm(va(r)' - va(r)) dot dif va(S)']
$
and
$
  va(psi)(va(r)) = 1 / (4 uppi) [integral.triple_V (curlp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V' + integral.surf_(partial V) (va(F)(va(r)')) / norm(va(r)' - va(r)) times dif va(S)'],
$
where $divp(dot), curlp(dot)$ are the respective divergence and curl with respect to the integration variable $va(r)'$. The fgiven representations are valid only if the integrals converge.

If $V = RR^3$, then the surface terms may be elided:
$
  phi(va(r)) = 1 / (4 uppi) integral.triple_(RR^3) (divp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V', wide va(psi)(va(r)) = 1 / (4 uppi) integral.triple_(RR^3) (curlp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V'.
$
Moreover, the representation above is unique for all decompositions with potentials $phi$ and $va(psi)$ that vanish at $oo$.
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
  If $V = RR^3$, then the surface integrals vanish. This proves the existence.

  Now assume $V = RR^3$, then if there exists two decompositions $va(F) = curl va(psi)_1 - grad phi_1 = curl va(psi)_2 - grad phi_2$, then writing $va(W) = curl(va(psi)_1 - va(psi)_2) = grad(phi_1 - phi_2)$, it must follow that $div va(W) = 0$ and $curl va(W) = 0$.

  Applying Green's first identity with $psi = phi = W$, where $W_i = va(W) dot vu(e)_i$ is an arbitrary Cartesian component of $va(W)$, we have
  $
    integral.triple_V [W_i laplacian W_i + (grad W_i)^2] dif V = integral.surf_(partial V) W_i grad W_i dot dif va(S) -> 0
  $
  as $V -> RR^3$. Since $curl(curl va(W)) = grad(div va(W)) - laplacian va(W) = 0$, it follows that $laplacian va(W) = 0$, implying $laplacian W_i = 0$, giving that
  $
    integral.triple_(RR^3) (grad W_i)^2 dif V = 0.
  $
  Notice the nonnegativity of the integrand. Since the integral vanishes, we forcibly have $grad W_i = 0,$ or that $W_i$ is constant. Since $va(W) -> 0$, we have $W_i = 0$ everywhere, whence $va(W) = W_i vu(e)_i = 0$ everywhere. Therefore, the irrotational field $-grad phi_1=-grad phi_2$ of the decomposition is uniquely determined, as is the solenoidal field $curl va(psi)_1 = curl va(psi)_2$.
  #todo[Justify vanishes]
]
