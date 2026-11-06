#import "/lib.typ": *
#show: docs-subchapter.with(
  title: [Vectors],
  route: "vectors",
)
In its most heuristically recognizable form, a vector is a quantity characterized by having a magnitude and a direction. In due time (@todo), we will see the definition associated with greater generality and abstraction; which although seemingly a question appertaining to pure mathematics, holds physical significance.

Throughout the proceeding discourse, the symbols $va(r)$ and $va(r)'$ shall denote position vectors in $RR^3$. The distinction between them shall be determined by the exigencies of context and it will frequently transpire that one or both serve as variables of integration. The notation $va(r)_0$ shall serve a similar purpose, with the additional emphasis upon its reservation for use as a fixed position vector, to be employed in instances wherein a quantity is to be evaluated at a prescribed point of interest.

Further shall we make use of $va(s)$, $va(s)'$, and $va(xi)$ to denote the purpose of separation vectors. Their definitions shall remain invariant herethroughout:
$
  va(s) = va(r) - va(r)_0, wide va(s)' = va(r)' - va(r)_0, wide "and" wide va(xi) = va(r)' - va(r) = va(s)' - va(s).
$
In accordance thereto, $va(s)$ and $va(s)'$ represent displacements from the fixed reference position $va(r)_0$, whilst $va(xi)$ denotes the relative displacement between the points associated with $va(r)$ and $va(r)'$.

It shall be our convention that, for any vector quantity represented by a single symbol, the same symbol without additional weight or accent notation denotes the magnitude thereof. Likewise, the corresponding unit vector shall be distinguished by addition of a circumflex, for which we denote
$
  r = norm(va(r)), quad vu(r) = va(r) / r, quad r' = norm(va(r)'), quad vu(r)' = va(r)' / r', \ s = norm(va(s)), quad vu(s) = va(s) / s, quad s' = norm(va(s)'), quad vu(s)' = va(s)' / s', quad xi = norm(va(xi)), quad vu(xi) = va(xi) / xi,
$
et cetera.
