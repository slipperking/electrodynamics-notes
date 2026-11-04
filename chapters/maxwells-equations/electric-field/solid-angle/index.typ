#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Solid Angle"),
)
Suppose $S$ is a surface in $RR^3$ and $va(r)_0$ is a point in $RR^3 without S$. At present we aim to introduce the _solid angle_ $Omega_S$ subtended by $S$ at $va(r)_0$, which is defined to be the area, counting potential overlaps, of the projection of $S$ onto a unit sphere $va(P)(S)$ centered at $va(r)_0$, where
$
  va(P)(va(r)) = va(r)_0 + (va(r) - va(r)_0) / norm(va(r) - va(r)_0).
$
At a fixated $va(P)(va(r))$, the normal vector with respect to the surface may assume the form of
$
  vu(n)_(va(P)(va(r))) = (va(r) - va(r)_0) / norm(va(r) - va(r)_0).
$
Consider a single differential surface element $dif S$ oriented with the normal vector $vu(n)_S$ at some $va(r)_S in S$. Its projection $dif Omega_S$ onto $va(P)(S)$ centered at $va(r)_0$ is determinable by
$
  dif Omega_S = (dif S_perp) / norm(va(r)_S - va(r)_0)^2 = (dif S vu(n)_S dot vu(n)_va(P) (S)) / norm(va(r)_S - va(r)_0)^2 = (va(r)_S - va(r)_0) / norm(va(r)_S - va(r)_0)^3 dot dif va(S),
$
whence
$
  Omega_S = integral.double_S (va(r)_S - va(r)_0) / norm(va(r)_S - va(r)_0)^3 dot dif va(S).
$
If $S$ is a subset of a spherical surface centered at $va(r)_0$, then
$
  dif Omega_S = (dif S) / norm(va(r)_S - va(r)_0)^2 = sin theta dif theta dif phi.alt,
$
wherein $theta$ and $phi.alt$ are the polar and azimuthal angles, respectively, for a spherical coordinate system centered at $va(r)_0$. Further, whensoever $S$ is a closed surface,
$
  Omega_S (va(r)_0) &= integral.triple div (va(r)_S - va(r)_0) / norm(va(r)_S - va(r)_0)^3 dif^3 r = -integral.triple laplacian 1 / norm(va(r)_S - va(r)_0) dif^3 r \
  &= 4 uppi integral.triple delta(norm(va(r)_S - va(r)_0)) dif^3 r = cases(4 uppi & quad "if" va(r)_0 in jinterior S\,, 0 &quad "if" va(r)_0 in jexterior S,)
$
whence
$
  Phi_E (S) = integral.surf_S va(E) dot dif va(S) = q / (4 uppi epsilon_0) Omega_S (va(r)_0)
$
wherein Gauss' Law finds its exact expression for a single point charge $q$ at $va(r)_0$.
