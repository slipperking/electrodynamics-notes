#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Spherical and Azimuthal Multipoles"),
)

We continue directly from our previous endeavor to derive an expression for the inverse distance @eq:inverse-separation-legendre-polynomial by the spherical harmonics addition theorem (@thm:spherical-harmonics-addition-theorem) to obtain
$
  1 / xi = 1 / s sum_(ell = 0)^oo P_ell (cos gamma) (s' / s)^ell = 1 / s sum_(ell = 0)^oo (4 uppi) / (2 ell + 1) sum_(m = -ell)^ell Y_ell^m (Omega)Y_ell^(m*) (Omega') (s' / s)^ell, quad s' < s.
$
The symmetry of $xi = norm(va(s) - va(s)') = norm(va(s)' - va(s))$ allows us to write $s_<$ and $s_>$ to respectively denote the smaller and larger of $s$ and $s'$. Thus
$
  1 / xi = 1 / s_> sum_(ell = 0)^oo (4 uppi) / (2 ell + 1) (s_< / s_>)^ell sum_(m = -ell)^ell Y_ell^m (Omega_>) Y_ell^(m*) (Omega_<).
$ <eq:inverse-distance-spherical-harmonics-expansion>
Therefore, substitution into
$
  phi(va(r)) = 1 / (4 uppi epsilon_0) integral.triple (rho(va(r)')) / xi dif^3 r'
$
yields
$
  phi(va(r)) &= 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (4 uppi) / (2 ell + 1) integral.triple rho(va(r)') 1 / s_> (s_< / s_>)^ell sum_(m = -ell)^ell Y_ell^m (Omega_>) Y_ell^(m*) (Omega_<) dif^3 r' \
  &= 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (4 uppi) / (2 ell + 1) integral.triple rho(va(r)') 1 / s_> (s_< / s_>)^ell sum_(m = -ell)^ell Y_ell^m (Omega_>) Y_ell^(m*) (Omega_<) dif^3 r'.
$
