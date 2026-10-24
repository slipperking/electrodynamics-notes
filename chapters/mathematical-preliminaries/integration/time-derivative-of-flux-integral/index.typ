#import "/lib.typ": *
#import "/build/visual-output/time-varying-flux-integral/lib.typ": *
#show: docs-subsubchapter.with(
  title: [Time Derivative of a Flux Integral],
  route: "time-derivative-of-flux-integral",
)

The time derivative of a one-dimensional integral with a time-varying boundary is given by Leibniz' rule:
#theorem[Leibniz Rule][
  $
    dv(, t) integral_a(t)^b(t) f(x,t) dx = integral_a(t)^b(t) pdv(, t) f(x,t) dx + f(b(t), t) pdv(b, t) - f(a(t),t) pdv(a, t).
  $
]

#figure(
  {
    set text(size: 0.75em)
    canvas(
      // debug-show: true,
      {
        import cetz.draw: *

        let boundary-stroke = (paint: black, thickness: 0.85pt)
        let mesh-stroke = (paint: black, thickness: 0.24pt)
        let sweep-stroke = (paint: black, thickness: 0.48pt)
        let cylinder-stroke = (paint: black, thickness: 0.82pt)
        let element-stroke = (paint: black, thickness: 0.52pt)
        let element-connector-stroke = (paint: black, thickness: 0.34pt)
        let element-fill = fancy-tiling.diagonal-stripes(
          background-color: black.transparentize(100%),
          size: 3pt,
          angle: 45deg,
          thickness: 0.2pt,
        )

        for curve in back-sweep-connectors { line(..curve, stroke: sweep-stroke) }
        for curve in front-sweep-connectors {
          line(..curve, stroke: sweep-stroke)
        }

        for curve in lower-mesh-curves { line(..curve, stroke: mesh-stroke) }
        for curve in upper-mesh-curves { line(..curve, stroke: mesh-stroke) }

        line(..lower-far-edge, stroke: boundary-stroke)
        line(..lower-left-edge, stroke: boundary-stroke)
        line(..lower-right-edge, stroke: boundary-stroke)
        line(
          ..lower-near-edge,
          name: "lower-boundary-curve",
          stroke: boundary-stroke,
        )
        line(..upper-far-edge, stroke: boundary-stroke)
        line(..upper-left-edge, stroke: boundary-stroke)
        line(..upper-right-edge, stroke: boundary-stroke)
        line(
          ..upper-near-edge,
          name: "upper-boundary-curve",
          stroke: boundary-stroke,
        )

        line(..ribbon-top-edge, stroke: cylinder-stroke)
        line(..ribbon-opposite-side, stroke: cylinder-stroke)
        line(
          ribbon-dell-start,
          ribbon-dell-end,
          name: "ribbon-dell-vector",
          stroke: cylinder-stroke,
          mark: (end: ">>", fill: black),
        )
        circle(
          "ribbon-dell-vector.start",
          radius: 2pt,
          fill: black,
          stroke: none,
        )
        line(
          ribbon-velocity-start,
          ribbon-velocity-end,
          name: "ribbon-velocity-vector",
          stroke: cylinder-stroke,
          mark: (end: ">>", fill: black),
        )
        line(
          ribbon-normal-start,
          ribbon-normal-end,
          name: "ribbon-normal-vector",
          stroke: cylinder-stroke,
          mark: (end: ">>", fill: black),
        )
        line(
          ..element-bottom-boundary,
          close: true,
          name: "element-bottom-cell",
          fill: element-fill,
          stroke: element-stroke,
        )
        line(
          ..element-top-boundary,
          close: true,
          name: "element-top-cell",
          fill: element-fill,
          stroke: element-stroke,
        )
        for connector in element-plain-connectors {
          line(..connector, stroke: element-connector-stroke)
        }
        line(
          ..element-velocity-side,
          name: "element-velocity-vector",
          stroke: cylinder-stroke,
          mark: (end: ">>", fill: black),
        )
        line(
          element-projection-start,
          element-projection-end,
          name: "element-projection-vector",
          stroke: cylinder-stroke,
          mark: (end: ">>", fill: black),
        )
        circle(
          "element-projection-vector.start",
          radius: 2pt,
          fill: black,
          stroke: none,
        )

        content(
          "lower-boundary-curve.20%",
          padding: 2pt,
          math-rect($partial S(t)$),
        )
        content(
          "upper-boundary-curve.20%",
          padding: 2pt,
          math-rect($partial S(t + delta t)$),
        )
        content(
          "element-bottom-cell.centroid",
          padding: 2pt,
          math-rect($dif S$),
        )
        content(
          "element-velocity-vector.end",
          anchor: "south",
          padding: 2pt,
          math-rect($va(v) delta t$),
        )
        content(
          "ribbon-dell-vector.end",
          anchor: "west",
          padding: 2pt,
          math-rect($dif va(ell)$),
        )
        content(
          "ribbon-velocity-vector.end",
          anchor: "south",
          padding: 2pt,
          math-rect($va(v) delta t$),
        )
        content(
          "ribbon-normal-vector.end",
          anchor: "north",
          padding: 2pt,
          math-rect($dif va(ell) times va(v) delta t$),
        )
        content(
          "element-projection-vector.end",
          anchor: "south",
          padding: 2pt,
          math-rect($op("proj")_(vu(n)) va(v) delta t$),
        )
      },
    )
  },
  caption: [The surface $S(t)$ and the advanced $S(t+delta t)$ with the differential elements.],
) <fig:reynolds-transport-volume>

Analogously assume a time-varying surface $S(t)$ in three dimensions with boundary $partial S(t)$, where at a given time $t$, a particular point $va(r) in S(t)$ moves with velocity $va(v) = va(v)(va(r), t)$, and points in $partial S(t)$ move to those in $partial S(t + delta t)$. The position of the point $va(r)$ after $delta t$ time has elapsed is $va(r) + va(v) delta t$. Then with the given variation in $t$,
$
  delta(integral.double_S(t) va(B)(va(r), t) dot dif va(S)) &= integral.double_S(t + delta t) va(B)(va(r), t+ delta t) dot dif va(S) - integral.double_S(t) va(B)(va(r), t) dot dif va(S) \
  &= integral.double_S(t + delta t) (va(B)(va(r), t+ delta t) - va(B)(va(r), t))dot dif va(S) \
  & wide "" + [integral.double_S(t + delta t) - integral.double_S(t)] va(B)(va(r), t) dot dif va(S) \
  &= integral.double_S(t) delta va(B)(va(r), t) dot dif va(S) \
  & wide "" + [integral.double_S(t + delta t) - integral.double_S(t)] va(B)(va(r), t) dot dif va(S).
$
Multiplying by $1 / (delta t)$ gives
$
  dv(, t)integral.double_S(t) va(B)(va(r), t) dot dif va(S) = integral.double_S(t) pdv(va(B), t) dot dif va(S) + 1 / (delta t) [integral.double_S(t + delta t) - integral.double_S(t)] va(B)(va(r), t) dot dif va(S).
$ <eq:reynolds-transport-volume-derivative-separation>
The field $va(B)$ in the bracketed sum is no longer time-varying. In the span of $delta t$, the region $S(t)$ sweeps out a thin oriented region $V$, as demonstrated in @fig:reynolds-transport-volume. Then by the Divergence Theorem
$
  integral.triple_V div va(B) dif V = integral.double_S(t + delta t) va(B) dot dif va(S) - integral.double_S(t) va(B) dot dif va(S) + integral.double_"ribbon" va(B) dot dif va(S),
$ <eq:reynolds-transport-volume-integral-expansion>
where the sign of the second term is due to orientation. In the third term, the oriented surface element $dif va(S) = vu(n) dif S$ is orthogonal to both the displacement $dif va(ell)$ along $S(t)$ and the displacement $va(v) delta t$, implying that
$
  integral.double_"ribbon" va(B) dot dif va(S) &= integral_(partial S(t)) va(B) dot [dif va(ell) times va(v) delta t] \
  &= integral_(partial S(t)) dif va(ell) dot (va(v) delta t times va(B)) = integral.double_S(t) curl(va(v) delta t times va(B)) dot dif va(S).
$
Similarly, the volume element in @eq:reynolds-transport-volume-integral-expansion may be interpreted as the volume of a small cylinder with base $dif S$ and height $op("proj")_(vu(n)) va(v) delta t$:
$
  dif V = dif S (vu(n) dot va(v) delta t) = va(v) delta t dot dif va(S).
$
Therefore @eq:reynolds-transport-volume-integral-expansion gives
$
  delta t integral.double_S(t) [(div va(B)) va(v) - curl(va(v) times va(B))] dot dif va(S) = integral.double_S(t + delta t) va(B) dot dif va(S) - integral.double_S(t) va(B) dot dif va(S),
$
which by @eq:reynolds-transport-volume-derivative-separation, yields
#theorem[Reynolds Transport Theorem][
  $
    dv(, t)integral.double_S(t) va(B) dot dif va(S) = integral.double_S(t) [pdv(va(B), t) + (div va(B)) va(v) - curl(va(v) times va(B))] dot dif va(S),
  $
]
whose utility will be most demonstrated by Faraday's Law of Electromagnetic Induction.
