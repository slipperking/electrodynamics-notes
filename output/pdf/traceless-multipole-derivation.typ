// Compile from the repository root with the local typst.exe, --root .,
// --package-path packages, and --font-path src/assets/fonts/typst.
#import "/lib.typ": va, vu, vaa, vb, gradp, laplacianp, uppi

#set document(title: "From Primitive to Traceless Multipole Moments", author: "Electrodynamics Notes")
#set page(paper: "a4", margin: (x: 23mm, y: 15mm), numbering: "1")
#set text(font: ("Lato", "Arial"), size: 11pt)
#set par(justify: true, leading: 0.58em, spacing: 0.68em)
#set heading(numbering: "1.")
#show heading: set text(size: 11pt)
#show math.equation: set text(font: ("Lete Sans Math", "New Computer Modern Math"))
#set math.equation(numbering: "(1)")

#text(size: 14.5pt, weight: "bold")[From Primitive to Traceless Multipole Moments]

Choose the expansion center as the origin. Then $va(r)$ and $va(r)'$ here are the $va(s)$ and $va(s)'$ of Chapter 4. Write $r = norm(va(r))$, $r' = norm(va(r)')$, and $x = vu(r) dot vu(r)'$. The source lies within $r' <= R$, and the field point has $r > R$.

= Separate the field direction in the first few orders

Substitute the exterior Legendre series into the Coulomb integral to recover the starting equation of “Primitive and Traceless Multipole Moments.”
$
  phi(va(r))
  &= 1 / (4 uppi epsilon_0) integral.triple_(r' <= R)
    rho(va(r)') sum_(ell=0)^oo (r')^ell / r^(ell+1) P_(ell) (x) dif^3 r' \
  &= 1 / (4 uppi epsilon_0) sum_(ell=0)^oo 1 / r^(ell+1)
    integral.triple_(r' <= R) rho(va(r)') (r')^ell P_(ell) (x) dif^3 r'.
$ <eq:legendre-potential>
The sum can pass through the integral since $|P_(ell) (x)| <= 1$ and $r'/r <= R/r < 1$, so the kernel series is bounded term by term by a convergent geometric series. The field radius is now outside the integral. The field direction $vu(r)$ is still inside through $x$. We can pull it outside too by writing each angular factor as a contraction with copies of $vu(r)$.

For the monopole, $P_0 = 1$, so the integral is the total charge $Q$. For the dipole, $P_(1) (x) = x$, and
$
  integral.triple_(r' <= R) rho(va(r)') r' P_(1) (x) dif^3 r'
  &= integral.triple_(r' <= R) rho(va(r)') (vu(r) dot va(r)') dif^3 r' \
  &= vu(r) dot integral.triple_(r' <= R) rho(va(r)') va(r)' dif^3 r'
   = va(p) dot vu(r).
$
The dipole contribution to the potential is therefore $(va(p) dot vu(r)) / (4 uppi epsilon_0 r^2) = (va(p) dot va(r)) / (4 uppi epsilon_0 r^3)$.

At rank two, write the square of the dot product and the scalar $1$ as double contractions.
$
  (vu(r) dot va(r)')^2 = (va(r)')^(times.o 2) : vu(r)^(times.o 2),
  quad 1 = vaa(I) : vu(r)^(times.o 2),
$
where $vaa(I)$ is the identity tensor. The second equality follows because the contraction gives $vu(r) dot vu(r) = 1$. Now substitute $x = (vu(r) dot va(r)')/r'$ into $P_(2) (x) = (3x^2 - 1)/2$.
$
  (r')^2 P_(2) (x)
  &= 1/2 [3 (r')^2 ((vu(r) dot va(r)')/r')^2 - (r')^2] \
  &= 1/2 [3 (vu(r) dot va(r)')^2 - (r')^2] \
  &= 1/2 [3 (va(r)')^(times.o 2) - (r')^2 vaa(I)] : vu(r)^(times.o 2).
$ <eq:quadrupole>
The coefficient of $vu(r)^(times.o 2)$ integrates to the chapter's traceless quadrupole. In fact, the primitive tensor $vaa(Q)$ is the integral of $rho(va(r)') (va(r)')^(times.o 2)/2$, and its trace replaces $(va(r)')^(times.o 2)$ by $(r')^2$. Thus
$
  vaa(Theta)
    = 1/2 integral.triple_(r' <= R) rho(va(r)') [3 (va(r)')^(times.o 2) - (r')^2 vaa(I)] dif^3 r'
    = 3 vaa(Q) - vaa(I) op("tr") vaa(Q).
$
Since $vu(r)^(times.o 2) = va(r)^(times.o 2)/r^2$, the quadrupole potential is
$
  phi_2 (va(r))
   = 1 / (4 uppi epsilon_0) (vaa(Theta) : vu(r)^(times.o 2)) / r^3
   = 1 / (4 uppi epsilon_0) (vaa(Theta) : va(r)^(times.o 2)) / r^5.
$

#pagebreak()

= Find the same quadrupole tensor by differentiation

The bracket in @eq:quadrupole also arises in the chapter's primitive quadrupole calculation. To see it in the source coordinate, use $gradp$ for differentiation in $va(r)'$. First, $(r')^2 = va(r)' dot va(r)'$, so $gradp (r')^2 = 2 va(r)'$. Taking the gradient of $r' = [(r')^2]^(1/2)$ and then of $1/r'$ gives
$
  gradp r' &= 1/2 [(r')^2]^(-1/2) 2 va(r)' = va(r)' / r', \
  gradp (1 / r') &= -(r')^(-2) gradp r' = -va(r)' / (r')^3.
$
For the second derivative, differentiate the vector and the radial factor separately. Their derivatives are $gradp va(r)' = vaa(I)$ and $gradp (r')^(-3) = -3(r')^(-4) gradp r' = -3 va(r)'/(r')^5$. The product rule gives
$
  (gradp)^(times.o 2) (1 / r')
  &= gradp (-(r')^(-3) va(r)') \
  &= -(gradp (r')^(-3)) times.o va(r)' - (r')^(-3) gradp va(r)' \
  &= (3 (va(r)')^(times.o 2)) / (r')^5 - vaa(I) / (r')^3 \
  &= (3 (va(r)')^(times.o 2) - (r')^2 vaa(I)) / (r')^5 .
$ <eq:hessian>
Multiply @eq:hessian by $(r')^5/2$ to recover the coefficient of $vu(r)^(times.o 2)$ in @eq:quadrupole. The Legendre generating series will show which derivative and which power of $r'$ give the coefficient at every order.

= Obtain the derivative at order $ell$

Hold $va(r)' != 0$ and the direction $vu(r)$ fixed. Starting at $va(r)'$, displace by $-t vu(r)$, with $t$ a scalar near zero. The squared distance is $(r')^2 - 2t r' x + t^2$, since $va(r)' dot vu(r) = r' x$ and $vu(r) dot vu(r) = 1$. Factor out $(r')^2$ and apply the same Legendre generating series as in Chapter 4.
$
  1 / norm(va(r)' - t vu(r))
  &= 1 / sqrt((r')^2 - 2t r' x + t^2) \
  &= 1 / r' [1 - 2x(t/r') + (t/r')^2]^(-1/2) \
  &= sum_(n=0)^oo (P_(n) (x)) / (r')^(n+1) t^n, quad |t| < r'.
$ <eq:shift>
To isolate the coefficient of $t^ell$, differentiate both sides $ell$ times and set $t=0$. On the series side, the power rule gives $n(n-1) dots.c (n-ell+1)t^(n-ell)$ for $n >= ell$. This equals $ell!$ when $n=ell$ and vanishes at $t=0$ when $n>ell$. Terms with $n<ell$ differentiate to zero. The surviving term is $(ell! P_(ell) (x)) / (r')^(ell+1)$.

On the distance side, the chain rule gives one directional derivative along $-vu(r)$ for each derivative in $t$. In particular,
$
  (dif / (dif t)) [1 / norm(va(r)' - t vu(r))]
    = -vu(r) dot gradp [1 / norm(va(r)' - t vu(r))].
$
The direction $vu(r)$ is constant, so repeating this derivative $ell$ times and then setting $t=0$ turns the distance factor into $1/r'$ and gives
$
  (ell! P_(ell) (x)) / (r')^(ell+1)
    = (-1)^ell (vu(r) dot gradp)^ell (1 / r').
$ <eq:directional>

#pagebreak()

= Pull the field direction outside the integral

Divide @eq:directional by $ell!$, then multiply by $(r')^(ell+1)$ to get $P_(ell) (x)$. The integral in @eq:legendre-potential contains $(r')^ell P_(ell) (x)$, so multiply by another $(r')^ell$.
$
  P_(ell) (x)
    &= (-1)^ell / ell! (r')^(ell+1) (vu(r) dot gradp)^ell (1 / r'), \
  (r')^ell P_(ell) (x)
    &= (-1)^ell / ell! (r')^(2ell+1) (vu(r) dot gradp)^ell (1 / r').
$ <eq:source-weight>
Every factor $vu(r) dot gradp$ differentiates once and pairs that derivative with a copy of $vu(r)$. Collect the derivatives into one tensor and the unit vectors into another, with $limits(dot)^ell$ denoting contraction over all $ell$ pairs of slots.
$
  (vu(r) dot gradp)^ell (1 / r')
    = [(gradp)^(times.o ell) (1 / r')] limits(dot)^ell vu(r)^(times.o ell).
$ <eq:contraction>
At rank zero the derivative acts as the identity and the contraction is scalar multiplication. The derivative tensor is symmetric because the partial derivatives commute. For $ell >= 2$, tracing any pair of slots combines two partial derivatives into the Laplacian,
$
  op("tr")_(12) [(gradp)^(times.o ell) (1 / r')]
  = (gradp)^(times.o (ell-2)) [laplacianp (1 / r')]
  = 0, quad r' > 0.
$
The weighted tensor, including $(r')^(2ell+1)$, extends to the origin. Each derivative lowers the degree of homogeneity by one, so the weighted tensor has degree $2ell+1-(ell+1)=ell$. Its angular factor is smooth on the unit sphere. It therefore tends to zero as $r'$ tends to zero for $ell>0$. At $ell=0$ the weighted factor is $r'(1/r')=1$.

Use @eq:source-weight to replace $(r')^ell P_(ell) (x)$ in @eq:legendre-potential, and use @eq:contraction to write the directional derivatives as a contraction. The vector $vu(r)$ is fixed during integration and can be taken outside it.
$
  phi(va(r))
  &= 1 / (4 uppi epsilon_0) sum_(ell=0)^oo 1 / r^(ell+1)
    integral.triple_(r' <= R) rho(va(r)') (-1)^ell / ell! (r')^(2ell+1)
    [(gradp)^(times.o ell) (1 / r')] limits(dot)^ell vu(r)^(times.o ell) dif^3 r' \
  &= 1 / (4 uppi epsilon_0) sum_(ell=0)^oo
    (vb(T)^((ell)) limits(dot)^ell vu(r)^(times.o ell)) / r^(ell+1),
$
where $vb(T)^((ell))$ is the integral of the source tensor. Finally, $vu(r)^(times.o ell) = va(r)^(times.o ell)/r^ell$, so $r^(ell+1) r^ell = r^(2ell+1)$ in the denominator. The two formulas are Zangwill's (4.123) and (4.124) in the chapter's tensor notation.
$
  phi(va(r)) = 1 / (4 uppi epsilon_0) sum_(ell=0)^oo
    (vb(T)^((ell)) limits(dot)^ell va(r)^(times.o ell)) / r^(2ell+1),
  quad r > R.
$
$
  vb(T)^((ell)) = (-1)^ell / ell! integral.triple_(r' <= R)
    rho(va(r)') (r')^(2ell+1) [(gradp)^(times.o ell) (1 / r')] dif^3 r'.
$

#text(size: 9pt)[Andrew Zangwill, _Modern Electrodynamics_, §4.7, pp. 116–118.]

