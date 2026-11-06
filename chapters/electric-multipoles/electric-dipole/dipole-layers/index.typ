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
  phi(va(r)) = -1 / (4 uppi epsilon_0) integral dif va(p)' dot grad 1 / (-xi) = -1 / (4 uppi epsilon_0) integral.double_S va(tau)(va(r)') dot grad' 1 / xi dif S'
$
We wish to rewrite the potential as a volume integral. Similar to the way in which @sec:electric-charges expresses a surface distribution $sigma$ and a linear distribution $lambda$ as a volume density distribution, there exists a suitable generalization
$
  delta_S (va(r)) = integral.double_S delta^3 (va(r) - va(r)') dif S'
$
whence the previous relation is simply
$
  phi(va(r)) = -1 / (4 uppi epsilon_0) integral.triple delta_S (va(r)') va(tau)(argmin_(va(r)_S in S) norm(va(r)_S - va(r)')) dot grad' 1 / xi dif^3 r'.
$
(The choice of $argmin$ is not of great importance; our goal is to extend $va(tau)$ to be defined outside the surface, although $delta_S$ picks only points in $S$.)
