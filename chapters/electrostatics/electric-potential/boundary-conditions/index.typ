#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Boundary Conditions"),
)

Oftentimes, as it has been observed on earlier occasion, a surface charge distribution will give rise to discontinuities in $va(E)$ when crossing the surface, as with @ex:spherical-shell-electric-potential, wherein we assumed the continuity of $phi$.

Consider such a surface charge distribution $sigma(va(r))$ on a surface $S'$. Fixate $va(r)$, then for a sufficiently small Gaussian pillbox $S$ centered at $va(r)$ with area $A$ and thickness $epsilon -> 0$, the constant normal vector of the bases are approximately the normal vectors of the surface, even more so as $S -> {va(r)}$, wherewith the normal vector of the vertical sides are approximately orthogonal to the surface normals at the respective points.

Where $vu(n)_va(r)$ denotes the surface normal of $S'$ at $va(r)$ and $E^perp (va(r)') = va(E)(va(r)') dot vu(n)_va(r)$, $va(r)$ points to a side of $S'$ comprising a single pillbox base, which we shall identify by $"base"_"above"$ (and in accordance shall we denote by $"base"_"below"$ the other base, where $dif va(S)$ points in the opposite direction of $vu(n)_va(r)$).

Assuming $A -> 0^+$ so that the aforementioned approximations may be more easily identified by equality, Gauss' Law (@eq:gauss-law-integral) yields
$
  Q_"enc" / epsilon_0 = (A sigma) / epsilon_0 = integral.surf_S va(E) dot dif va(S) = (integral.surf_("base"_"above") - integral.surf_("base"_"below")) E^perp dif S = A (E^perp_"above" - E^perp_"below"),
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
        debug-show: true,
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
            // Lightly filled mesh cells establish that S' is a surface rather
            // than the boundary of a solid body.
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

            // Two perpendicular families of mesh curves.
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

            // Emphasized boundary of the surface patch.
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

            // C lies in z = 0. Its midline y = 0 is exactly the z = 0
            // mesh line of S'.
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

            // Upper half-thickness epsilon/2 and tangent length ell.
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
          content("surface-label", anchor: "west", padding: 3pt, math-rect($S'$))
          content("loop-label", anchor: "north-east", padding: 3pt, math-rect($C$))
          content("thickness.50%", anchor: "east", padding: 3pt, math-rect($epsilon / 2$))
          content("length.50%", anchor: "south", padding: 3pt, math-rect($ell$))
        },
      )
    },
    caption: [The rectangular loop with dimensions $epsilon times L$.],
  ) <fig:electric-boundary-condition-rectangular-loop>
]

/* Denote by $va(E)^parallel_"above/below"$ the projection of $va(E)_"above/below"$ onto the tangent plane $T_va(r) S'$.  */Any unit tangent vector $vu(c) in T_va(r) S'$ can be identified with a rectangular loop $C$, with two linear components of sufficiently small length $ell$ and another two of $epsilon -> 0^+$, with vertices
$
  va(r) + ell vu(c) + epsilon / 2 vu(n)_va(r) --> va(r) + epsilon / 2 vu(n)_va(r) --> va(r) - epsilon / 2 vu(n)_va(r) --> va(r) + ell vu(c) - epsilon / 2 vu(n)_va(r),
$
whereby
$
  0 &= lim integral.cont_C va(E) dot dif va(l) = lim (integral_("sides of" epsilon) + integral_(va(r) \ "below")^(va(r) + ell vu(c)) + integral_(va(r) + ell vu(c) \ "above")^(va(r))) va(E) dot dif va(l) \
  &= lim Order(epsilon) + ell va(E)_"below" dot vu(c) - ell va(E)_"above" dot vu(c).
$
In other words, $forall va(T) in T_va(r) S'$,
$
  (va(E)_"above" - va(E)_"below") dot va(T) = 0 ==> va(E)_"above" - va(E)_"below" perp T_va(r) S',
$
entailing the normal component as the sole component in the difference:
$
  Delta va(E) = sigma / epsilon_0 vu(n) ==> Delta grad phi = -sigma / epsilon_0 vu(n) ==> Delta grad phi dot vu(n) = Delta pdv(phi, n) = -sigma / epsilon_0,
$
where $pdv(phi, n)$ is the normal derivative.
