#import "/lib.typ": *
#import "/build/visual-output/electric-quadrupole/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("The Electric Quadrupole"),
  children: {
    include "traceless-quadrupole-tensor/index.typ"
    include "quadrupole-force-and-torque/index.typ"
  },
)

Following from @eq:electric-multipole-expansion, we now consider the effect for when $Q = 0 = va(p)$, so that the leading term of the expansion is the quadrupole with moment
#thm-state.thm-restate("def:electric-quadrupole-moment")
As with @sec:electric-dipole,
#theorem[
  If $Q = va(p) = 0$, then the electric quadrupole moment is independent of $va(r)_0$.
] <thm:electric-quadrupole-moment-exp-point-invariance>
#proof[
  Allow the consideration of two possible expansion points $va(r)_0$ and $va(r)'_0$ yielding two moments $vaa(Q)$ and $vaa(Q)'$ respectively. Then we also have $va(p) = va(p)' = 0$ by @thm:electric-dipole-moment-exp-point-invariance. Then
  $
    Q_(i j) &= 1/2 integral.triple_(s' < R) rho s'_i s'_j dif^3 r' = 1/2 integral.triple_(s' < R) rho(va(r)') (r'_i - r'_(0, i) + r'_(0, i) - r_(0, i))(r'_j - r'_(0, j) + r'_(0, j) - r_(0, j)) dif^3 r' \
    & = Q'_(i j) + 1/2 integral.triple_(s' < R) rho(va(r)') (r'_i - r'_(0, i)) dif^3 r' (r'_(0, j) - r_(0, j)) \
    & quad "" + 1/2 (r'_(0, i) - r_(0, i)) integral.triple_(s' < R) rho(va(r)') (r'_j - r'_(0, j)) dif^3 r' \
    &wide"" + 1/2 (r'_(0, i) - r_(0, i))(r'_(0, j) - r_(0, j)) integral.triple_(s' < R) rho(va(r)') dif^3 r' \
    &=Q'_(i j) + 1/2 p'_i (r'_(0, j) - r_(0, j)) + 1/2 p'_j (r'_(0, i) - r_(0, i)) + 1/2 (r'_(0, i) - r_(0, i))(r'_(0, j) - r_(0, j)) Q = Q'_(i j). qedhere
  $
]
The corresponding quadrupole term in $phi$, the _electric quadrupole potential_, is given by (for $s != 0$)
$
  phi_2 (va(r)) &= 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') s'_i s'_j d^3 r' partial_i partial_j 1 / s \
  &= -1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') s'_i s'_j d^3 r' partial_i s_j / s^3 \
  &= -1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') s'_i s'_j d^3 r' (s^3 partial_i s_j - s_j partial_i s^3) / s^6 \
  &= 1 / (4 uppi epsilon_0) 1 / 2 integral.triple_(s' < R) rho(va(r)') s'_i s'_j d^3 r' (3 s_i s_j - s^2 delta_(i j)) / s^5.
$ <eq:electric-quadrupole-potential>
#figure-wrapper[
  #figure(
    {
      set text(size: 0.95em)
      canvas(
        length: 1.44cm,
        // debug-show: true,
        {
          import cetz.draw: *

          let field-stroke = (paint: black, thickness: 0.62pt)
          let vector-stroke = (paint: black, thickness: 0.8pt)
          let point-x = -2.75
          let charge-x = 2.75
          let axis-bottom = -1.65
          let c-half-x = 0.5
          let p-half-x = 0.1573
          let p-half-z = 0.3896

          let shift-curve(curve, center) = curve.map(point => {
            let (x, z) = point
            (center + x, z)
          })
          let draw-generated-field(curves, arrows, center) = {
            for curve in curves {
              line(..shift-curve(curve, center), stroke: field-stroke)
            }
            for arrow in arrows {
              let shifted-arrow = shift-curve(arrow, center)
              mark(
                shifted-arrow.at(0),
                shifted-arrow.at(1),
                ">>",
                fill: black,
                stroke: none,
                scale: 0.78,
              )
            }
          }

          draw-generated-field(
            point-quadrupole-curves,
            point-quadrupole-arrows,
            point-x,
          )
          draw-generated-field(
            four-charge-quadrupole-curves,
            four-charge-quadrupole-arrows,
            charge-x,
          )

          line(
            (point-x, 0),
            (point-x + 0.78, 0),
            stroke: vector-stroke,
            mark: (end: ">>", fill: black),
          )
          line(
            (point-x, 0),
            (point-x + 0.2922, 0.7242),
            stroke: vector-stroke,
            mark: (end: ">>", fill: black),
          )
          circle((point-x, 0), radius: 3.4pt, fill: white, stroke: field-stroke)

          for (offset-x, offset-z) in (
            (c-half-x + p-half-x, p-half-z),
            (-c-half-x + p-half-x, p-half-z),
            (c-half-x - p-half-x, -p-half-z),
            (-c-half-x - p-half-x, -p-half-z),
          ) {
            circle(
              (charge-x + offset-x, offset-z),
              radius: 4.2pt,
              fill: white,
              stroke: field-stroke,
            )
          }

          content(
            (point-x + 0.78, 0),
            anchor: "west",
            padding: 3pt,
            math-rect($vu(c)$),
          )
          content(
            (point-x + 0.2922, 0.7242),
            anchor: "south",
            padding: 3pt,
            math-rect($va(p)$),
          )
          content(
            (charge-x + c-half-x + p-half-x, p-half-z),
            anchor: "south-west",
            padding: 5pt,
            math-rect($+q$),
          )
          content(
            (charge-x - c-half-x + p-half-x, p-half-z),
            anchor: "south-east",
            padding: 5pt,
            math-rect($-q$),
          )
          content(
            (charge-x + c-half-x - p-half-x, -p-half-z),
            anchor: "north-west",
            padding: 5pt,
            math-rect($-q$),
          )
          content(
            (charge-x - c-half-x - p-half-x, -p-half-z),
            anchor: "north-east",
            padding: 5pt,
            math-rect($+q$),
          )
          content(
            (point-x, axis-bottom - 0.14),
            anchor: "north",
            [Point quadrupole],
          )
          content(
            (charge-x, axis-bottom - 0.14),
            anchor: "north",
            [Four-charge quadrupole],
          )
        },
      )
    },
    caption: [Field-lines of a point quadrupole and a quadrupole formed by four charges in a parallelogram, with sides $d vu(c)$ and $va(p)$ shown at left.],
  ) <fig:point-and-four-charge-quadrupoles>
]

As with the previous two instances, the construction of this term is describable with aid from a _point quadrupole_. In particular, we consider four point charges in a checkerboard pattern converging to a single point. As such, we consider two point dipoles with moments $plus.minus va(p) / d$ at $va(r)_0 plus.minus d/2 vu(c)$ with a vanishing separation $d -> 0$.

With @eq:electric-dipole-potential, the electrostatic potential of a point quadrupole is hence
$
  phi (va(r)) &= lim_(d -> 0^+) 1 / (4 uppi epsilon_0) va(p) / d dot [(va(r) - va(r)_0 - d/2 vu(c)) / norm(va(r) - va(r)_0 - d/2 vu(c))^3 - (va(r) - va(r)_0 + d/2 vu(c)) / norm(va(r) - va(r)_0 + d/2 vu(c))^3] \
  &= -lim_(d -> 0^+) 1 / (4 uppi epsilon_0) 2 / d sinh(d / 2 vu(c) dot grad) (va(p) dot va(s)) / s^3 \
  &= -lim_(d -> 0^+) 1 / (4 uppi epsilon_0) 2 / d [d / 2 vu(c) dot grad + Order(d / 2 vu(c) dot grad)^3] (va(p) dot va(s)) / s^3 \
  &= -1 / (4 uppi epsilon_0) (vu(c) dot grad) (va(p) dot va(s)) / s^3 = 1 / (4 uppi epsilon_0) (vu(c) dot grad) (va(p) dot grad) 1 / s \
  &= 1 / (4 uppi epsilon_0) 1 / 2 (vu(c) times.o va(p)) : grad^(times.o 2) 1 / s + 1 / (4 uppi epsilon_0) 1 / 2 (vu(c) times.o va(p))^top : (grad^(times.o 2))^top 1 / s \
  &= 1 / (4 uppi epsilon_0) 1 / 2 (vu(c) times.o va(p) + va(p) times.o vu(c)) : grad^(times.o 2) 1 / s
$ <eq:electric-point-quadrupole-potential>
which bears resemblance to the quadrupole term of @eq:electric-multipole-expansion, if we had previously found
$
  vaa(Q) = 1/2 (vu(c) times.o va(p) + va(p) times.o vu(c)), wide Q_(i j) = 1/2 (hat(c)_i p_j + p_i hat(c)_j)
$
to be consistent with @def:electric-quadrupole-moment. Notably, the charge density is expressible as the sum of that for two point dipoles:
$
  rho(va(r)) & = - lim_(d -> 0^+) va(p) / d dot grad [delta(va(r) - va(r)_0 - d/2 vu(c)) - delta(va(r) - va(r)_0 + d / 2 vu(c))] \
  & = - lim_(d -> 0^+) (2 va(p)) / d dot grad sinh(-d/2 vu(c) dot grad) delta(va(r) - va(r)_0) \
  & = - lim_(d -> 0^+) (2 va(p)) / d dot grad [-d / 2 vu(c) dot grad + d^3 Order(vu(c) dot grad)^3] delta(va(r) - va(r)_0),
$
giving
$
  rho(va(r)) = (va(p) dot grad) (vu(c) dot grad) delta(va(r) - va(r)_0) = (va(p) times.o vu(c)) : grad^(times.o 2) delta(va(s)),
$ <eq:electric-point-quadrupole-density-two-vectors>
whence
$
  vaa(Q) &= 1/2 integral.triple_(s' < R) rho(va(r)') va(s)'^(times.o 2) dif^3 r' = 1/2 integral.triple_(s' < R) [(va(p) times.o vu(c)) : grad'^(times.o 2) delta(va(s)')] va(s)'^(times.o 2) dif^3 r' \
  &= 1/2 integral.triple_(s' < R) [(va(p) times.o vu(c)) : grad'^(times.o 2) delta(va(s)')] va(s)'^(times.o 2) dif^3 r' \
  &= 1/2 integral.triple_(s' < R) va(s)'^(times.o 2) p_m hat(c)_n partial'_m partial'_n delta(va(s)') dif^3 r' = 1/2 p_m hat(c)_n integral.triple_(s' < R) delta(va(s)') partial'_m partial'_n (s'_i s'_j) dif^3 r' vu(e)_i times.o vu(e)_j \
  &= 1/2 p_m hat(c)_n integral.triple_(s' < R) delta(va(s)') partial'_m (s'_j partial'_n s'_i + s'_i partial'_n s'_j) dif^3 r' vu(e)_i times.o vu(e)_j \
  &= 1/2 p_m hat(c)_n integral.triple_(s' < R) delta(va(s)') (partial'_m s'_j partial'_n s'_i + s'_j partial'_m partial'_n s'_i + partial'_m s'_i partial'_n s'_j + s'_i partial'_m partial'_n s'_j) dif^3 r' vu(e)_i times.o vu(e)_j \
  &= 1/2 p_m hat(c)_n integral.triple_(s' < R) delta(va(s)') (delta_(m j) delta_(n i) + delta_(m i) delta_(n j)) dif^3 r' vu(e)_i times.o vu(e)_j \
  &= 1/2 (p_j hat(c)_i integral.triple_(s' < R) delta(va(s)') dif^3 r' + p_i hat(c)_j integral.triple_(s' < R) delta(va(s)') dif^3 r') vu(e)_i times.o vu(e)_j \
  &= 1/2 (vu(c) times.o va(p) + va(p) times.o vu(c)),
$
wherein we have used integration by parts twice. This confirms the quadrupole as the sole term in the multipole expansion for a given point quadrupole. The corresponding moment is given by
#theorem[Electric Point Quadrupole Moment][
  $
    vaa(Q) = 1/2 (vu(c) times.o va(p) + va(p) times.o vu(c)).
  $
] <thm:electric-quadrupole-moment>
whence and from @eq:electric-point-quadrupole-density-two-vectors,
#theorem[Electric Point Quadrupole Density][
  $
    rho(va(r)) = vaa(Q) : grad^(times.o 2) delta(va(s)).
  $
] <thm:electric-point-quadrupole-density>
This symmetry in $vaa(Q)$ permits the corresponding matrix $vb(Q)$ under the basis ${vu(e)_1, vu(e)_2, vu(e)_3}$ to be written as
$
  vb(Q) = xmat(3, 3, #{ (a, b) => $Q_(#a#b)$ })
$
to be characterized by at most six independent numbers. Moreover,
#theorem[Spectral Theorem][
  The symmetric $3 times 3$ matrix $vb(M)$ can be unitarily diagonalized by an orthonormal basis of real eigenvectors.
] <thm:symmetric-spectral-theorem>
#proof(collapsed: true)[of @thm:symmetric-spectral-theorem][
  Since for $va(x), va(y) in RR^3$,
  $
    va(x)^top vb(M) va(y) = va(y)^top vb(M) va(x).
  $
  The characteristic polynomial
  $
    lambda |-> det(vb(M) - lambda vb(I))
  $
  is a cubic with at least one real root $lambda_1$, whence $[vb(M) - lambda vb(I)]va(v) = 0$ has a nonzero solution $va(v)$, which we may assume to be a unit vector $vu(e)_1$ by normalization.

  Denote by $vu(e)_1^perp$ the two-dimensional orthogonal complement of $vu(e)_1$, which is invariant under $vb(M)$ as for any $va(v) in vu(e)_1^perp$,
  $
    vu(e)_1^top (vb(M) va(v)) = va(v)^top vb(M) vu(e)_1 = va(v)^top lambda vu(e)_1 = 0.
  $
  Then restricting $vb(M)$ to the complement, $vb(M)_1 : vu(e)_1^perp -> vu(e)_1^perp$ is symmetric. In a basis ${vu(u), vu(v)}$ of $vu(e)_1^perp$, we have thence
  $
    vb(M)_1 = mat(a, b; b, d),
  $
  whereby $lambda |-> det(vb(M)_1 - lambda vb(I))$ has the discriminant
  $ (a - d)^2 + 4b^2 >= 0, $
  giving rise to a second eigenvalue $lambda_2$ and eigenvector $vu(e)_2^perp$. In the plane of $vu(e)_1^perp$, the unit vector orthogonal to $vu(e)_2^perp$ gives rise to the third eigenvector $vu(e)_3^perp$ with eigenvalue $lambda_3$. Expressing all all vectors in the basis ${vu(x), vu(y), vu(z)}$, we have
  $
    mat(|, |, |; vu(e)_1, vu(e)_2, vu(e)_3; |, |, |) dmat(lambda_1, lambda_2, lambda_3, fill: dot) &= mat(|, |, |; lambda_1 vu(e)_1, lambda_2 vu(e)_2, lambda_3 vu(e)_3; |, |, |)
    &= mat(|, |, |; vb(M) vu(e)_1, vb(M) vu(e)_2, vb(M) vu(e)_3; |, |, |) = vb(M) mat(|, |, |; vu(e)_1, vu(e)_2, vu(e)_3; |, |, |),
  $
  wherein if we define
  $
    vb(U) = mat(|, |, |; vu(e)_1, vu(e)_2, vu(e)_3; |, |, |), wide vb(D) = dmat(lambda_1, lambda_2, lambda_3, fill: dot),
  $
  we obtain $vb(M) = vb(U)vb(D)vb(U)^(-1)$.
]
Hence, we have the following diagonal form of the dyadic tensor
$ vaa(Q) = Q'_(1 1) vu(e)'_1^(times.o 2) + Q'_(2 2) vu(e)'_2^(times.o 2) + Q'_(3 3) vu(e)'_3^(times.o 2), $
for an orthonormal basis ${vu(e)'_1,vu(e)'_2,vu(e)'_3}$, the existence whereof was given in @thm:symmetric-spectral-theorem. Let the matrices for $vaa(Q)$ in the bases ${vu(e)'_1,vu(e)'_2,vu(e)'_3}$ and ${vu(e)_1, vu(e)_2, vu(e)_3}$ be denoted by $vb(Q)'$ and $vb(Q)$ respectively, which then satisfy
$
  vb(Q)' = vb(U)^(-1) vb(Q) vb(U).
$ <eq:electric-quadrupole-moment-principal-axis>
This is known as the _principal axis_ coordinate system.
