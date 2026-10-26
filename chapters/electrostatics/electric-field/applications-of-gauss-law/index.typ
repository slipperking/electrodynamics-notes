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
Such is the utility herein of an auxiliary surface as $S'$, that it has received its own name---a "Gaussian surface"---with the sufficient symmetries that allow for the simplification of many problems as above.
