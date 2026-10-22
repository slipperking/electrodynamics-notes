#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [Helmholtz Decomposition Theorem],
  route: "Helmholtz-theorem",
)
#theorem[Helmholtz Decomposition Theorem][
  For a sufficiently smooth time-static vector field $va(F) : V subset.eq RR^3 -> RR^3$, the Helmholtz Decomposition Theorem guarentees the existence of a decomposition of $va(F)$ by an irrotational field $va(F)_parallel$ with zero curl and a solenoidal field $va(F)_perp$ with zero divergence. Moreover, $exists Phi$ such that $-grad Phi = va(F)_parallel$, known as the _scalar potential_ of $va(F)_parallel$; and $exists va(Psi)$, the _vector potential_ of $va(F)_perp$, such that $va(F)_perp = curl va(Psi)$. Then
  $ va(F) = curl va(Psi) - grad Phi. $
]
A given decomposition may be explicitly given by:
$
  Phi(va(r)) = 1 / (4 uppi) [integral.triple_V (divp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V' - integral.surf_(partial V) (va(F)(va(r)')) / norm(va(r)' - va(r)) dot dif va(S)']
$
and
$
  Psi(va(r)) = 1 / (4 uppi) [integral.triple_V (curlp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V' + integral.surf_(partial V) (va(F)(va(r)')) / norm(va(r)' - va(r)) times dif va(S)'],
$
where $divp(dot), curlp(dot)$ are the respective divergence and curl with respect to the integration variable $va(r)'$. The fgiven representations are valid only if the integrals converge.

If $V = RR^3$, then the surface terms may be elided:
$
  Phi(va(r)) = 1 / (4 uppi) integral.triple_(RR^3) (divp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V', wide Psi(va(r)) = 1 / (4 uppi) integral.triple_(RR^3) (curlp va(F)(va(r)')) / norm(va(r)' - va(r)) dif V'.
$
Moreover, the representation above is unique for all decompositions with potentials $Phi$ and $va(Psi)$ that vanish at $oo$.
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
  Applying variations of the Divergence Theorem (c.f. @thm:divergence),
  $
    va(F)(va(r)) & = curl 1 / (4 uppi) [
      integral.triple_V (curlp va(F)(va(r)')) / (norm(va(r)' - va(r))) dif V' - integral.surf_(partial V) dif va(S) times (va(F)(va(r)')) / (norm(va(r)' - va(r)))
    ] \
    & wide "" - grad 1/ (4 uppi) [integral.triple_V (divp va(F)(va(r)')) / (norm(va(r)' - va(r))) dif V' - integral.surf_(partial V) (va(F)(va(r)')) / (norm(va(r)' - va(r))) dot dif va(S)'].
  $
]
