#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("Boundary Conditions"),
)

Oftentimes, as it has been observed on earlier occasion, a surface charge distribution will give rise to discontinuities in $va(E)$ when crossing the surface, as with @ex:spherical-shell-electric-potential, wherein we assumed the continuity of $V$.

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
      set text(size: 0.75em)
      canvas(
        debug-show: true,
        {
          import cetz.draw: *

          let stroke = (paint: black, thickness: 0.62pt)
          let mesh-stroke = (
            paint: black.transparentize(40%),
            thickness: 0.42pt,
          )
          let auxiliary-stroke = (
            paint: black,
            thickness: 0.62pt,
            dash: "dotted",
          )
          let hidden-stroke = (
            paint: black,
            thickness: 0.62pt,
            dash: "dashed",
          )
          let length-mark = (
            start: (pos: 5%, symbol: "|", inset: 0%),
            end: (pos: 5%, symbol: "|", inset: 0%),
          )

          let x-min = -3.0
          let x-max = 3.0
          let z-min = -1.65
          let z-max = 1.65
          let x-steps = 8
          let z-steps = 6
          let curve-steps = 36
          let surface-height = z => 0.18 * z * z

          ortho(x: 32deg, y: 22deg, cull-face: none, {
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
            let dimension-left = loop-left - 0.38
            let length-y = -half-height - 0.28

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
              scale: 0.52,
            )
            mark(
              (-0.30, -half-height, 0),
              (0.08, -half-height, 0),
              ">>",
              fill: black,
              stroke: none,
              scale: 0.52,
            )

            // Thickness epsilon and tangent length ell.
            line(
              (loop-left, half-height, 0),
              (dimension-left, half-height, 0),
              stroke: auxiliary-stroke,
            )
            line(
              (loop-left, -half-height, 0),
              (dimension-left, -half-height, 0),
              stroke: auxiliary-stroke,
            )
            line(
              (dimension-left, half-height, 0),
              (dimension-left, -half-height, 0),
              name: "thickness",
              stroke: stroke,
              mark: length-mark,
            )
            line(
              (loop-left, -half-height, 0),
              (loop-left, length-y, 0),
              stroke: auxiliary-stroke,
            )
            line(
              (loop-right, -half-height, 0),
              (loop-right, length-y, 0),
              stroke: auxiliary-stroke,
            )
            line(
              (loop-left, length-y, 0),
              (loop-right, length-y, 0),
              name: "length",
              stroke: stroke,
              mark: length-mark,
            )

            // Tangential fields immediately above and below the surface.
            line(
              (2.30, 0.72, 0),
              (1.30, 0.72, 0),
              name: "field-above",
              stroke: stroke,
              mark: (end: ">>", fill: black),
            )
            line(
              (2.55, -0.62, 0),
              (1.55, -0.62, 0),
              name: "field-below",
              stroke: stroke,
              mark: (end: ">>", fill: black),
            )

            anchor("sigma-anchor", (-2.35, surface-height(-0.75), -0.75))
            anchor("surface-label", (2.75, surface-height(1.35), 1.35))
            anchor("loop-label", (loop-left, half-height, 0))
          })

          content("sigma-anchor", anchor: "east", padding: 2pt, math-rect($sigma$))
          content("surface-label", anchor: "west", padding: 2pt, math-rect($S'$))
          content("loop-label", anchor: "south-east", padding: 2pt, math-rect($C$))
          content("thickness.50%", anchor: "east", padding: 2pt, math-rect($epsilon$))
          content("length.50%", anchor: "north", padding: 2pt, math-rect($ell$))
          content("field-above.start", anchor: "south", padding: 2pt, math-rect($va(E)_"above"^parallel$))
          content("field-below.start", anchor: "north", padding: 2pt, math-rect($va(E)_"below"^parallel$))
        },
      )
    },
    caption: [],
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
  Delta va(E) = sigma / epsilon_0 vu(n) ==> Delta grad V = -sigma / epsilon_0 vu(n) ==> Delta grad V dot vu(n) = Delta pdv(V, n) = -sigma / epsilon_0,
$
where $pdv(V, n)$ is the normal derivative.
