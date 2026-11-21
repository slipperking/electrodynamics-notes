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
  F'' + mu F = 0 ==> F(phiaz) = cases(A ee^(ii sqrt(mu) phiaz) + B ee^(-ii sqrt(mu) phiaz)& quad "if" mu != 0\,, A + B phiaz &quad "if" m = 0)
$
must be $2 uppi$-periodic, forcing $exp[2 uppi ii sqrt(mu)] = 1$ (i.e. $sqrt(mu)$ is an integer). By the symmetric nature of the given solution, we may assign any integer $m$ in lieu of $sqrt(mu)$, giving
$
  F'' + m^2 F = 0 ==> F(phiaz) &= cases(A ee^(ii m phiaz) + B ee^(-ii m phiaz)& quad "if" m != 0\,, A "(constant)" &quad "if" m = 0) \ &= A ee^(ii m phiaz) + B ee^(-ii m phiaz)
$ <eq:spherical-harmonics-azimuthal-solution>
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
$ <eq:spherical-harmonics-legendre-polynomials-differential-equation>
The functions (albeit poorly named, as they are not necessarily polynomials)
#definition[Associated Legendre Polynomials][
  $
    P_ell^k (x) = (-1)^k (1-x^2)^(k / 2) P_ell^((k)) (x)
  $
]
are our candidate solutions that we shall now test. Observe that
$
  dv(P_ell^k, x) & = (-1)^(k + 1) k x (1 - x^2)^(k/2 - 1) P_ell^((k)) (x) + (-1)^k (1 - x^2)^(k/2) P_ell^((k + 1)) (x) \
                 & =(-1)^k (1 - x^2)^(k/2) [-(k x) / (1 - x^2) P_ell^((k)) + P_ell^((k+1)) ],
$
$
  dv(P_ell^k, x, 2) & =(-1)^k x(2 - k)(1 - x^2)^(k/2 - 2) [-k x P_ell^((k)) + P_ell^((k+1)) (1 - x^2)] \
  &quad""+ (-1)^k (1 - x^2)^(k/2 - 1) [-k P_ell^((k)) - x (k + 2) P_ell^((k + 1)) + P_ell^((k+2)) (1 - x^2)], \
  & = (-1)^k (1 - x^2)^(k/2 - 2) [(1 - x^2)^2 P_ell^((k + 2)) - 2 k x (1 - x^2) P_ell^((k + 1)) + k ((k - 1) x^2 - 1) P_ell^((k))];
$
thus with $k = abs(m)$,
$
  pdv(, x) ((1- x^2) dv(P_ell^k, x)) + &P_ell^k (lambda - m^2 / (1 - x^2)) = -2 x dv(P_ell^k, x) + (1 - x^2) dv(P_ell^k, x, 2) + P_ell^k (lambda - k^2 / (1 - x^2)) \
  &= (-1)^k (1 - x^2)^(k / 2) [(2 x^2 k) / (1 - x^2) P_ell^((k)) - 2 x P_ell^((k + 1))] \
  & quad ""+(-1)^k (1 - x^2)^(k / 2) [(1 - x^2)P_ell^((k + 2)) - 2 k x P_ell^((k + 1)) + k ((k-1)x^2 -1) / (1 - x^2) P_ell^((k))] \
  & wide"" + (-1)^k (1-x^2)^(k / 2) P_ell^((k))(lambda - k^2 / (1 - x^2)) \
  &=(-1)^k (1 - x^2)^(k / 2) [(lambda -k (k+1)) P_ell^((k)) - 2x(k+1) P_ell^((k+1)) + (1 - x^2) P_ell^((k + 2))],
$
the bracketed term whereof we observe to be the precise form in @eq:spherical-harmonics-legendre-polynomials-differential-equation with $lambda = ell(ell + 1)$. Thus, this realization gives rise to the class of solutions
$
  T(theta) = P_ell^abs(m) (cos theta), quad lambda = ell(ell + 1), quad (k <= ell "so" P_ell^k equiv.not 0)
$
each corresponding to the matching solutions for $F$ given in @eq:spherical-harmonics-azimuthal-solution.

Thus we define
$
  tilde(Y)_ell^m (Omega) = P_ell^abs(m) (cos theta) ee^(ii m phiaz),
$
which we have thus shown to satisfy the given condition on $laplacian_(S^2)$. It will transpire, that among many properties, $tilde(Y)_dot^dot$ satisfies an orthogonality relation permitting the definition of an orthonormal system. In verification hereof, we compute
$
  chev(tilde(Y)_ell^m, tilde(Y)_ell'^m') &= integral.surf tilde(Y)_ell^m (Omega) tilde(Y)_ell'^(m'*) (Omega) dif Omega \
  &= integral_0^(2 uppi) integral_0^uppi P_ell^abs(m) (cos theta) P_ell'^abs(m') (cos theta) ee^(ii (m - m') phiaz) sin theta dtheta dif phiaz \
  &= integral_0^(2 uppi) ee^(ii (m - m') phiaz) dif phiaz integral_0^uppi P_ell^abs(m) (cos theta) P_ell'^abs(m') (cos theta) sin theta dtheta \
  &= 2 uppi delta_(m m') integral_0^uppi P_ell^abs(m) (cos theta) P_ell'^abs(m') (cos theta) sin theta dtheta,
$
wherein $z^* = overline(z)$ denotes the complex conjugate. In particular, we may assume $m = m'$ (for otherwise the value we aver to be $0$), giving
$
  chev(tilde(Y)_ell^m, tilde(Y)_ell'^m') &= 2 uppi integral_(-1)^1 (1-x^2)^(abs(m)) P_ell^((abs(m))) (x)P_ell'^((abs(m))) (x) dif x \
  & = 2 uppi (-1)^abs(m) integral_(-1)^1 dv(, x, abs(m))[(1-x^2)^(abs(m)) P_ell^((abs(m))) (x)] P_ell' (x) dx.
$
due to repeated applications of integration by parts. By @eq:spherical-harmonics-legendre-polynomials-differential-equation,
$
  (1 - x^2) P_ell^((j + 1)) - 2x j P_ell^((j)) = -(ell + j)(ell - j + 1) P_ell^((j - 1)),\
  dv(, x)[(1 - x^2)^j P_ell^((j))] = -(ell + j)(ell - j + 1) (1 - x^2)^(j - 1) P_ell^((j - 1)),\
  dv(, x, j)[(1 - x^2)^j P_ell^((j))] = -(ell + j)(ell - j + 1) dv(, x, j - 1)[(1 - x^2)^(j - 1) P_ell^((j - 1))],\
$
hence a repeated application gives
$
  chev(tilde(Y)_ell^m, tilde(Y)_ell'^m') & = 2 uppi (-1)^abs(m) integral_(-1)^1 [product_(j = 1)^abs(m) -(ell + j)(ell - j + 1)]P_ell (x)P_ell' (x) dx \
  &=2 uppi integral_(-1)^1 [product_(j = 1)^abs(m) (ell + j) product_(j = 1 - abs(m))^0 (ell + j)] P_ell (x)P_ell' (x) dx \
  &= 2 uppi (ell + abs(m))! / (ell - abs(m))! integral_(-1)^1 P_ell (x)P_ell' (x) dx = (ell + abs(m))! / (ell - abs(m))! (4 uppi) / (2 ell + 1) delta_(ell ell')
$
by the Legendre Orthogonality Relation (@thm:legendre-polynomials-orthogonality-relation). Thus we perform a normalization by
#definition[Spherical Harmonics][
  $
    Y_ell^m (Omega) = sqrt((2 ell + 1) / ( 4uppi) (ell - abs(m))! / (ell + abs(m))!) P_ell^abs(m) (cos theta) ee^(ii m phiaz), #tag[$(abs(m) <= ell)$]
  $
]
whence we obtain
#theorem[Orthonormality Relation][
  $
    chev(Y_ell^m, Y_ell'^m') = delta_(m m') delta_(ell ell')
  $ <eq:spherical-harmonics-orthonormality>
]
and
$
  laplacian_(S^2) Y_ell^m = -ell(ell + 1) Y_ell^m.
$
Writing
$
  Y_ell^m (Omega) prop (sin theta)^abs(m) P_ell^((abs(m))) (cos theta) ee^(ii m phiaz)
$
and adopting the spherical substitution $x = sin theta cos phiaz$, $y = sin theta sin phiaz$, $z = cos theta$,
$
  Y_ell^m (Omega) & prop sqrt(x^2 + y^2)^(abs(m)) P_ell^((abs(m))) (z) ((x + ii y) / sqrt(x^2 + y^2))^m,
$
wherein if $m > 0$,
$
  Y_ell^m (Omega) & prop P_ell^(m) (z) (x + ii y)^m,
$
and if $m < 0$,
$
  Y_ell^m (Omega) & prop sqrt(x^2 + y^2)^(abs(m)) P_ell^((abs(m))) (z) ((x - ii y) / sqrt(x^2 + y^2))^abs(m) = P_ell^(abs(m)) (z) (x - ii y)^abs(m).
$
Hence we obtain the restriction of polynomials of three real variables onto $S^2$. We aver that any polynomial in $x,y,z$ on $S^2$ can be written as a finite linear combination of spherical harmonics in the form above. Writing $w = x + ii y$, for any such polynomial
$
  p(x,y,z) = sum_(i,j,k) x^i y^j z^k = sum_(i,j,k) ((w + w^*) / 2)^i ((w - w^*) / (2 ii))^j z^k = sum_(i,j,k) C_(i j k) (w + w^*)^i (w - w^*)^j z^k
$
can be expanded to have terms only in the form of $C'_(i j k) w^i w^(* j) z^k$. On the sphere, each $w w^*$ pair may be expressed as a factor of $(1 - z^2)$, whence
$
  p(x,y,z) = sum C w^k q(z) + sum C w^(*k) q(z),
$
or more specifically, each term is the product of $w^k$ or $w^(*k)$ with an ordinary polynomial $q$ in $z$ only. Observing that each $P_k^((k)), P_(k + 1)^((k)), P_(k + 2)^((k)), dots$ has respective degree $0, 1, 2, dots$, $q(z)$ may be expressed as a linear combination $ q(z) = sum_(j = 0)^n a_j P_(k + j)^((k))(z) ==> w^k q(z) = sum_(j = 0)^n alpha_j Y_(k + j)^k (z), wide w^(* k) q(z) = sum_(j = 0)^n alpha_j Y_(k + j)^(-k) (z). $
Thus all polynomials $RR^3 -> CC$, when restricted to $S^2$, can be expressed as the finite linear combination of spherical harmonics. The former is dense in $L^2 (S^2)$, whence ${Y_ell^m}$ forms a complete orthonormal basis for $L^2 (S^2)$.

Furthermore, this observation is supplanted with
#theorem[Completeness Relation][
  Distributionally
  $
    sum_(ell = 0)^oo sum_(m = -ell)^ell Y_ell^m (Omega) Y_ell^(m*) (Omega') = delta_(S^2) (Omega, Omega'),
  $
  where $delta_(S^2)$ is defined with the filtering property
  $
    f(Omega) = integral.surf f(Omega') delta_(S^2)(Omega, Omega') dif Omega'.
  $
  Equivalently,
  $
    sum_(ell = 0)^oo sum_(m = -ell)^ell Y_ell^m (Omega) chev(f, Y_ell^m) = sum_(ell = 0)^oo sum_(m = -ell)^ell Y_ell^m (Omega) [integral.surf f(Omega') Y_ell^(m*) (Omega') dif Omega'] = f(Omega).
  $
] <thm:spherical-harmonics-completeness-relation>
by the Fourier expansion with respect to a complete orthonormal system (see @slipperking2025complexanalysis). A more concrete proof may be obtained by replicating the process so performed in @thm:legendre-polynomials-completeness-relation.

An explicit form may be given to $delta_(S^2)$ by realizing that
$
  f(Omega) = integral.surf f(Omega') delta_(S^2)(Omega, Omega') dif Omega' ==> integral_0^(2 uppi) integral_0^uppi f(arccos z', phiaz') delta_(S^2) (Omega, Omega') dz' dif phiaz',
$
thus implying
$
  delta_(S^2) (Omega, Omega') = delta(z - z') delta (phiaz - phiaz') = delta(cos theta - cos theta') delta(phiaz - phiaz').
$
The last result we aim to demonstrate at present will be of greatest applicability to our practical development.
