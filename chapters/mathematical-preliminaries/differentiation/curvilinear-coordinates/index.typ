#import "/lib.typ": *
#import "graphics.typ": spherical-element
#show: docs-subsubchapter.with(
  ..dargs("Curvilinear Coordinates"),
)
The Cartesian coordinate system is not well-suited in evaluating cases involving spherical and azimuthal symmetries. The former is resolved by use of spherical coordinates $(r, theta, phi_"az")$.

We define an orthonormal basis $vu(r), vu(theta), vu(phi)_"az"$, dependent on a point $va(r) = (r, theta, phi_"az")$ pointing in the direction of respective increase.

#figure-wrapper[
  #figure(
    spherical-element,
    caption: [The spherical coordinate system and the volume element.],
  ) <fig:spherical-coordinates>
]

From @fig:spherical-coordinates, we have geometrically that
$
  dif va(r) = dif r vu(r) + r dif theta vu(theta) + r sin theta dif phi_"az" vu(phi)_"az",
$
whence
$
  dif^3 r = r^2 sin theta dif r dif theta dif phi_"az".
$
Then
$
  dif f & = pdv(f, r) dif r + pdv(f, theta) dif theta + pdv(f, phi_"az") dif phi_"az" \
  & = grad f dot dif va(r) = grad f dot [dif r vu(r) + r dif theta vu(theta) + r sin theta dif phi_"az" vu(phi)_"az"].
$
Matching $grad f$ with the chain rule expansion, we hence obtain
$
  grad f = pdv(f, r) vu(r) + 1 / r pdv(f, theta) vu(theta) + 1 / (r sin theta) pdv(f, phi_"az") vu(phi)_"az", \
  grad = vu(r) pdv(, r) + vu(theta) / r pdv(, theta) + (vu(phi)_"az") / (r sin theta) pdv(, phi_"az").
$ <eq:gradient-spherical-coordinates>
The derivation of the spherical Laplacian must be treated with caution if applying @eq:gradient-spherical-coordinates: the unit vectors $vu(r), vu(theta), vu(phi)_"az"$ are all dependent on $theta$ and $phi$. It is generally better to rely on geometric approaches as such to avoid a laborious computation. For this we recall the integral form of divergence:
$
  div va(F)(va(r)) = 1 / (op("vol")(jinterior S)) lim_(S -> {va(r)}) integral.surf_S va(F) dot dif va(S),
$
whereof the volume in consideration we restrict to the box as in @fig:spherical-coordinates, whose side lengths are $delta r$, $r delta theta$, and $r sin theta delta phi_"az"$. If
$
  va(F) = F_r vu(r) + F_theta vu(theta) + F_phi_"az" vu(phi)_"az",
$
then evaluating the flux contributions of each of the six faces, when these lengths are sufficiently small,
$
  delt(r, [3]) div va(F)(va(r)) &= (r + deltar)^2 deltatheta sin theta deltaphi evaluated(F_r)_(r + delta r) - r^2 deltatheta sin theta deltaphi evaluated(F_r)_r \
  &quad""+ deltar r sin (theta + deltatheta) deltaphi evaluated(F_theta)_(theta + deltatheta) - deltar r sin theta deltaphi evaluated(F_theta)_(theta) \
  &quad""+ deltar r deltatheta evaluated(F_phiaz)_(phiaz + deltaphi) - deltar r deltatheta evaluated(F_phiaz)_(phiaz), \
  div va(F)(va(r)) &= 1 / r^2 pdv(, r)(r^2 F_r) + 1 / (r sin theta) pdv(, theta) (sin theta F_theta) + 1 / (r sin theta) pdv(F_phiaz, phiaz),
$ <eq:divergence-spherical-coordinates>
whereby the Laplacian may be found to be:
$
  laplacian &= 1 / r^2 pdv(, r)(r^2 pdv(, r)) + 1 / (r sin theta) pdv(, theta) ((sin theta) / r pdv(, theta)) + 1 / (r sin theta) pdv(, phiaz) (1 / (r sin theta) pdv(, phi_"az")) \
  &=1 / r^2 pdv(, r)(r^2 pdv(, r)) + 1 / (r^2 sin theta) pdv(, theta) (sin theta pdv(, theta)) + 1 / (r^2 sin^2 theta) pdv(, phiaz, 2).
$ <eq:laplacian-spherical-coordinates>
