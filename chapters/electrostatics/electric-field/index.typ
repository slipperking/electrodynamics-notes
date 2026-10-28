#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [The Electric Field],
  route: "electric-field",
  children: include "applications-of-gauss-law/index.typ",
)
Experimental work nearing the end of the 18th century established that in the case of approximated point charges, the force on a _test charge_ $q$ at $va(r)$ (which may or may not be stationary) due to $n$ stationary _source_ point charges $q_k$ at $va(r)_k$ follows the inverse-square law. We (for this instant) only consider the case of _electrostatics_ (where source charges are time-static), in which the relation holds. The formulation thereof is given by _Coulomb's Law_, for the case of a vacuum:
#theorem[Coulomb's Law][
  //
  $ va(F) = 1 / (4 uppi epsilon_0) sum_(k=1)^n (q q_k) / norm(va(r) - va(r)_k)^3 (va(r) - va(r)_k). $ <eq:coulombs-law>
] <thm:coulombs-law>
The coefficient $1 / (4 uppi epsilon_0) = #qty("8.9875517923e9", "N * m^2 / C^2")$ is also known as _Coulomb's constant_ and reflects our choice of units. In certain mediums, the constant $epsilon_0$ is replaced by a more general $epsilon$ which more accurately reflects the given medium (cf. @todo).

There exists a generalization of @thm:coulombs-law which does not depend on the necessitated use of point source charges nor the explicitness of the test charge $q$.
#definition[Electric Field][
  For a time-static source charge density distribution $rho(va(r))$, define
  $
    va(E)(va(r)) = 1 / (4 uppi epsilon_0) integral (dif Q') / norm(va(r) - va(r)')^3 (va(r) - va(r)') = 1 / (4 uppi epsilon_0) integral.triple (rho(va(r)') dif V') / norm(va(r) - va(r)')^3 (va(r) - va(r)'),
  $ <eq:electric-field>
  known as the _electric field_. For a surface or line charge distribution, this is
  $
    va(E)(va(r)) = 1 / (4 uppi epsilon_0) integral.double (sigma(va(r)') dif S') / norm(va(r) - va(r)')^3 (va(r) - va(r)'),\ va(E)(va(r)) = 1 / (4 uppi epsilon_0) integral (lambda(va(r)') dif l') / norm(va(r) - va(r)')^3 (va(r) - va(r)').
  $ <eq:electric-field-surface-line>
]
#remark[
  By virtue of the equations @eq:surface-charge-density-as-volume and @eq:line-charge-density-as-volume, the specific representations in @eq:electric-field-surface-line to those of @eq:electric-field. In particular,
  $
    1 / (4 uppi epsilon_0) integral.triple (rho(va(r)') dif V') / norm(va(r) - va(r)')^3 (va(r) - va(r)') &= 1 / (4 uppi epsilon_0) integral.triple [integral.double sigma(va(r)'') delta^3(va(r)'' - va(r)') dif S''](dif V') / norm(va(r) - va(r)')^3 (va(r) - va(r)') \
    &= 1 / (4 uppi epsilon_0) integral.double sigma(va(r)'') [integral.triple delta^3(va(r)'' - va(r)') (va(r) - va(r)') / norm(va(r) - va(r)')^3 dif V'] dif S'' \
    &= 1 / (4 uppi epsilon_0) integral.double sigma(va(r)'') (va(r) - va(r)'') / norm(va(r) - va(r)'')^3 dif S'',
  $
  and similarly for the case of line charge distributions,
  $
    1 / (4 uppi epsilon_0) integral.triple (rho(va(r)') dif V') / norm(va(r) - va(r)')^3 (va(r) - va(r)') &= 1 / (4 uppi epsilon_0) integral.triple [integral lambda(va(r)'') delta^3(va(r)'' - va(r)') dif l''](dif V') / norm(va(r) - va(r)')^3 (va(r) - va(r)') \
    &= 1 / (4 uppi epsilon_0) integral lambda(va(r)'') [integral.triple delta^3(va(r)'' - va(r)') (va(r) - va(r)') / norm(va(r) - va(r)')^3 dif V'] dif l'' \
    &= 1 / (4 uppi epsilon_0) integral lambda(va(r)'') (va(r) - va(r)'') / norm(va(r) - va(r)'')^3 dif l''.
  $
]
Then in terms of electric fields, Coulomb's Law states
$
  va(F) = q va(E).
$ <eq:coulombs-law-electric-field>
Moreover, this definition also well demonstrates the _principle of superposition_, which states that for a source charge density distribution, the electric field thereby can be calculated by the sum of the electric fields of each of the constituent summative pieces.

The abstraction as represented by the transition from @eq:coulombs-law to @eq:coulombs-law-electric-field demonstrates an important conceptual shift between force acting between charges at a large distance and a force determined by a local value of a single value, the electric field. It is likely entirely possible to develop the entirety of classical electrodynamics through the lens of action-at-a-distance, although doing so would likely prove to be cumbersome.

Subsequently,
#theorem[Gauss' Law][
  For electrostatics,
  $ div va(E) = rho / epsilon_0 quad "and" quad curl va(E) = 0. $ <eq:gauss-law>
] <thm:gauss-law>
#proof[
  Recall from @todo that
  $
    // using dirac delta identities and gradient identities
    (va(r) - va(r)') / norm(va(r) - va(r)')^3 = - grad 1 / norm(va(r) - va(r)') quad "and" quad laplacian 1 / (norm(va(r) - va(r)')) = - 4 uppi delta(va(r) - va(r)'),
  $
  whence @eq:electric-field can be rewritten to yield
  $
    va(E)(va(r)) = 1 / (4 uppi epsilon_0) integral.triple_V (rho(va(r)') dif V') / norm(va(r) - va(r)')^3 (va(r) - va(r)') = -1 / (4 uppi epsilon_0) integral.triple_V rho(va(r)') grad 1 / norm(va(r) - va(r)') dif V'.\
    curl va(E)(va(r)) = -1 / (4 uppi epsilon_0) integral.triple_V rho(va(r)') curl grad 1 / norm(va(r) - va(r)') dif V' = 0,
  $
  proving the second identity, and
  $
    div va(E)(va(r)) & = -1 / (4 uppi epsilon_0) integral.triple_V rho(va(r)') div grad 1 / norm(va(r) - va(r)') dif V' \
    & = -1 / (4 uppi epsilon_0) integral.triple_V rho(va(r)') laplacian 1 / norm(va(r) - va(r)') dif V' \
    & = -1 / (4 uppi epsilon_0) integral.triple_V rho(va(r)') [-4 uppi delta(va(r) - va(r)')] dif V' = (rho(va(r))) / (epsilon_0). qedhere
  $
]
Gauss' Law (@thm:gauss-law) is the first of the four _Maxwell's equations_. We shall eventually see that the first equation $div va(E) = rho / epsilon_0$ will hold not only for electrostatics but for any general situation, as with all Maxwell's equations. There also is an integral representation, whose obtention follows naturally from the Divergence Theorem:
$
  Q_"enc" / epsilon_0 = integral.triple_V rho(va(r)) / epsilon_0 dif V = integral.triple_V div va(E) dif V = integral.surf_(partial V) va(E) dot dif va(S).
$ <eq:gauss-law-integral>
#figure-wrapper[
  #figure(
    {
      canvas(
        // debug-show: true,
        {
          import cetz.draw: *

          let axis-stroke = (paint: black, thickness: 0.45pt)
          let wire-stroke = (paint: black, thickness: 1.25pt)
          let vector-stroke = (paint: black, thickness: 0.8pt)
          let guide-stroke = (
            paint: black,
            thickness: 0.35pt,
            dash: "dashed",
          )

          line(
            (-3.6, 0),
            (3.7, 0),
            stroke: axis-stroke,
            mark: (end: ">>", fill: black),
          )
          line(
            (0, -0.45),
            (0, 3.15),
            stroke: axis-stroke,
            mark: (end: ">>", fill: black),
          )
          line((-3, 0), (3, 0), name: "wire", stroke: wire-stroke)
          line((-3, -0.11), (-3, 0.11), stroke: wire-stroke)
          line((3, -0.11), (3, 0.11), stroke: wire-stroke)

          line((0, 0), (0, 2.45), name: "height", stroke: guide-stroke)
          line(
            (1.35, 0),
            (0, 2.45),
            name: "separation-vector",
            stroke: vector-stroke,
            mark: (end: ">>", fill: black),
          )
          circle((1.35, 0), radius: 2pt, fill: black, stroke: none)
          circle((0, 2.45), radius: 2pt, fill: black, stroke: none)

          content(
            (-3, -0.16),
            anchor: "north",
            padding: 2pt,
            math-rect($-L / 2$),
          )
          content(
            (3, -0.16),
            anchor: "north",
            padding: 2pt,
            math-rect($L / 2$),
          )
          content((3.7, 0), anchor: "west", padding: 2pt, math-rect($x$))
          content((0, 3.15), anchor: "south", padding: 2pt, math-rect($z$))
          content(
            "wire.25%",
            anchor: "south",
            padding: 4pt,
            math-rect($lambda$),
          )
          content(
            (1.35, 0),
            anchor: "north",
            padding: 3pt,
            math-rect($va(x)$),
          )
          content(
            (0, 2.45),
            anchor: "east",
            padding: 3pt,
            math-rect($va(z)$),
          )
          content(
            "height.50%",
            anchor: "east",
            padding: 3pt,
            math-rect($z$),
          )
          content(
            "separation-vector.52%",
            anchor: "south-west",
            padding: 3pt,
            math-rect($va(r) - va(r)'$),
          )
        },
      )
    },
    caption: [The uniformly charged line segment and the observation point $va(z) = z vu(z)$.],
  ) <fig:uniformly-charged-line-geometry>
]
#example[
  Find the electric field a distance $z$ above the midpoint of a straight line segment of length $L$ carrying a uniform charge density $lambda$.
] <ex:electric-field-at-point-for-uniformly-charged-line>
#solution[to @ex:electric-field-at-point-for-uniformly-charged-line][
  By @eq:electric-field-surface-line,
  $
    va(E)(z vu(z)) = 1 / (4 uppi epsilon_0) integral_(-L / 2)^(L / 2) (lambda dif x) / norm(z vu(z) - x vu(x))^3 (z vu(z) - x vu(x)) = lambda / (4 uppi epsilon_0) integral_(-L / 2)^(L / 2) (z vu(z) - x vu(x)) / (x^2 + z^2)^(3/2) dx.
  $
  The $x$-component of the above integral vanishes by symmetry. Therefore, with $x = z tan theta$,
  $
    va(E)(z vu(z)) &= (z vu(z))/ (4 uppi epsilon_0) lambda integral_(-L / 2)^(L / 2) dx / (x^2 + z^2)^(3/2) = (z vu(z))/ (4 uppi epsilon_0) lambda integral (dif (z tan theta)) / (z^2 (tan theta^2 + 1))^(3/2) \
    & = vu(z)/ (4 uppi epsilon_0) lambda / z integral (sec^2 theta dif theta) / (sec^3 theta) = vu(z)/ (4 uppi epsilon_0) lambda / z evaluated(sin theta)_(x = -L / 2)^(x = L / 2) \ & = vu(z)/ (4 uppi epsilon_0) lambda / z evaluated(x / sqrt(x^2 + z^2))_(-L / 2)^(L / 2) = 1 / (4 uppi epsilon_0) (2 L lambda vu(z)) / (z sqrt(L^2 + 4 z^2)). qedhere
  $
]

Notably, in consideration of a wire of infinite length, then the electric field evaluated at a point a distance $z > 0$ away is given by
$
  va(E)(va(z)) = lim_(L -> oo) 1 / (4 uppi epsilon_0) (2 L lambda vu(z)) / (z sqrt(L^2 + 4 z^2)) = 1 / (4 uppi epsilon_0) (2 lambda vu(z)) / z.
$
At a long distance ($z >> L$),
$
  va(E)(va(z)) = 1 / (4 uppi epsilon_0 z) (2 L lambda vu(z)) / sqrt(L^2 + 4 z^2) approx 1 / (4 uppi epsilon_0 z) (L lambda vu(z)) / z = 1 / (4 uppi epsilon_0) (L lambda vu(z)) / z^2,
$
which is the precise electric field generated by a stationary source point charge $L lambda$; which validates the intuition that at long distances, the configuration of electric bodies may be approximated with a singular point charge of the total charge of enclosed in the body. This is further validated by the following applications:
#example[
  Find the electric field at $va(z) = z vu(z)$, a distance of $z$ directly above a flat disk $S subset RR^2 times {0}$ centered at $0$ of radius $R$, carrying a uniform time-static surface charge density distribution $sigma$.
] <ex:electric-field-at-point-for-uniformly-charged-disk>
#solution[to @ex:electric-field-at-point-for-uniformly-charged-disk][
  By @eq:electric-field-surface-line,
  $
    va(E)(z vu(z)) = 1 / (4 uppi epsilon_0) integral.double_S (sigma dif S) / norm(z vu(z) - va(r))^3 (z vu(z) - va(r)) = sigma / (4 uppi epsilon_0) integral_0^R integral_(-uppi)^uppi (z vu(z) - va(r)) / (r^2 + z^2)^(3/2) r dtheta dr.
  $
  The lateral components of the above integral vanish by symmetry, whence
  $
    va(E)(z vu(z)) & = (2 uppi sigma z vu(z)) / (4 uppi epsilon_0) integral_0^R (r dr) / (r^2 + z^2)^(3/2) = (sigma z vu(z)) / (4 epsilon_0) integral_(z^2)^(R^2 + z^2) u^(-3/2) dif u \
    &= (sigma z vu(z)) / (2 epsilon_0) [1 / z - (R^2 + z^2)^(-1/2)] = (sigma vu(z)) / (2 epsilon_0) [1 - z / sqrt(R^2 + z^2)]. qedhere
  $
]
When $R -> oo$, $ va(E)(va(z)) -> (sigma vu(z)) / (2 epsilon_0), $
corresponding to the electric field generated by a plane. When $z >> R$,
$
  va(E)(va(z)) &= (sigma vu(z)) / (2 epsilon_0) (sqrt(R^2 / z^2 + 1) - 1) / sqrt(R^2 / z^2 + 1) = (sigma vu(z)) / (2 epsilon_0) (sum_(k = 0)^oo 1 / k! evaluated(dv(, u, k) sqrt(1 + u))_(u = 0) (R^2 / z^2)^k - 1) / sqrt(R^2 / z^2 + 1) \
  & approx (sigma vu(z)) / (2 epsilon_0) [1 / 2 R^2 / z^2 + order(R^2 / z^2)] approx 1 / (4 uppi epsilon_0) (sigma uppi R^2 vu(z)) / z^2,
$
which once again is the electric field due to a single point charge $sigma uppi R^2$ at the origin. Lastly, we consider the case of a time-static surface density distribution on a spherical shell of radius $R > 0$ centered at the origin, which will prove analogous to the case of the gravitational force.
#theorem[Spherical Shell Theorem][
  Let $S$ be the hollow sphere centered at the origin of radius $R$ carrying a uniform surface charge distribution $sigma$. Then the electric field vanishes at all points within the sphere, and attains values equal to if $S$ was a point charge $4 uppi R^2 sigma$ outside the sphere.
] <thm:spherical-shell>
#proof[
  A transformation of $op("SO")(3)$ permits the assumption of the observation point lying on the nonnegative $z$-axis at $va(z) = z vu(z)$. By @eq:electric-field-surface-line, writing
  $
    va(E)(va(z)) &= 1 / (4 uppi epsilon_0) integral.surf_S (sigma dif S) / norm(z vu(z) - R vu(r))^3 (z vu(z) - R vu(r)) \
    &= sigma / (4 uppi epsilon_0) integral_0^(2 uppi) integral_0^uppi (z vu(z) - R[sin theta (cos phi vu(x) + sin phi vu(y)) + cos theta vu(z)]) / sqrt(z^2 + R^2 - 2 z R cos theta)^3 R^2 sin theta dtheta dif phi,
  $
  where the denominator expression was simplified by the Law of Cosines. Recognizing by symmetry that the $x$ and $y$ components vanish,
  $
    va(E)(va(z)) &= (sigma vu(z)) / (4 uppi epsilon_0) integral_0^(2 uppi) integral_0^uppi (z - R cos theta) / sqrt(z^2 + R^2 - 2 z R cos theta)^3 R^2 sin theta dtheta dif phi \
    &= (sigma vu(z) R) / (2 epsilon_0) integral_0^uppi (z - R cos theta) / (z^2 + R^2 - 2 z R cos theta)^(3/2) R sin theta dtheta.
  $
  Substituting $u = z^2 + R^2 - 2 z R cos theta$, we obtain
  $ dif u = 2z R sin theta dtheta, \ z - R cos theta = z - (z^2 + R^2 - u) / (2 z) = (z^2 - R^2 + u) / (2 z), $
  whence
  $
    va(E)(va(z)) & = (sigma vu(z) R) / (8 z^2 epsilon_0) integral_((z-R)^2)^((z+R)^2) (z^2 - R^2 + u) / u^(3/2) dif u \
    &= (sigma vu(z) R) / (8 z^2 epsilon_0) integral_((z-R)^2)^((z+R)^2) [(z^2 - R^2)u^(-3/2) + u^(-1/2)] dif u \
    &= (sigma vu(z) R) / (4 z^2 epsilon_0) evaluated([(u - z^2 + R^2) / sqrt(u)])_((z-R)^2)^((z+R)^2) \
    &= (sigma vu(z) R) / (4 z^2 epsilon_0) [((z+R)^2 - z^2 + R^2) / abs(z + R) - ((z - R)^2 - z^2 + R^2) / abs(z - R)] \
    & = (sigma vu(z) R) / (2 z^2 epsilon_0) cases((z R + R^2) / (z + R) - (R^2 - z R) / (R - z)& quad "if" z < R, (z R + R^2) / (z + R) - (R^2 - z R) / (z - R)& quad "if" z > R) \
    & = (sigma vu(z) R^2) / (z^2 epsilon_0) cases(0 & quad "if" z < R, 1& quad "if" z > R.) qedhere
  $
]
The important difference between this result and the previous two is that in the case of the exterior of the region enclosed by the sphere, the relation is exact rather than an asymptotic equality. (This transpires to be the exact same result for the gravitational force; it is for this exact reason that a spherically symmetric celestial body may be treated, in the domain of orbital mechanics, as a point mass.)
