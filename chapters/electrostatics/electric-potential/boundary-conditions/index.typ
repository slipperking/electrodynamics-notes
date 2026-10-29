#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Boundary Conditions"),
)

Oftentimes, as it has been observed on earlier occasion, a surface charge distribution will give rise to discontinuities in $va(E)$ when crossing the surface, as with @ex:spherical-shell-electric-potential, wherein we assumed the continuity of $phi$.

Consider such a surface charge distribution $sigma(va(r))$ on a surface $S$. Fixate $va(r)$, then for a sufficiently small Gaussian pillbox $S'$ centered at $va(r)$ with area $A$ and thickness $epsilon -> 0$, the constant normal vector of the bases are approximately the normal vectors of the surface, even more so as $S' -> {va(r)}$, wherewith the normal vector of the vertical sides are approximately orthogonal to the surface normals at the respective points.

Where $vu(n)_va(r)$ denotes the surface normal of $S$ at $va(r)$ and $E^perp (va(r)') = va(E)(va(r)') dot vu(n)_va(r)$, $va(r)$ points to a side of $S$ comprising a single pillbox base, which we shall identify by $"base"_"above"$ (and in accordance shall we denote by $"base"_"below"$ the other base, where $dif va(S)$ points in the opposite direction of $vu(n)_va(r)$).

Assuming $A -> 0^+$ so that the aforementioned approximations may be more easily identified by equality, Gauss' Law (@eq:gauss-law-integral) yields
$
  Q_"enc" / epsilon_0 = (A sigma) / epsilon_0 = integral.surf_(S') va(E) dot dif va(S) = (integral.surf_("base"_"above") - integral.surf_("base"_"below")) E^perp dif S = A (E^perp_"above" - E^perp_"below"),
$
whence
$
  Delta E^perp = sigma / epsilon_0,
$
where $Delta$ is the difference in traversing from below to above.

In essence, the normal component of the electric field is discontinuous across a surface charge. To extract a more complete picture of $Delta va(E)$ in its entirety, it becomes necessary to examine the tangential components $E^parallel_"above/below"$.

#figure-wrapper[
  #figure(
    {
      set text(size: 1.125em)
      canvas(
        length: 1.5cm,
        // debug-show: true,
        {
          import cetz.draw: *

          let stroke = (paint: black, thickness: 0.93pt)
          let mesh-stroke = (
            paint: black.transparentize(20%),
            thickness: 0.45pt,
          )
          let auxiliary-stroke = (
            paint: black,
            thickness: 0.93pt,
            dash: "dotted",
          )
          let hidden-stroke = (
            paint: black,
            thickness: 0.93pt,
            dash: "dashed",
          )
          let x-min = -3.0
          let x-max = 3.0
          let z-min = -1.65
          let z-max = 1.65
          let x-steps = 10
          let z-steps = 8
          let curve-steps = 36
          let surface-height = z => 0.18 * z * z

          ortho(x: 32deg, y: 48deg, cull-face: none, {
            for i in range(x-steps) {
              for j in range(z-steps) {
                let x0 = x-min + (x-max - x-min) * i / x-steps
                let x1 = x-min + (x-max - x-min) * (i + 1) / x-steps
                let z0 = z-min + (z-max - z-min) * j / z-steps
                let z1 = z-min + (z-max - z-min) * (j + 1) / z-steps
                line(
                  (x0, surface-height(z0), z0),
                  (x1, surface-height(z0), z0),
                  (x1, surface-height(z1), z1),
                  (x0, surface-height(z1), z1),
                  close: true,
                  fill: black.transparentize(92%),
                  stroke: none,
                )
              }
            }

            for j in range(z-steps + 1) {
              let z = z-min + (z-max - z-min) * j / z-steps
              line(
                (x-min, surface-height(z), z),
                (x-max, surface-height(z), z),
                stroke: mesh-stroke,
              )
            }
            for i in range(x-steps + 1) {
              let x = x-min + (x-max - x-min) * i / x-steps
              let curve = range(curve-steps + 1).map(j => {
                let z = z-min + (z-max - z-min) * j / curve-steps
                (x, surface-height(z), z)
              })
              line(..curve, stroke: mesh-stroke)
            }

            line(
              (x-min, surface-height(z-min), z-min),
              (x-max, surface-height(z-min), z-min),
              stroke: stroke,
            )
            line(
              (x-min, surface-height(z-max), z-max),
              (x-max, surface-height(z-max), z-max),
              stroke: stroke,
            )
            for x in (x-min, x-max) {
              let boundary = range(curve-steps + 1).map(j => {
                let z = z-min + (z-max - z-min) * j / curve-steps
                (x, surface-height(z), z)
              })
              line(..boundary, stroke: stroke)
            }

            let loop-left = -0.72
            let loop-right = 0.72
            let half-height = 0.55
            let dimension-left = loop-left - 0.2
            let length-y = half-height + 0.2
            let tick-half-length = 0.10

            line(
              (loop-left, half-height, 0),
              (loop-right, half-height, 0),
              name: "loop-top",
              stroke: stroke,
            )
            line((loop-left, half-height, 0), (loop-left, 0, 0), stroke: stroke)
            line((loop-right, half-height, 0), (loop-right, 0, 0), stroke: stroke)
            line(
              (loop-left, 0, 0),
              (loop-right, 0, 0),
              name: "loop-midline",
              stroke: stroke,
            )
            anchor("midline-left", (loop-left, 0, 0))
            anchor("midline-right", (loop-right, 0, 0))
            line((loop-left, 0, 0), (loop-left, -half-height, 0), stroke: hidden-stroke)
            line((loop-right, 0, 0), (loop-right, -half-height, 0), stroke: hidden-stroke)
            line(
              (loop-left, -half-height, 0),
              (loop-right, -half-height, 0),
              name: "loop-bottom",
              stroke: hidden-stroke,
            )

            mark(
              (0.42, half-height, 0),
              (0.04, half-height, 0),
              ">>",
              fill: black,
              stroke: none,
              scale: 1.12,
            )
            mark(
              (loop-left, 0.38, 0),
              (loop-left, 0.12, 0),
              ">>",
              fill: black,
              stroke: none,
              scale: 1.12,
            )
            mark(
              (-0.30, -half-height, 0),
              (0.08, -half-height, 0),
              ">>",
              fill: black,
              stroke: none,
              scale: 1.12,
            )
            mark(
              (loop-right, -0.38, 0),
              (loop-right, -0.12, 0),
              ">>",
              fill: black,
              stroke: none,
              scale: 1.12,
            )

            line(
              (loop-left, half-height, 0),
              (dimension-left, half-height, 0),
              stroke: auxiliary-stroke,
            )
            line(
              (loop-left, 0, 0),
              (dimension-left, 0, 0),
              stroke: auxiliary-stroke,
            )
            line(
              (dimension-left, half-height, 0),
              (dimension-left, 0, 0),
              name: "thickness",
              stroke: stroke,
            )
            for y in (0, half-height) {
              line(
                (dimension-left - tick-half-length, y, 0),
                (dimension-left + tick-half-length, y, 0),
                stroke: stroke,
              )
            }
            line(
              (loop-left, half-height, 0),
              (loop-left, length-y, 0),
              stroke: auxiliary-stroke,
            )
            line(
              (loop-right, half-height, 0),
              (loop-right, length-y, 0),
              stroke: auxiliary-stroke,
            )
            line(
              (loop-left, length-y, 0),
              (loop-right, length-y, 0),
              name: "length",
              stroke: stroke,
            )
            for x in (loop-left, loop-right) {
              line(
                (x, length-y - tick-half-length, 0),
                (x, length-y + tick-half-length, 0),
                stroke: stroke,
              )
            }

            anchor("surface-label", (2.75, surface-height(1.35), 1.35))
            anchor("loop-label", (loop-right, half-height, 0))
          })

          circle("midline-left", radius: 2.85pt, fill: black, stroke: none)
          circle("midline-right", radius: 2.85pt, fill: black, stroke: none)
          content("surface-label", anchor: "west", padding: 3pt, math-rect($S$))
          content("loop-label", anchor: "north-east", padding: 3pt, math-rect($C$))
          content("thickness.50%", anchor: "east", padding: 3pt, math-rect($epsilon / 2$))
          content("length.50%", anchor: "south", padding: 3pt, math-rect($ell$))
        },
      )
    },
    caption: [The rectangular loop with dimensions $epsilon times L$.],
  ) <fig:electric-boundary-condition-rectangular-loop>
]

/* Denote by $va(E)^parallel_"above/below"$ the projection of $va(E)_"above/below"$ onto the tangent plane $T_va(r) S$.  */Any unit tangent vector $vu(c) in T_va(r) S$ can be identified with a rectangular loop $C$, with two linear components of sufficiently small length $ell$ and another two of $epsilon -> 0^+$, with vertices
$
  va(r) + ell vu(c) + epsilon / 2 vu(n)_va(r) --> va(r) + epsilon / 2 vu(n)_va(r) --> va(r) - epsilon / 2 vu(n)_va(r) --> va(r) + ell vu(c) - epsilon / 2 vu(n)_va(r),
$
whereby
$
  0 &= lim integral.cont_C va(E) dot dif va(l) = lim (integral_("sides of" epsilon) + integral_(va(r) \ "below")^(va(r) + ell vu(c)) + integral_(va(r) + ell vu(c) \ "above")^(va(r))) va(E) dot dif va(l) \
  &= lim Order(epsilon) + ell va(E)_"below" dot vu(c) - ell va(E)_"above" dot vu(c).
$
In other words, $forall va(T) in T_va(r) S$,
$
  (va(E)_"above" - va(E)_"below") dot va(T) = 0 ==> va(E)_"above" - va(E)_"below" perp T_va(r) S,
$
entailing the normal component as the sole component in the difference:
$
  Delta va(E) = sigma / epsilon_0 vu(n) ==> Delta grad phi = -sigma / epsilon_0 vu(n) ==> Delta grad phi dot vu(n) = Delta pdv(phi, n) = -sigma / epsilon_0,
$
where $pdv(phi, n)$ is the normal derivative.
/*

Suppose there were a surface $S$ carrying a surface charge density distribution $sigma(va(r))$  */

Permit the consideration of the following problem, which will also give rise to an alternate method to obtain the preceding result:

For a given $va(r)' in S$, what would be the electrostatic force-per-unit-area experienced thereat by the rest of the distribution?

Allow us to draw a sufficiently small disk $D subset.eq S$ on the surface, centered at $va(r)'$ of radius $epsilon > 0$, such that we may assume the normal vector is constant everywhere. Where the "above"-pointing normal vector of $D$ at $va(r)'$ is $vu(n)$, the electric field at $va(r)_"above" = va(r)' + delta vu(n)$ is given by
$
  va(E)(va(r)_"above") = va(E)_(S without D)(va(r)_"above") + va(E)_D (va(r)_"above"),
$
likewise that which lies at $va(r)_"below" = va(r)' - delta vu(n)$ is given by
$
  va(E)(va(r)_"below") = va(E)_(S without D)(va(r)_"below") + va(E)_D (va(r)_"below"),
$
The first term of both $va(E)_(S without D)(va(r))$ has the explicit representation
$
  va(E)_(S without D)(va(r)) = 1 / (4 uppi epsilon_0) integral.double_(S without D) (sigma(va(r)'')) / norm(va(r) - va(r)'')^3 (va(r) - va(r)'') dif S'',
$
which does not enclose the singularity at $va(r)'' = va(r)$. Therefore this term is consistent across both the above and below representation as $delta -> 0^+$.

Assuming $D$ is flat, wherewith $epsilon$ is sufficiently small, we may assume that $sigma$ is approximately uniform in $D$, whence @ex:electric-field-at-point-for-uniformly-charged-disk gives rise to the following representation for the disk terms:
$
  va(E)_D (va(r)_"above") = lim_(delta -> 0^+)(sigma(va(r)') vu(n)) / (2 epsilon_0) [1 - delta / sqrt(epsilon^2 + delta^2)] = (sigma(va(r)') vu(n)) / (2 epsilon_0)\
  va(E)_D (va(r)_"below") = -lim_(delta -> 0^+)(sigma(va(r)') vu(n)) / (2 epsilon_0) [1 - delta / sqrt(epsilon^2 + delta^2)] = -(sigma(va(r)') vu(n)) / (2 epsilon_0).
$
Therefore,
$
  va(E)(va(r)_"above") = va(E)_(S without D)(va(r)) + (sigma(va(r)') vu(n)) / (2 epsilon_0),\
  va(E)(va(r)_"below") = va(E)_(S without D)(va(r)) - (sigma(va(r)') vu(n)) / (2 epsilon_0).
$
The force experienced by $D$, subject to the electric field of $S without D$, depends solely on the term $va(E)_(S without D) (va(r))$, which can be calculated by combining the two above equations, giving
$
  va(E)_(S without D)(va(r)) = 1/2 [va(E)(va(r)_"above") + va(E)(va(r)_"below")],
$
whence the force-pre-unit-area is
$
  va(f) = lim_(D -> {va(r)'}) 1 / (uppi epsilon^2) integral.double_D sigma(va(r)'') va(E)_(S without D)(va(r)'') dif S'' &= lim_(D -> {va(r)'}) 1/2 [va(E)(va(r)_"above") + va(E)(va(r)_"below")] [#[average of $sigma$ on $D$]] \
  &= sigma(va(r)')1/2 [va(E)(va(r)_"above") + va(E)(va(r)_"below")].
$
