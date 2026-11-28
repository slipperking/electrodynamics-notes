#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Counting Multipole Moments"),
)
The primitive moments of the form $C^((ell))_(i_1 i_2 dots.c i_ell)$ are fully symmetric with respect to an interchange of any two indices. Therefore, the number of degrees of freedom to characterize a primitive moment is given by the number of ways to partition $ell$ indistinguishable indices each to exactly one of $x, y, z$ regardless of order, equivalent to the number of such multi-indices with norm $ell$. The method of stars and bars gives this quantity to be $ binom(ell + 3 - 1, 3 - 1) = binom(ell + 2, 2) = 1/2 (ell + 2)(ell + 1). $
The traceless moments $T^((ell))_(i_1 i_2 dots.c i_ell)$ are similarly symmetric, but subject to the additional condition given by
$
  delta_(i_n i_m) T^((ell))_(i_1 dots.c i_ell) = 0.
$
Hence, any two chosen indices give rise to a single decrement in the number of independent components, as the last term within a given trace calculation is uniquely determined from the rest. Therefore the number of independent components is
$
  binom(ell + 2, 2) - binom(ell, 2) = 1/2[ell^2 + 3 ell + 2] - 1/2 [ell^2 - ell] = 2 ell + 1.
$
As averred previously with the point quadrupole construction, the number of independent components occurs naturally through a macroscopic construction of Maxwell. We can generalize the representations given in @sec:electric-quadrupole to $ell$ vectors $va(c)_k$, which shall transpire to give
$
  phi(va(r)) = 1 / (4 uppi epsilon_0) (-va(c)_1 dot grad) dots.c (-va(c)_ell dot grad) 1 / s = 1 / (4 uppi epsilon_0) C (-vu(c)_1 dot grad) dots.c (-vu(c)_ell dot grad) 1 / s.
$
In its factorized form, each $vu(c)_k$ is restricted to $S^2$, giving rise to two degrees of freedom; and the factor $C$ provides an additional degree of freedom. Thus $2 ell + 1$ arises to be the total number of degrees of freedom.

Hence, the traceless representation can be observed to be of maximum possible efficiency. In contrast thereto, it is often that two different primitive moments give rise to the same electric potential.
