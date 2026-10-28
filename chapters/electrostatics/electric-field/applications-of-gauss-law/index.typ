#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs[Applications of Gauss' Law],
)
We will briefly pause on our theoretical developments in favor of demonstrating the vast utility given by Gauss' Law. Of greatest immediacy will be the simplification of the proof of the spherical shell theorem.
#proof[of @thm:spherical-shell][
  Fix a point $va(r)$ in the exterior of $S$, and likewise a larger concentric sphere $S'$ of radius $r = norm(va(r)) > R$.

  We aver that $va(E)(va(r))$ lies in the same direction as $vu(r)$ by spherical symmetry, whence it follows that the outward-pointing normal $vu(n)$ (with respect to $S'$) and $va(E)(va(r))$ are multiples of each other. Hence, in this exterior case,
  $
    integral.surf_(S') va(E)(va(r)') dot dif va(S)' = integral.surf_(S') E dif S'.
  $
  By invariance under orthogonal transformations, $E(va(r)')$ (the electric field strength) is constant for $va(r)' in S$, giving from Gauss' Law (cf. @eq:gauss-law-integral),
  $
    Q_"enc" / epsilon_0 = E 4 uppi r^2 = (sigma 4 uppi R^2) / epsilon_0 ==> E = 1 / (4 uppi epsilon_0) (sigma 4 uppi R^2) / r^2,
  $
  which is consistent with our finding in the previous proof. In the case in which $S'$ is of radius $r < R$, $S'$ encloses a total charge of $0$ since all distributed charges lie on the surface the exterior sphere $S$. Therefore, Gauss' Law once more gives
  $
    Q_"enc" / epsilon_0 = 0 = integral.surf_(S') va(E)(va(r)') dot dif va(S)' = E(va(r)) 4 uppi r^2 ==> E(va(r)) = 0. qedhere
  $
]
Such is the utility herein of an auxiliary surface as $S'$, that it has received its own name---a "Gaussian surface"---with the sufficient symmetries that allow for the simplification of many problems as above. Three common symmetries can be used to simplify the selection of a Gaussian surface:
- A spherical surface concentric with a uniformly charged sphere and passing through the evaluation point.
- A cylindrical surface coaxial with a uniformly charged cylinder and passing through the evaluation point.
- A pillbox-shaped surface centered on an infinite charged plane, with its faces parallel to the plane and equidistant from it.
The first usage is readily demonstrated by the proof above. We hence provide the examples in which electric field can be determined through the latter two.
#figure-wrapper[
  #figure(
    {
      set text(size: 0.75em)
      canvas(
        // debug-show: true,
        {
          import cetz.draw: *

          let body-stroke = (paint: black, thickness: 0.62pt)
          let body-extension-stroke = (
            paint: black,
            thickness: 0.62pt,
            dash: "dotted",
          )
          let cross-section-stroke = (paint: black, thickness: 0.62pt)
          let gaussian-stroke = (
            paint: black,
            thickness: 0.62pt,
            dash: "dashed",
          )
          let axis-stroke = (paint: black, thickness: 0.62pt)
          let guide-stroke = (paint: black, thickness: 0.62pt)
          let vector-stroke = (paint: black, thickness: 0.62pt)
          let length-mark = (
            start: (pos: 5%, symbol: "|", inset: 0%),
            end: (pos: 5%, symbol: "|", inset: 0%),
          )
          let full-length-mark = (
            start: (pos: 0%, symbol: "|", inset: 0%),
            end: (pos: 0%, symbol: "|", inset: 0%),
          )

          let ellipse-points(cx, cy, rx, ry, start: 0deg, stop: 360deg, steps: 48) = {
            range(steps + 1).map(i => {
              let angle = start + (stop - start) * i / steps
              (
                cx + rx * calc.cos(angle),
                cy + ry * calc.sin(angle),
              )
            })
          }
          // Primary geometry; subsequent construction is anchored to these paths.
          let base-left = -2.55
          let base-right = 2.55
          let body-radius = 0.72
          let gaussian-radius = 1.45
          line((base-left, 0), (base-right, 0), name: "axis-core", stroke: axis-stroke)
          line((-4.0, 0), "axis-core.start", name: "axis-left", stroke: axis-stroke)
          line("axis-core.end", (4.25, 0), name: "axis-right", stroke: axis-stroke)
          line(
            (base-left, body-radius),
            (base-right, body-radius),
            name: "body-top",
            stroke: body-stroke,
          )
          line(
            (base-left, -body-radius),
            (base-right, -body-radius),
            name: "body-bottom",
            stroke: body-stroke,
          )
          line((-4.0, body-radius), "body-top.start", stroke: body-extension-stroke)
          line("body-top.end", (4.0, body-radius), stroke: body-extension-stroke)
          line((-4.0, -body-radius), "body-bottom.start", stroke: body-extension-stroke)
          line("body-bottom.end", (4.0, -body-radius), stroke: body-extension-stroke)
          line(
            (base-left, gaussian-radius),
            (base-right, gaussian-radius),
            name: "gaussian-top",
            stroke: gaussian-stroke,
          )
          line(
            (base-left, -gaussian-radius),
            (base-right, -gaussian-radius),
            name: "gaussian-bottom",
            stroke: gaussian-stroke,
          )
          line(
            ..ellipse-points(base-left, 0, 0.34, gaussian-radius),
            name: "gaussian-left-base",
            stroke: gaussian-stroke,
          )
          line(
            ..ellipse-points(base-right, 0, 0.34, gaussian-radius),
            name: "gaussian-right-base",
            stroke: gaussian-stroke,
          )
          for (x, name) in ((base-left, "body-left-base"), (base-right, "body-right-base")) {
            line(
              ..ellipse-points(x, 0, 0.12, body-radius),
              name: name,
              stroke: cross-section-stroke,
            )
          }

          // Guides inherit their feet and endpoints from the named cylinder edges.
          line(
            "axis-core.25%",
            "body-top.25%",
            name: "body-radius",
            stroke: guide-stroke,
            mark: length-mark,
          )
          line(
            "axis-core.65%",
            "gaussian-top.65%",
            name: "gaussian-radius",
            stroke: guide-stroke,
            mark: length-mark,
          )
          circle("gaussian-radius.end", radius: 1.9pt, fill: black, stroke: none)
          line(
            "gaussian-radius.end",
            (rel: "gaussian-radius.end", to: (0, 0.85)),
            name: "field-at-r",
            stroke: vector-stroke,
            mark: (end: ">>", fill: black),
          )

          // Overall Gaussian length.
          line(
            (rel: "gaussian-bottom.start", to: (0, -0.37)),
            (rel: "gaussian-bottom.end", to: (0, -0.37)),
            name: "length",
            stroke: guide-stroke,
            mark: full-length-mark,
          )

          content("axis-right.end", anchor: "west", padding: 2pt, math-rect($x$))
          content("body-radius.48%", anchor: "east", padding: 2pt, math-rect($R$))
          content("gaussian-radius.58%", anchor: "west", padding: 2pt, math-rect($s$))
          content("gaussian-radius.end", anchor: "south-west", padding: 3pt, math-rect($va(r)$))
          content("field-at-r.end", anchor: "south", padding: 2pt, math-rect($va(E)(va(r))$))
          content("gaussian-right-base.12%", anchor: "west", padding: 2pt, math-rect($S$))
          content("length.50%", anchor: "north", padding: 2pt, math-rect($2L$))
        },
      )
    },
    caption: [A coaxial Gaussian cylinder $S$ about the uniformly charged cylinder.],
  ) <fig:gaussian-cylinder>
]
#example[
  A solid cylinder of infinite length and radius $R$ axially centered at the $x$-axis is uniformly charged with a volume density $rho$. Find the electric field at some arbitrary point $va(r)$.
] <ex:gaussian-surface-cylinder>
#solution[to @ex:gaussian-surface-cylinder][
  Denote by $S$ the coaxial cylinder of length $2L$ centered at $va(x) = op("proj")_vu(x) va(r)$ and disposed with axis parallel to the $x$-axis to be the Gaussian surface. By Gauss' Law,
  $
    Q_"enc" / epsilon_0 = integral.surf_S va(E)(va(r)') dot dif va(S)' = (integral.double_"lateral" + integral.double_"base1" + integral.double_"base2") va(E)(va(r)') dot dif va(S)'.
  $
  The symmetry of the cylinder entails that the electric field at any point in space possesses a vanishing $x$-component, whence the integrals over the bases vanish from the observation that $va(E)(va(r)') perp dif va(S)'$ thereon. There remains, therefore, only the contribution of the lateral surface; wherein the outward normal is parallel to the electric field, once again by symmetry, giving that
  $
    Q_"enc" / epsilon_0 = integral.double_"lateral" E dif S' = E(va(r)) 4 uppi s L,
  $
  where $va(s) = s vu(s)$ is the radial vector from the $x$-axis to $va(r)$. It follows that
  $
    Q_"enc" / epsilon_0 = (2L uppi min{s, R}^2 rho) / epsilon_0 = E(va(r)) 4 uppi s L ==> va(E) (va(r)) = (min{s, R}^2 rho vu(s)) / (2 epsilon_0 s). qedhere
  $
]
#figure-wrapper[
  #figure(
    {
      set text(size: 0.75em)
      canvas(
        // debug-show: true,
        {
          import cetz.draw: *

          let plane-stroke = (
            paint: black,
            thickness: 0.62pt,
            dash: "dotted",
          )
          let guide-stroke = (paint: black, thickness: 0.62pt)
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
          let vector-stroke = (paint: black, thickness: 0.62pt)
          let length-mark = (
            start: (pos: 5%, symbol: "|", inset: 0%),
            end: (pos: 5%, symbol: "|", inset: 0%),
          )
          let half-side = 1.10
          let half-height = 0.48
          let plane-half-x = 3.75
          let plane-half-y = 2.10
          let dimension-offset = 0.52
          let field-length = 1.28
          let face(elevation) = (
            (-half-side, elevation, -half-side),
            (half-side, elevation, -half-side),
            (half-side, elevation, half-side),
            (-half-side, elevation, half-side),
          )

          ortho(x: 30deg, y: 40deg, cull-face: none, {
            let plane = (
              (-plane-half-x, 0, -plane-half-y),
              (plane-half-x, 0, -plane-half-y),
              (plane-half-x, 0, plane-half-y),
              (-plane-half-x, 0, plane-half-y),
            )
            line(
              ..plane,
              close: true,
              name: "charged-plane",
              fill: black.transparentize(85%),
              stroke: plane-stroke,
            )
            line(plane.at(3), plane.at(2), name: "plane-back-edge", stroke: none)
            let middle = face(0)
            let top = face(half-height)
            let bottom = face(-half-height)
            anchor("plane-center", (0, 0, 0))
            anchor("top-center", (0, half-height, 0))
            anchor("bottom-center", (0, -half-height, 0))
            anchor("field-up-tip", (0, half-height + field-length, 0))
            anchor("field-down-tip", (0, -half-height - field-length, 0))
            for i in range(4) {
              anchor("middle-" + str(i), middle.at(i))
              anchor("top-" + str(i), top.at(i))
              anchor("bottom-" + str(i), bottom.at(i))
            }

            anchor(
              "dimension-middle",
              (half-side + dimension-offset, 0, -half-side),
            )
            anchor(
              "dimension-top",
              (half-side + dimension-offset, half-height, -half-side),
            )
            anchor(
              "dimension-bottom",
              (half-side + dimension-offset, -half-height, -half-side),
            )
            line(top.at(1), "dimension-top", name: "top-extension", stroke: auxiliary-stroke)
            line(middle.at(1), "dimension-middle", name: "middle-extension", stroke: auxiliary-stroke)
            line(bottom.at(1), "dimension-bottom", name: "bottom-extension", stroke: auxiliary-stroke)
            line(
              "dimension-middle",
              "dimension-top",
              name: "height-up",
              stroke: guide-stroke,
              mark: length-mark,
            )
            line(
              "dimension-middle",
              "dimension-bottom",
              name: "height-down",
              stroke: guide-stroke,
              mark: length-mark,
            )
          })
          // Draw the pillbox after the 3D scene. This keeps the projected
          // geometry while ensuring the plane cannot tint its visible faces.
          line(
            "bottom-0",
            "bottom-1",
            "bottom-2",
            "bottom-3",
            close: true,
            name: "bottom-face",
            stroke: hidden-stroke,
          )
          for i in range(4) {
            line("middle-" + str(i), "bottom-" + str(i), stroke: hidden-stroke)
          }
          line(
            "middle-0",
            "middle-1",
            "middle-2",
            "middle-3",
            close: true,
            name: "middle-face",
            stroke: guide-stroke,
          )
          for i in range(4) {
            let next = calc.rem(i + 1, 4)
            line(
              "middle-" + str(i),
              "middle-" + str(next),
              "top-" + str(next),
              "top-" + str(i),
              close: true,
              fill: rgb("#ffffff"),
              stroke: guide-stroke,
            )
          }
          line(
            "top-0",
            "top-1",
            "top-2",
            "top-3",
            close: true,
            name: "top-face",
            fill: rgb("#ffffff"),
            stroke: guide-stroke,
          )

          // Keep both field vectors in the final overlay layer as well.
          line(
            "top-center",
            "field-up-tip",
            name: "field-up",
            stroke: vector-stroke,
            mark: (end: ">>", fill: black),
          )
          line(
            "bottom-center",
            "field-down-tip",
            name: "field-down",
            stroke: vector-stroke,
            mark: (end: ">>", fill: black),
          )
          circle("field-up.start", radius: 2pt, fill: black, stroke: none)
          circle("field-down.start", radius: 2pt, fill: black, stroke: none)

          content("plane-back-edge.1%", anchor: "north", padding: 2pt, math-rect([$x y$-plane]))
          content("top-center", anchor: "west", padding: 5pt, math-rect($A$))
          content("top-face.75%", anchor: "north", padding: 1pt, math-rect($S$))
          content("field-up.end", anchor: "south", padding: 2pt, math-rect($va(E)$))
          content("field-down.end", anchor: "north", padding: 2pt, math-rect($va(E)$))
          content("height-up.52%", anchor: "west", padding: 2pt, math-rect($abs(z)$))
          content("height-down.50%", anchor: "west", padding: 2pt, math-rect($abs(z)$))
        },
      )
    },
    caption: [A Gaussian pillbox $S$ centered on the uniformly charged plane.],
  ) <fig:gaussian-pillbox>
]
#example(restate: true, restate-keys: "ex:gaussian-surface-pillbox")[
  An infinite plane coplanar with the $x y$-plane carries a surface charge density distribution $sigma$, whereby an electric field $va(E)$ is generated. Find $va(E)(va(r))$ at an arbitrary point $va(r)$.
] <ex:gaussian-surface-pillbox>
#solution[to @ex:gaussian-surface-pillbox][
  By virtue of symmetry, the electric field at $va(r)$ points in the $vu(z)$ direction (denote the respective component by $va(z) = z vu(z)$). Let $S$ be a "Gaussian pillbox," the colloquial term for a rectangular prism with two square faces of respective area $A$, parallel to the $x y$-plane equidistantly $abs(z)$ away therefrom, with four vertical faces whose normal vectors are orthogonal to the electric field thereat. Then
  $
    Q_"enc" / epsilon_0 = integral.surf_S va(E)(va(r)') dot dif va(S)' = (integral.double_(4 perp "faces") + integral.double_(2 parallel "faces")) va(E)(va(r)') dot dif va(S)' = 2 A E(va(r)).
  $
  Geometrically, we have $op("area")[jinterior S inter #[$x y$-"plane"]] = A$, whence
  $
    Q_"enc" / epsilon_0 = (A sigma) / epsilon_0 = 2 A E ==> E(va(r)) = sigma / (2 epsilon_0) ==> va(E)(va(r)) = sigma / (2 epsilon_0) va(z)/abs(z). qedhere
  $
]
(Notice the independence---save the preceding signage---of the electric field from $va(r)$ itself.)
#example[
  Compute the electric field generated by two infinitely large parallel planes $S_+, S_-$, carrying respective uniform surface charge density distributions $+sigma$ and $-sigma$.
] <ex:electric-field-of-two-parallel-planes>
#proof[
  By the principle of superposition, the total electric field is thereby equivalent to the calculated summation of the individual constituent fields from $S_plus.minus$. An arbitrary point $va(r)$---upon projection onto $S_plus.minus$---emits the expression $va(r)_plus.minus^perp + va(r)_plus.minus^parallel,$ where $va(r)_plus.minus^perp perp S_plus.minus$ and $va(r)_plus.minus^parallel in S_plus.minus$.

  From observation that the planar normals point in the same direction, we aver that $va(r)_+^perp = lambda va(r)_-^perp$, whence @ex:gaussian-surface-pillbox gives
  $
    va(E) & = sigma / (2 epsilon_0) ((va(r)_+^perp) / norm(va(r)_+^perp)+(va(r)_-^perp) / norm(va(r)_-^perp)) = sigma / (2 epsilon_0) (sgn(lambda) (va(r)_-^perp) / norm(va(r)_-^perp) + (va(r)_-^perp) / norm(va(r)_-^perp)) = (sigma Theta(lambda)) / epsilon_0 (va(r)_-^perp) / norm(va(r)_-^perp).
  $
  Qualitatively, the electric field transpires to be independent of the precise value of $va(r)$. When it is not in the region between the two planes there is no electric field, whilst otherwise it is directed orthogonally away from both planes with a field strength $sigma / epsilon_0$.
]
