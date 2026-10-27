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
#example[
  A solid cylinder of infinite length and radius $R$ axially centered at the $x$-axis is uniformly charged with a volume density $rho$. Find the electric field at some arbitrary point $va(r)$.
] <ex:gaussian-surface-cylinder>
#solution[to @ex:gaussian-surface-cylinder][
  Denote by $S$ the coaxial cylinder of length $2L$ centered at $va(x) = op("proj")_vu(x) va(r)$ and disposed with axis parallel to the $x$-axis to be the Gaussian surface. By Gauss' Law,
  $
    Q_"enc" / epsilon_0 = integral.surf_S va(E)(va(r)') dot dif va(S)' = integral.double_"lateral" va(E)(va(r)') dot dif va(S)' + integral.double_"base1" va(E)(va(r)') dot dif va(S)' + integral.double_"base2" va(E)(va(r)') dot dif va(S)'.
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
#example[
  An infinite plane coplanar with the $x y$-plane carries a surface charge density distribution $sigma$, whereby an electric field $va(E)$ is generated. Find $va(E)(va(r))$ at an arbitrary point $va(r)$.
] <ex:gaussian-surface-pillbox>
#solution[to @ex:gaussian-surface-pillbox][
  By virtue of symmetry, the electric field at $va(r)$ points in the $vu(z)$ direction (denote the respective component by $va(z) = z vu(z)$). Let $S$ be a "Gaussian pillbox," the colloquial term for a rectangular prism with two square faces of respective area $A$, parallel to the $x y$-plane equidistantly $abs(z)$ away therefrom, with four vertical faces whose normal vectors are orthogonal to the electric field thereat. Then
  $
    Q_"enc" / epsilon_0 = integral.surf_S va(E)(va(r)') dot dif va(S)' = integral.double_(4 perp "faces") va(E)(va(r)') dot dif va(S)' + integral.double_(2 parallel "faces") va(E)(va(r)') dot dif va(S)' = 2 A E(va(r)).
  $
  Geometrically, we have $op("area")[jinterior S inter #[$x y$-"plane"]] = A$, whence
  $
    Q_"enc" / epsilon_0 = (A sigma) / epsilon_0 = 2 A E ==> E(va(r)) = sigma / (2 epsilon_0) ==> va(E)(va(r)) = sigma / (2 epsilon_0) va(z)/abs(z). qedhere
  $
]
(Notice the independence---save the preceding signage---of the electric field from $va(r)$ itself.)
