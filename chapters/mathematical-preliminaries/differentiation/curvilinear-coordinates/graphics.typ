#import "/lib.typ": *

// All geometry is in Cartesian 3D; CeTZ handles the camera projection.
#let spherical-element = canvas(
  debug-show: true,
  {
    import cetz.draw: *
    let sph(r, t, p) = (r * calc.sin(t) * calc.cos(p), r * calc.sin(t) * calc.sin(p), r * calc.cos(t))
    let r = 6
    let dr = 1.5
    let t = 40deg
    let dt = 18deg
    let p = 65deg
    let dp = 22deg
    let samples(f) = range(33).map(i => f(i / 32))
    let polar(r, p) = samples(u => sph(r, t + u * dt, p))
    let azimuth(r, t) = samples(u => sph(r, t, p + u * dp))
    let guide = (paint: black, thickness: 0.55pt, dash: "dashed")
    let edge = (paint: black, thickness: 0.9pt)
    let hidden = (paint: black, thickness: 0.65pt, dash: "dashed")
    let label(pos, body, anchor: "center") = content(pos, math-rect(body), anchor: anchor, padding: 3pt)

    ortho(x: -70deg, y: 0deg, z: -135deg, sorted: false, {
      for (pos, body, anchor) in (
        ((5, 0, 0), $x$, "north-east"),
        ((0, 7, 0), $y$, "north-west"),
        ((0, 0, 7.2), $z$, "south"),
      ) {
        line((0, 0, 0), pos, stroke: 0.7pt, mark: (end: ">>", fill: black))
        label(pos, body, anchor: anchor)
      }
      label((0, 0, 0), $O$, anchor: "south-east")

      // Only the two rays bounding the polar increment are shown.
      for tt in (t, t + dt) {
        line((0, 0, 0), sph(r, tt, p), stroke: guide)
      }
      let foot = sph(r, 90deg, p)
      let ground = (foot.at(0) * calc.sin(t), foot.at(1) * calc.sin(t), 0)

      // Radius of the azimuthal circle, in its horizontal plane.
      let pole = (0, 0, r * calc.cos(t))
      line(pole, sph(r, t, p), stroke: guide)
      line(pole, sph(r, t, p + dp), stroke: guide)
      // Right-angle marker between the z-axis and the horizontal projection.
      let right-angle-size = 0.38
      let horizontal = (calc.cos(p), calc.sin(p), 0)
      line(
        (0, 0, pole.at(2) - right-angle-size),
        (
          right-angle-size * horizontal.at(0),
          right-angle-size * horizontal.at(1),
          pole.at(2) - right-angle-size,
        ),
        (
          right-angle-size * horizontal.at(0),
          right-angle-size * horizontal.at(1),
          pole.at(2),
        ),
        stroke: edge,
      )
      label(sph(r * 0.53, t, p), $r$, anchor: "south-east")
      label(pole, $r sin theta$, anchor: "east")

      line(..samples(u => sph(1.35, u * t, p)), stroke: 0.6pt)
      label(sph(1.20, t * 0.5, p), $theta$)
      line(..samples(u => sph(2.15, t + u * dt, p)), stroke: 0.6pt)
      label(sph(2.15, t + dt * 0.5, p), $dif theta$, anchor: "south-west")
      line(..samples(u => (1.4 * calc.cos(p + u * dp), 1.4 * calc.sin(p + u * dp), pole.at(2))), stroke: 0.6pt)
      label(
        (1.4 * calc.cos(p + dp / 2), 1.4 * calc.sin(p + dp / 2), pole.at(2)),
        $dif phi_"az"$,
        anchor: "north",
      )

      // Sampled coordinate curves retain the spherical shape.
      for rr in (r, r + dr) {
        for pp in (p, p + dp) {
          line(..polar(rr, pp), stroke: if rr == r and pp == p + dp { hidden } else { edge })
        }
        for tt in (t, t + dt) {
          line(..azimuth(rr, tt), stroke: if rr == r and tt == t + dt { hidden } else { edge })
        }
      }
      for tt in (t, t + dt) {
        for pp in (p, p + dp) {
          line(sph(r, tt, pp), sph(r + dr, tt, pp), stroke: if tt == t + dt and pp == p + dp { hidden } else { edge })
        }
      }
      // Label the short bottom-left radial edge at its midpoint, offset into
      // the open lower-right region rather than down the ray from the origin.
      label(sph(r + dr / 2, t + dt, p), $dif r$, anchor: "north-west")
      label(sph(r + dr, t + dt / 2, p + dp), $r dif theta$, anchor: "west")
      label(sph(r + dr, t, p + dp / 2), $r sin theta dif phi_"az"$, anchor: "south")
    })
  },
)




