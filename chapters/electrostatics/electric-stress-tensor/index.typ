#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Electric Stress Tensor"),
)

Where $rho$ is a volume charge density distribution in $Omega$, restricting $rho$ to $V subset.eq Omega$ and $Omega without V$ and extending the restrictions to vanish outside their previous regions, we obtain two charge distributions $rho_V, rho_(Omega without V)$ with disjoint supports such that $rho_V + rho_(Omega without V) = rho$ everywhere in $Omega$. The force exerted on the former distribution due to the latter is given by
$
  va(F) = integral_V rho (va(r)) va(E)_(Omega without V) (va(r)) dif^3 r = epsilon_0 integral_V (div va(E)_Omega) va(E)_(Omega without V) (va(r)) dif^3 r
$
due to Gauss' Law (@thm:gauss-law).
