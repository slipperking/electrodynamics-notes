#import "/lib.typ": *
#import "/build/visual-output/electric-dipole/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("The Electric Dipole"),
  children: {
    include "singularity-at-origin/index.typ"
    include "dipole-force-and-torque/index.typ"
    include "dipole-potential-energy/index.typ"
    include "dipole-layers/index.typ"
  },
)

Recall the electric dipole moment
#thm-state.thm-restate("def:electric-dipole-moment")
in the multipole expansion as provided in @eq:electric-multipole-expansion. It can be thought roughly related to a "center of mass" $overline(va(r))$ by $overline(va(r)) = va(p) / Q$. Fittingly, the electric dipole moment is generally nonzero for uneven charge distributions. Where $Q = 0$, we aver that the dipole moment is independent of the chosen $va(r)_0$, the verification whereof can be determined by choice of two differing origin points $va(r)_0$ and $va(r)'_0$:
#theorem[
  A given localized volume charge density distribution $rho$ whose total charge is $0$ yields the same dipole moment across all possible expansion points.
] <thm:electric-dipole-moment-exp-point-invariance>
#proof[
  Consider respectively the moments $va(p)_1$, $va(p)_2$ about fixed points $va(r)_1$, $va(r)_2$. Observing that
  $
    0 = (va(r)_1 - va(r)_2) integral.triple rho(va(r)) dif^3 r = integral.triple rho(va(r)) (va(r)_1 - va(r)_2) dif^3 r,
  $
  it follows that
  $
    va(p)_1 &= integral.triple rho(va(r)) (va(r) - va(r)_1) dif^3 r = integral.triple rho(va(r)) (va(r) - va(r)_1 + va(r)_1 - va(r)_2) dif^3 r \
    &=integral.triple rho(va(r)) (va(r) - va(r)_2) dif^3 r = va(p)_2. qedhere
  $
]

The corresponding dipole term in $phi$, defined to be the _electric dipole potential_ for $s != 0$, is given by
$
  phi_1(va(r)) = 1 / (4 uppi epsilon_0) (va(p) dot va(s)) / s^3.
$ <eq:electric-dipole-potential>
From the moment we obtain the complete typification of the _electric dipole field_
$
  va(E)_1(va(r)) & = - 1 / (4 uppi epsilon_0) grad_((va(s))) (va(p) dot va(s)) / s^3 = - 1 / (4 uppi epsilon_0) [(va(p) dot grad) va(s) / s^3 + va(p) times (curl va(s) / s^3)] #tag[($s != 0$)]\
  &=- 1 / (4 uppi epsilon_0) [1 / s^3 (va(p) dot grad) va(s) + va(s) (va(p) dot grad) 1 / s^3 - va(p) times (curl grad 1 / s)] \
  &=- 1 / (4 uppi epsilon_0) [1 / s^3 (va(p) dot grad) va(s) - va(s) (va(p) dot (3 va(s)) / s^5)] = - 1 / (4 uppi epsilon_0) [1 / s^3 p_i partial_i s_j vu(e)_j - va(s) (va(p) dot (3 va(s)) / s^5)] \
  &= - 1 / (4 uppi epsilon_0) [1 / s^3 p_i delta_(i j) vu(e)_j - va(s) (va(p) dot (3 va(s)) / s^5)]= 1 / (4 uppi epsilon_0) (3 vu(s) (va(p) dot vu(s)) - va(p)) / s^3
$ <eq:electric-dipole-field>
away from the origin.

Consider the choice of $rho$, $va(r)_0$, and the subsequent $phi$ and other variables such that the electric potential multipole expansion comprises no monopole term, whereupon $Q$, the enclosed charge, is $0$. It transpires that in a multitude of practical cases, such as in atoms, water, etc., $Q = 0$, wherein the leading term is the dipole term at far ($s >> R$), whence with $s >> R$, $phi(va(r)) = phi_1 (va(r))$ (asymptotically).

Appealing in @eq:electric-dipole-field to a spherical coordinate system $(s, theta, phi.alt)$ with a polar axis $vu(p)$, denoting by $theta$ the polar angle between $vu(s)$ and $vu(p)$ and by $phi.alt$ an angle of rotation about $va(p)$ (with a fixed reference point), it follows thence that
$
  va(E)_1 (va(r)) /* = 1 / (4 uppi epsilon_0) (3 vu(s) p cos theta - va(p)) / s^3  */= 1 / (4 uppi epsilon_0) (3 vu(s) p cos theta - p[vu(s) cos theta - vu(theta) sin theta]) / s^3 = p / (4 uppi epsilon_0 s^3) [2 vu(s) cos theta + vu(theta) sin theta],
$
is azimuthally symmetric---if $phi.alt$ were to change by some $delta phi.alt$, such a variation would result in a rotation of $vu(r)$ and $vu(theta)$ by $delta phi.alt$ about the $vu(p)$-axis; whereby the previous equation entails a rotation of $va(E)$ by $delta phi.alt$ about the axis.

The historical motivation for the naming of "dipole" comes from the following geometric construction, due to Maxwell: consider a configuration wherein two point charges $plus.minus q / d$ respectively at $va(r)_0 plus.minus d/2 vu(c)$ are held within a sphere centered at $va(r)_0$ of radius $R$. With $d -> 0^+$, the electric dipole moment is
$
  va(p) &= lim_(d -> 0^+) integral.triple rho va(s) dif^3 r = lim_(d -> 0^+) integral.triple sum_(+, -) plus.minus q / d delta(va(r) - va(r)_0 minus.plus d / 2 vu(c)) va(s) dif^3 r \
  &=lim_(d -> 0^+) sum_(+, -) plus.minus q / d (plus.minus d/2 vu(c)) = q vu(c),
$
wherewith the resulting electric potential is
$
  phi(va(r)) &= lim_(d -> 0^+) 1 / (4 uppi epsilon_0) [hfrc(q / d) / norm(va(r) - va(r)_0 - d / 2 vu(c)) - hfrc(q / d) / norm(va(r) - va(r)_0 + d / 2 vu(c))] \
  &= lim_(d -> 0^+) hfrc(q / d) / (4 uppi epsilon_0) (ee^(- d / 2 vu(c) dot grad) - ee^(d / 2 vu(c) dot grad)) 1 / s \
  &= -lim_(d -> 0^+) hfrc(q / d) / (4 uppi epsilon_0) 2 sinh(d / 2 vu(c) dot grad) 1 / s \
  &= -lim_(d -> 0^+) hfrc(q / d) / (4 uppi epsilon_0) [d vu(c) dot grad + d^3 Order(vu(c) dot grad)^3] 1 / s \
  &= -q / (4 uppi epsilon_0) vu(c) dot grad 1 / s = -1 / (4 uppi epsilon_0) q vu(c) dot grad 1 / s = -1 / (4 uppi epsilon_0) va(p) dot grad 1 / s = phi_1 (va(r)),
$ <eq:electric-point-dipole-potential>
whence Poisson's Equation (@eq:poisson) gives
$
  rho(va(r)) &= -epsilon_0 laplacian phi(va(r)) = 1 / (4 uppi) q laplacian [vu(c) dot grad 1 / s] = 1 / (4 uppi) q partial_i partial_i hat(c)_j partial_j 1 / s \
  & = 1 / (4 uppi) q hat(c)_j partial_j partial_i partial_i 1 / s = 1 / (4 uppi) q vu(c) dot grad laplacian 1 / s = -va(p) dot grad delta(va(r) - va(r)_0),
$ <eq:point-dipole-charge-density>
whereto we refer as _the point dipole charge density_ distribution.
#definition[The Point Dipole][
  The electrostatic _point dipole_ at $va(r)_0$ is the description imputed upon the charge distribution
  $
    rho(va(r)) = -va(p) dot grad delta(va(r) - va(r)_0),
  $
  for any nonzero vector $va(p)$, the electric dipole moment. The multipole expansion thereof about $va(r)_0$ comprises but a single dipole term.
] <def:electric-point-dipole>
#figure-wrapper[
  #figure(
    {
      set text(size: 0.95em)
      canvas(
        length: 1.44cm,
        debug-show: true,
        {
          import cetz.draw: *

          let axis-stroke = (
            paint: black,
            thickness: 0.4pt,
          )
          let field-stroke = (paint: black, thickness: 0.62pt)
          let vector-stroke = (paint: black, thickness: 0.8pt)
          let point-x = -2.75
          let charge-x = 2.75
          let axis-half-width = 2.4
          let axis-bottom = -1.65
          let axis-top = 1.75
          let charge-half-gap = 0.42

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

          for center in (point-x, charge-x) {
            line(
              (center - axis-half-width, 0),
              (center + axis-half-width, 0),
              stroke: axis-stroke,
              mark: (end: ">>", fill: black),
            )
            line(
              (center, axis-bottom),
              (center, axis-top),
              stroke: axis-stroke,
              mark: (end: ">>", fill: black),
            )
          }

          draw-generated-field(
            point-dipole-curves,
            point-dipole-arrows,
            point-x,
          )
          draw-generated-field(
            two-charge-dipole-curves,
            two-charge-dipole-arrows,
            charge-x,
          )

          line(
            (point-x, 0),
            (point-x, 0.92),
            name: "point-moment",
            stroke: vector-stroke,
            mark: (end: ">>", fill: black),
          )
          circle((point-x, 0), radius: 3.4pt, fill: white, stroke: field-stroke)

          line(
            (charge-x, 0),
            (charge-x, 0.92),
            name: "charge-moment",
            stroke: vector-stroke,
            mark: (end: ">>", fill: black),
          )
          circle(
            (charge-x, charge-half-gap),
            radius: 4.2pt,
            fill: white,
            stroke: field-stroke,
          )
          circle(
            (charge-x, -charge-half-gap),
            radius: 4.2pt,
            fill: white,
            stroke: field-stroke,
          )

          content(
            (point-x + axis-half-width, 0),
            anchor: "west",
            padding: 2pt,
            math-rect($x$),
          )
          content(
            (point-x, axis-top),
            anchor: "south",
            padding: 2pt,
            math-rect($z$),
          )
          content(
            (charge-x + axis-half-width, 0),
            anchor: "west",
            padding: 2pt,
            math-rect($x$),
          )
          content(
            (charge-x, axis-top),
            anchor: "south",
            padding: 2pt,
            math-rect($z$),
          )
          content(
            (point-x, 0.92),
            anchor: "south",
            padding: 5pt,
            math-rect($va(p)$),
          )
          content(
            (charge-x, 0.92),
            anchor: "south",
            padding: 5pt,
            math-rect($va(p)$),
          )
          content(
            (charge-x, charge-half-gap),
            anchor: "south",
            padding: 5pt,
            math-rect($+q$),
          )
          content(
            (charge-x, -charge-half-gap),
            anchor: "north",
            padding: 5pt,
            math-rect($-q$),
          )
          content(
            (point-x, axis-bottom - 0.14),
            anchor: "north",
            [Point dipole],
          )
          content(
            (charge-x, axis-bottom - 0.14),
            anchor: "north",
            [Two-charge dipole],
          )
        },
      )
    },
    caption: [Field-lines of a point dipole and a dipole formed by two charges with a fixed dipole moment in the $+z$ direction.],
  ) <fig:point-and-two-charge-dipoles>
]
It is incumbent to interpret @eq:point-dipole-charge-density in the distributional sense. Where the pure monopole is describable by a point charge, the pure dipole is likewise completely ascribable by the point dipole. The current knowledge of physicists accord to the nonexistence of naturally-occuring point dipoles, which is not to say that @eq:point-dipole-charge-density holds no practical utility; it often transpires as a utile approximation whensoever the analogous separation $d$ is relatively insignificant to the separation distance $s >> d$.
