#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Dipole Layers"),
)
We shall now consider the case pertaining to particles trapped in the surface boundary between water and air mediums. Consider a situation in which the surface of a dish of water meets the air in a flat plane, whereupon neutrally charged phospholipid molecules are introduced, the properties whereof comprise notably the neutrality of charge and an uneven charge distribution. The molecules orient themselves in a way such that the polar heads anchor themselves into the water with hydrophobic tails oriented vertically upward.

Microscopically, each of these suspended molecules occupying a surface area of $S$ can be characterized with a dipole moment $va(p)$, whence a crude representation of the molecule can be given by a dipole of two charges $+q, -q$ separated by a displacement $va(b)$ reproducing the same moment $va(p) = q va(b)$. Therefore, over a surface of such contiguously arranged molecules, we introduce the description of a _electric dipole moment per unit area_
$
  va(tau) = va(p) / S = sigma va(b).
$
Our representation makes no attempt to individually model the charge or density of these molecules. Rather, in macroscopic consideration, letting $b -> 0$ fixing $va(p)$ (and consequently $sigma -> oo$) gives the construction of an _electric dipole layer_. Its approximation will prove to be of utility in many physical scenarios wherein charges exist near boundary surfaces.

The most general case of an electric dipole layer will consider an arbitrary surface $S$ and a surface dipole density $va(tau)(va(r)) = dv(va(p), S)$ which is not necessarily uniform in strength nor perpendicular to the surface in its directionality. @eq:electric-point-dipole-potential gives the electric potential to be
$
  phi(va(r)) = -1 / (4 uppi epsilon_0) integral dif va(p)' dot grad 1 / xi = 1 / (4 uppi epsilon_0) integral.double_S va(tau)(va(r)') dot grad' 1 / xi dif S'
$
We wish to rewrite the potential as a volume integral. Similar to the way in which @sec:electric-charges expresses a surface distribution $sigma$ and a line distribution $lambda$ as a volume density distribution, there exists a suitable generalization
$
  delta_S (va(r)) = integral.double_S delta^3 (va(r) - va(r)') dif S'
$
Defining
$
  va(r)'_S = argmin_(va(r)'' in S) norm(va(r)' - va(r)''), wide (va(r)_S = argmin_(va(r)'' in S) norm(va(r) - va(r)''))
$
the previous relation is simply
$
  phi(va(r)) = 1 / (4 uppi epsilon_0) integral.triple delta_S (va(r)') va(tau) (va(r)'_S) dot gradp 1 / xi dif^3 r'.
$
The choice of $argmin$ is not of great importance; our goal is to extend $va(tau)$ to be defined outside the surface, although $delta_S$ picks only points in $S$. For simplicity we shall simply write $va(r)_S$ to imply the given meaning.

We then have
$
  phi(va(r)) &= 1 / (4 uppi epsilon_0) integral.triple [divp [1 / xi delta_S (va(r)') va(tau) (va(r)'_S)] - (divp [delta_S (va(r)') va(tau) (va(r)'_S)]) / xi] dif^3 r' \
  &= 1 / (4 uppi epsilon_0) integral.triple (-divp [delta_S (va(r)') va(tau) (va(r)'_S)]) / xi dif^3 r',
$
which is the precise result we would have obtained by setting
#theorem[Volume Charge Distribution of an Electric Dipole Layer][
  $
    rho(va(r)) = -div [delta_S (va(r)) va(tau) (va(r)_S)].
  $
]
Observe that
$
  delta_S (va(r)) va(tau) (va(r)_S) = integral.double_S delta^3 (va(r) - va(r)') va(tau) (va(r)_S) dif S' = integral.double_S va(tau) (va(r)') delta^3(va(r) - va(r)') dif S',
$
giving
$
  rho(va(r)) = -integral.double_S va(tau) (va(r)') dot grad delta^3 (va(r) - va(r)') dif S'.
$
Denote by $vu(n) = vu(n)_(va(r)')$ the unit surface normal and decompose
$
  va(tau) &= va(tau)_parallel + va(tau)_perp, wide "where" quad va(tau)_perp = vu(n) (vu(n) dot va(tau)) = vu(n) tau_perp, quad va(tau)_parallel = va(tau) - va(tau)_perp = (vaa(I) - vu(n)^(times.o 2)) dot va(tau), \
  grad &= grad_parallel + grad_perp, wide "where" quad grad_perp = vu(n)(vu(n) dot grad), quad grad_parallel = (vaa(I) - vu(n)^(times.o 2)) dot grad,
$
(here we define $tau_perp$ to be signed to be dependent on the direction of $vu(n)$) whence
$
  rho(va(r)) = -integral.double_S va(tau)_parallel (va(r)') dot grad delta^3 (va(r) - va(r)') dif S' - integral.double_S va(tau)_perp (va(r)') dot grad delta^3 (va(r) - va(r)') dif S'.
$ <eq:electric-dipole-layer-auxiliary-1>
As generalized functions of $xi$, $grad = -gradp$ entails that
$
  -integral.double_S &va(tau)_parallel (va(r)') dot grad delta^3(va(r) - va(r)') dif S' = integral.double_S va(tau)_parallel (va(r)') dot gradp_parallel delta^3(va(r) - va(r)') dif S' \
  &= integral.double_S [divpsu(parallel) [va(tau)_parallel (va(r)') delta^3(va(r) - va(r)')] - [divpsu(parallel) va(tau)_parallel (va(r)')] delta^3(va(r) - va(r)')] dif S'
$ <eq:electric-dipole-layer-auxiliary-2>
//
Denote by $vu(m) = vu(m)_(va(r)')$ at $va(r)' in partial S$ the outward unit conormal tangent to $S$ and normal to $partial S$. Then
$
  integral.double_S divpsu(parallel) [va(tau)_parallel (va(r)') delta^3(va(r) - va(r)')] dif S' = integral.cont_(partial S) delta^3 (va(r) - va(r)') va(tau)_parallel (va(r)') dot vu(m)_(va(r)') dif ell'
$
Where
$
  delta_(partial S)(va(r)) = integral.cont_(partial S) delta^3(va(r) - va(r)') dif ell', wide va(r)_(partial S) = argmin_(va(r)'' in partial S) norm(va(r) - va(r)''), \
  lambda(va(r)_(partial S)) = va(tau)_parallel (va(r)_(partial S)) dot vu(m)_(va(r)_(partial S)),
$ <eq:electric-dipole-layer-effective-line-charge-density>
the first term of @eq:electric-dipole-layer-auxiliary-1 assumes the form (distributionally)
$
  integral.double_S divpsu(parallel) [va(tau)_parallel (va(r)') delta^3 (va(r) - va(r)')] dif S' = lambda(va(r)_(partial S)) delta_(partial S)(va(r)). /* #tag[(distributionally)] */
$
The second term of @eq:electric-dipole-layer-auxiliary-2 is similarly
$
  integral.double_S [divpsu(parallel) va(tau)_parallel (va(r)')] delta^3(va(r) - va(r)') dif S' = [divsu(parallel) va(tau)_parallel (va(r)_S)] delta_S (va(r)).
$
In consideration of @eq:electric-dipole-layer-auxiliary-1, observe that
$
  delta_S (va(r)) va(tau)_perp (va(r)_S) = integral.double_S va(tau)_perp (va(r)') delta^3 (va(r) - va(r)') dif S',
$
$
  div[delta_S (va(r)) va(tau)_perp (va(r)_S)] &= va(tau)_perp (va(r)_S) dot grad delta_S (va(r)) + [div va(tau)_perp (va(r)_S)] delta_S (va(r)) \
  &= div integral.double_S va(tau)_perp (va(r)') delta^3 (va(r) - va(r)') dif S' = integral.double_S va(tau)_perp (va(r)') dot grad delta^3 (va(r) - va(r)') dif S'.
$
As $va(r)_S$ remains invariant under sufficiently small displacements along $vu(n)_va(r)$, we aver that $divsu(perp) va(tau)_perp = 0$, whence it follows that $div va(tau)_perp = divsu(parallel) va(tau)_perp$. Hence
$
  va(tau)_perp (va(r)_S) dot grad delta_S (va(r)) + [div va(tau)_perp (va(r)_S)] delta_S (va(r)) &= tau_perp (va(r)_S) vu(n)_va(r)_S dot grad delta_S (va(r)) + [divsu(parallel) va(tau)_perp (va(r)_S)] delta_S (va(r)) \
  &=integral.double_S va(tau)_perp (va(r)') dot grad delta^3 (va(r) - va(r)') dif S',
$
which is the second term of @eq:electric-dipole-layer-auxiliary-1. Combining @eq:electric-dipole-layer-auxiliary-1, @eq:electric-dipole-layer-auxiliary-2, and @eq:electric-dipole-layer-effective-line-charge-density,
$
  rho(va(r)) &= lambda(va(r)_(partial S)) delta_(partial S) (va(r)) - [divsu(parallel) va(tau)_parallel (va(r)_S)] delta_S (va(r)) - [tau_perp (va(r)_S) vu(n)_va(r)_S dot grad delta_S (va(r)) + [divsu(parallel) va(tau)_perp (va(r)_S)] delta_S (va(r))] \
  &= lambda(va(r)_(partial S)) delta_(partial S) (va(r)) - divsu(parallel) va(tau) (va(r)_S) delta_S (va(r)) - tau_perp (va(r)_S) vu(n)_va(r)_S dot grad delta_S (va(r)) \
$
#theorem[
  The volume distribution of an electric dipole layer is
  $
    rho(va(r)) = -tau_perp (va(r)_S) [pdv(, n_va(r)_S) delta_S (va(r))] + sigma(va(r)_S) delta_S (va(r)) + lambda(va(r)_(partial S)) delta_(partial S) (va(r)),
  $
  wherein
  $
    sigma = -divsu(parallel) va(tau), wide lambda = va(tau)_parallel dot vu(m)
  $
  are the _effective surface and line charge densities_.
]
