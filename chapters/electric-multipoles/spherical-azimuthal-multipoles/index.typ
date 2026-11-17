#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Spherical and Azimuthal Multipoles"),
)
The representation of @eq:inverse-separation-legendre-polynomial, where we denote $va(s) dot va(s)' = cos gamma$, is often inconvenient in considering natural situations involving spherical symmetry, whose natural models rely on the spherical coordinates $va(s) = (s, theta, phi_"az")$ and $va(s)' = (s', theta', phi'_"az")$. To understand this inconvenience,
$
  cos gamma & = (sin theta cos phi_"az" vu(x) + sin theta sin phi_"az" vu(y) + cos theta vu(z)) \
            & quad""dot (sin theta' cos phi'_"az" vu(x) + sin theta' sin phi'_"az" vu(y) + cos theta' vu(z)) \
            & = sin theta sin theta' (cos phi_"az" cos phi'_"az" + sin phi_"az" sin phi'_"az") + cos theta cos theta' \
            & =sin theta sin theta' cos(phi_"az" - phi'_"az") + cos theta cos theta'.
$
Herein do we aim to derive a more practical expression for $P_ell (cos gamma)$.
