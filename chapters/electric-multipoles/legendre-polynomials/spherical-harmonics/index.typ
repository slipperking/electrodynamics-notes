#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Spherical Harmonics"),
)

The representation of @eq:inverse-separation-legendre-polynomial, wherein have we denoted $vu(s) dot vu(s)' = cos gamma$, is often inconvenient in considering natural situations involving spherical symmetry, whose natural models rely on the spherical coordinates $va(s) = (s, theta, phi_"az")$ and $va(s)' = (s', theta', phi'_"az")$. To understand this inconvenience,
$
  cos gamma & = (sin theta cos phi_"az" vu(x) + sin theta sin phi_"az" vu(y) + cos theta vu(z)) \
            & quad""dot (sin theta' cos phi'_"az" vu(x) + sin theta' sin phi'_"az" vu(y) + cos theta' vu(z)) \
            & = sin theta sin theta' (cos phi_"az" cos phi'_"az" + sin phi_"az" sin phi'_"az") + cos theta cos theta' \
            & =sin theta sin theta' cos(phi_"az" - phi'_"az") + cos theta cos theta'.
$
It is our present intention to derive a more practical expression for $P_ell (cos gamma)$. It is precisely for this that we shall introduce the _spherical harmonics_.

Consider as in @eq:laplacian-spherical-coordinates, with $(s, theta, phiaz)$
$
  laplacian_(S^2) = 1 / (sin theta) pdv(, theta)(sin theta pdv(, theta)) + 1 / (sin^2 theta) pdv(, phiaz, 2),\
  laplacian = 1 / s^2 pdv(, s) (s^2 pdv(, s)) + 1 / s^2 laplacian_(S^2).
$
Where $Omega = (theta, phiaz)$, if a complex-harmonic function $Phi$ can be separated by $Phi(s, Omega) = R(s) Y(Omega)$, then
$
  0 = pdv(, s) (s^2 pdv(Phi, s)) + laplacian_(S^2) Phi \
  ==> lambda = -1 / Y laplacian_(S^2) Y = 1 / R pdv(, s) (s^2 pdv(R, s)).
$
If $Omega$ is held fixed whilst $s$ varies, then by the separation previously obtained, because the left-hand side involving $Y$ is invariant to such a variation, the right-hand side expression involving $s$ must be constant. Holding $s$ to be fixed whilst varying $Omega$ similarly validates the constancy of $lambda$ in the entirety of $(s, Omega)$. Therefore,
$
  laplacian_(S^2) Y = - lambda Y, wide (pdv(, s) (s^2 pdv(R, s)) = R lambda)
$
whereby $-lambda$ is an eigenvalue to the angular Laplacian corresponding to the eigenfunction $Y$. Moreover, where $Y^*$ is its complex conjugate,
$
  lambda Y Y^* = -Y^* laplacian_(S^2) Y
$
$
  lambda integral.surf_(S^2) abs(Y)^2 dif Omega &= -integral_0^(2 uppi) integral_0^uppi Y^* laplacian_(S^2) Y sin theta dif theta dif phiaz \
  &= -integral_0^(2 uppi) integral_0^uppi Y^* [pdv(, theta)(sin theta pdv(Y, theta)) + 1 / (sin theta) pdv(Y, phiaz, 2)] dif theta dif phiaz \
  &= -integral_0^(2uppi) [evaluated(Y^* sin theta pdv(Y, theta))_0^uppi - integral_0^uppi sin theta pdv(Y, theta)pdv(Y^*, theta) dif theta] dif phiaz \
  &quad""- integral_0^uppi [evaluated((Y^* partial_phiaz Y) / (sin theta))_0^(2 uppi) - integral_0^(2 uppi) (partial_phiaz Y^* partial_phiaz Y) / (sin theta)] dtheta \
  &= integral.surf_(S^2) (abs(partial_theta Y)^2 + abs(partial_phiaz Y)^2/ (sin^2 theta)) dif Omega
$ <eq:spherical-harmonics-negative-eigenvalue>
wherefor the elision of both integration by parts boundary terms is substantiated by $sin uppi = sin (0) = 0$ and the $2 uppi$-periodicity of $Y$ in $phiaz$ respectively. @eq:spherical-harmonics-negative-eigenvalue verifies $lambda >= 0$.

Again restrict further our consideration to whensoever $Y$ can be separated into $Y(Omega) = T(theta) F(phiaz)$, whence
$
  laplacian_(S^2) Y = -lambda Y &==> F / (sin theta) pdv(, theta)(sin theta pdv(T, theta)) + T / (sin^2 theta) F'' = -lambda T F \
  & ==> (sin theta) / T pdv(, theta)(sin theta pdv(T, theta)) + lambda sin^2 theta = -(F'' (phiaz)) / F(phiaz).
$ <eq:spherical-harmonics-second-separation>
A variation in $phiaz$ leaves the left-hand side unchanged, and vice versa, whereby once more---as with before---give rise to a separation constant $mu$. In particular,
$
  mu F = -F'' ==> mu integral_0^(2 uppi) abs(F)^2 dif phiaz & = -integral_0^(2 uppi) F'' F^* dif phiaz = -[F' F^*]_0^(2uppi) + integral_0^(2 uppi) abs(F')^2 dif phiaz >= 0
$
once more by periodicity and observation that $F^*' = F'^*$. Hence we have $mu >= 0$, whence the general solution
$
  F'' + mu F = 0 ==> F(phiaz) = cases(A ee^(ii sqrt(mu) phiaz) + B ee^(-ii sqrt(mu) phiaz)& quad "if" mu != 0\,, A + B phiaz &quad "otherwise")
$
must be $2 uppi$-periodic, forcing $exp[2 uppi ii sqrt(mu)] = 1$ (i.e. $sqrt(mu)$ is an integer). By the symmetric nature of the given solution, we may assign any integer $m$ in lieu of $sqrt(mu)$, giving
$
  F'' + m^2 F = 0 ==> F(phiaz) = cases(A ee^(ii m phiaz) + B ee^(-ii m phiaz)& quad "if" m != 0\,, A "(constant)" &quad "otherwise").
$
From this restriction upon $mu$, the differential equation for $T$ in @eq:spherical-harmonics-second-separation gives
$
  1 / (sin theta) pdv(, theta)(sin theta pdv(T, theta)) + T(lambda - m^2 / (sin^2 theta)) = 0,
$
to be the general form of any such separable solution for $m in ZZ$. Letting $x = cos theta$,
$
  dv(, theta) = dv(x, theta) dv(, x) = -sin theta dv(, x),\
  1 / (sin theta) pdv(, theta)(sin theta pdv(T, theta)) = -1 / (sin theta) pdv(, theta)(sin^2 theta pdv(T, x)) = pdv(, x) ((1- x^2) pdv(T, x)),\
  pdv(, x) ((1- x^2) pdv(T, x)) + T (lambda - m^2 / (1 - x^2)) = 0.
$
Considering $va(s)' = vu(s)'$ of unit magnitude along the polar axis,
$
  1 / xi = sum_(ell = 0)^oo s'^ell / s^(ell + 1) P_ell (cos theta),
$
implying
$
  laplacian 1 / xi = 0 &= sum_(ell = 0) [1 / s^2 pdv(, s) (s^2 pdv(, s)) + 1 / s^2 laplacian_(S^2)](1 / s^(ell + 1) P_ell (cos theta)) \
  &= sum_(ell = 0)^oo (P_ell (cos theta)) / s^2 pdv(, s)(s^2 pdv(, s) s^(-(ell + 1))) + 1 / s^(ell + 3) laplacian_(S^2) P_ell (cos theta) \
  &= sum_(ell = 0)^oo ell(ell + 1) (P_ell (cos theta)) / s^(ell + 3) + 1 / s^(ell + 3) laplacian_(S^2) P_ell (cos theta),\
  sum_(ell = 0)^oo 0 s^(-ell) = 0 & = sum_(ell = 0)^oo s^(-ell) [ell(ell + 1) P_ell (cos theta) + laplacian_(S^2) P_ell (cos theta)].
$
The uniqueness of Taylor expansions gives
$
  ell(ell + 1) P_ell (cos theta) + laplacian_(S^2) P_ell (cos theta) = 0,
$
whence it is clear that with $lambda = ell(ell + 1)$ and $Y(Omega) = P_ell (cos theta)$ gives a class of solutions with $m = 0$. Expanding,
$
  0 & = ell(ell + 1) P_ell (x) + pdv(, x)((1-x^2) pdv(P_ell, x)) \
    & = ell(ell + 1) P_ell - 2x P'_ell + (1-x^2) P''_ell
$
for each $ell$; thus from $k$ differentiations,
$
  0 & = ell(ell + 1) P_ell^((k)) - dv(, x, k) (2x P'_ell) + dv(, x, k) [(1 - x^2) P''_ell] \
  & = ell(ell + 1) P_ell^((k)) - dv(, x, k - 1) [2 P'_ell + 2x P^((2))_ell] + dv(, x, k - 1) [(1 - x^2) P^((3))_ell - 2 x P^((2))_ell] \
  & = ell(ell + 1) P_ell^((k)) - dv(, x, k - 2) [4 P^((2))_ell + 2x P^((3))_ell] \
  &quad""+ dv(, x, k - 2) [(1 - x^2) P^((4))_ell -4 x P^((3))_ell - 2 P^((2))_ell] \
  &= ell(ell + 1) P_ell^((k)) - [2 k P^((k))_ell + 2x P^((k + 1))_ell] \
  &quad""+ [(1 - x^2) P_ell^((k+2)) - 2 k x P_ell^((k+1)) - k(k-1) P_ell^((k))] \
  &= (1 - x^2) P_ell^((k+2)) - 2x(k + 1) P_ell^((k + 1)) + [ell(ell + 1) - k(k + 1)] P_ell^((k)).
$
