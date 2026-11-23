#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Spherical and Azimuthal Multipoles"),
)

We continue directly from our previous endeavor to derive an expression for the inverse distance @eq:inverse-distance-legendre-polynomial by the spherical harmonics addition theorem (@thm:spherical-harmonics-addition-theorem) to obtain
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
  phi(va(r)) &= 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (4 uppi) / (2 ell + 1) integral.triple rho(va(r)') 1 / s_> (s_< / s_>)^ell sum_(m = -ell)^ell Y_ell^m (Omega_>) Y_ell^(m*) (Omega_<) dif^3 r'
$
Throughout the integral, the roles of $s_>$ and $s_<$ switch. More concretely, we have
$
  phi(va(r)) &= 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (4 uppi) / (2 ell + 1) (integral.triple_(s' < s) + integral.triple_(s' > s)) rho(va(r)') 1 / s_> (s_< / s_>)^ell sum_(m = -ell)^ell Y_ell^m (Omega_>) Y_ell^(m*) (Omega_<) dif^3 r' \
  &= 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (4 uppi) / (2 ell + 1) integral.triple_(s' < s) rho(va(r)') 1 / s (s' / s)^ell sum_(m = -ell)^ell Y_ell^m (Omega) Y_ell^(m*) (Omega') dif^3 r' \
  &quad""+ 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo (4 uppi) / (2 ell + 1) integral.triple_(s' > s) rho(va(r)') 1 / s' (s / s')^ell sum_(m = -ell)^ell Y_ell^m (Omega') Y_ell^(m*) (Omega) dif^3 r'.
$ <eq:spherical-multipole-expansion-both-types>
The first term of @eq:spherical-multipole-expansion-both-types is the standard expansion wherewith we have been working. It specifically considers a localized charge distribution within a sphere, and is denoted by the _exterior spherical multipole expansion_.

The second term of @eq:spherical-multipole-expansion-both-types considers in lieu thereof the charge distribution restricted to outside the sphere of radius $s$, known as the _interior spherical multipole expansion_. Such an expansion omits the exterior spherical multipole expansion at some point $va(r)$ if the charge distribution itself contains a spherical charge-free cavity.

Each of these expansions gives rise to coefficients which may be isolated in a manner similar to that which we defined for the Cartesian multipole moments. (The conventions used by authors will differ, up to multiplicative constants. The convention given here follows @zangwill2013modern.) In particular, we define
#definition[Electric Exterior Spherical Multipole Moment][
  For $ell >= 0$, $-ell <= m <= ell$, define the complex-valued _exterior spherical multipole moment of degree $ell$ and order $m$_ by
  $
    A_ell^m = (4 uppi) / (2 ell + 1) integral.triple_(RR^3) rho(va(r)') Y_ell^(m*) (Omega') s'^ell dif^3 r'.
  $
] <def:electric-exterior-spherical-multipole-moment>

#theorem[Electric Exterior Spherical Multipole Expansion][
  If $rho(va(r)')$ is supported in $s' < R$, then for any $s > R$,
  $
    phi(va(r)) = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo sum_(m = -ell)^ell A_ell^m (Y_ell^m (Omega)) / (s^(ell + 1)).
  $
] <thm:electric-exterior-spherical-multipole-expansion>
Furthermore,
#definition[Electric Interior Spherical Multipole Moment][
  For $ell >= 0$, $-ell <= m <= ell$, define the complex-valued _interior spherical multipole moment of degree $ell$ and order $m$_ by
  $
    B_ell^m = (4 uppi) / (2 ell + 1) integral.triple_(RR^3) (rho(va(r)')) / (s'^(ell + 1)) Y_ell^m (Omega') dif^3 r'.
  $
] <def:electric-interior-spherical-multipole-moment>

#theorem[Electric Interior Spherical Multipole Expansion][
  If $rho(va(r)')$ is supported in $s' > R$, then for any $s < R$,
  $
    phi(va(r)) = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo sum_(m = -ell)^ell B_ell^m Y_ell^(m*) (Omega) s^ell.
  $
] <thm:electric-interior-spherical-multipole-expansion>
In the relevant event wherein $rho$ exhibits azimuthal symmetry, i.e. where $rho$ is independent of $phiaz$, the corresponding moments are
$
  A_ell^m & = (4 uppi) / (2 ell + 1) integral.triple_(RR^3) rho(va(r)') Y_ell^(m*) (Omega') s'^ell dif^3 r' \
  & = (4 uppi) / (2 ell + 1) integral_0^R integral_0^uppi rho(va(r)') [integral_0^(2 uppi) Y_ell^(m*) (Omega') dif phiaz'] s'^ell s'^2 sin theta' dif theta' dif s' \
  & = (4 uppi) / (2 ell + 1) integral_0^R integral_0^uppi rho(va(r)') [2 uppi delta_(m 0) sqrt((2 ell + 1) / (4 uppi)) P_ell^0 (cos theta')] s'^ell s'^2 sin theta' dif theta' dif s' \
  &= delta_(m 0) A_ell^0,
$
and similarly,
$
  B_ell^m = delta_(m 0) B_ell^0.
$
Therefore,
$
  phi(va(r)) = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo sqrt((2 ell + 1) / (4 uppi)) A_ell^0 (P_ell (cos theta)) / s^(ell + 1), #tag[(exterior)] \
  phi(va(r)) = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo sqrt((2 ell + 1) / (4 uppi)) B_ell^0 P_ell (cos theta) s^ell. #tag[(interior)]
$
Defining
#definition[Electric Exterior Azimuthal Multipole Moment][
  $
    A_ell = integral.triple rho(va(r)') P_ell (cos theta') s'^ell dif^3 r'
  $
]
and
#definition[Electric Interior Azimuthal Multipole Moment][
  $
    B_ell = integral.triple (rho(va(r)')) / s'^(ell + 1) P_ell (cos theta') dif^3 r',
  $
]
we then have
#theorem[Electric Azimuthal Multipole Expansion][
  1. Where $rho(va(r'))$ is supported in $s' < R$ and azimuthally symmetric about the axis with direction $vu(z)$ passing through $va(r)_0$, then for $s > R$,
  $
    phi(va(r)) = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo A_ell (P_ell (cos theta)) / s^(ell + 1).
  $
  2. Where $rho(va(r'))$ is supported in $s' > R$ and azimuthally symmetric about the axis with direction $vu(z)$ passing through $va(r)_0$, then for $s < R$,
  $
    phi(va(r)) = 1 / (4 uppi epsilon_0) sum_(ell = 0)^oo B_ell P_ell (cos theta) s^ell.
  $
]
