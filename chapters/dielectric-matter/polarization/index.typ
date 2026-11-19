#import "/lib.typ": *
#show: docs-subchapter.with(
  ..dargs("Polarization"),
)
_Polarization_ describes the internal charge arrangement occurring in the presence of an external field. It also describes the function $va(P)(va(r))$ characterizing this arrangement. We first specify the source of $va(E)_"ext"$ in @eq:dielectric-total-field-decomposition by $rho_f$, known historically as the _free charge_. The source of $va(E)_"self"$ is known as the _bound charge_, or the _polarization charge_ and is denoted by $rho_P$. The total charge density is then
$
  rho(va(r)) = rho_f (va(r)) + rho_P (va(r)).
$
We shall now introduce $va(P)$. The polarization charge density of a neutral dielectric with volume $V$, surface $S$, can be macroscopically characterized by a volume part $rho_P$ and a surface part $sigma_P$ satisfying
$
  integral.triple_V rho_P (va(r)) dif^3 r + integral.surf_S sigma_P (va(r)) dif S = 0.
$
Under the influence of some nonzero $E_"ext"$, positive charges and negative charges rearrange themselves by the macroscopic Coulumb force $rho_P va(E)_"tot"$, simultaneously subject to chemical forces and other effects, until equilibrium is reestablished, whereupon the relation above continues to hold. The neutral dielectric satisfies the above by finding a suitable $va(P)$ such that
$
              rho_P (va(r)) = -div va(P)(va(r)) wide &&      wide va(r) in V \
  sigma_P (va(r)_S) = va(P) (va(r)_S) dot vu(n) wide &&    wide va(r)_S in S \
                               va(P)(va(r)) = 0 wide && wide va(r) in.not V,
$ <eq:dielectric-polarization-conditions>
so that
$
  integral.triple_V rho_P dif^3 r + integral.surf_S sigma_P dif S = integral.triple_V -div va(P) dif^3 r + integral.surf_S va(P) dot dif va(S) = 0
$
by the Divergence theorem (@thm:divergence). (Note that fixed $rho_P$ and $sigma_P$ will not uniquely determine @eq:dielectric-polarization-conditions.)
#remark[
  We claim $va(P) = 0$ whensoever outside $V$, as matter is not present outside $V$. This jump in the values attained by $va(P)$ allows for a distributional consideration wherein the surface density is incorporated in the volume charge density. To illustrate our intended meaning, permit the consideration of
  $
    va(P) (va(r)) = cases(
      va(P)_0 (va(r)) & quad "if" z > 0\,,
      0 & quad"if" z<0
    ) = va(P)_0 Theta(z)
  $
  (wherein $Theta$ is the Heaviside distribution). Then we have by definition
  $
    rho_P = -div va(P) = -div va(P)_0 Theta(z) - va(P)_0 dot grad Theta(z)= -div va(P)_0 Theta(z) - va(P)_0 dot delta(z) vu(z).
  $
  The first term is the effective (and non-singular) charge density. The second term is the effective surface charge density. Thus in many works of physical literature will one make use of $rho_P$ as the sole distributional typification of the polarization charge. We will however make use of the separation characterizing $rho_P$ and $sigma_P$ as _effective densities_, much similar to in @sec:dipole-layers, for the ease in its explicitness.
]
One may consider the computation (wherein have we used $va(P) = va(P) dot vaa(I) = va(P) dot (grad times.o va(s))$)
$
  integral.triple_V va(P) dif^3 r &= integral.triple_V div (va(P) times.o va(s)) dif^3 r - integral.triple_V (div va(P)) va(s) dif^3 r \
  &= integral.surf_S dif va(S) dot (va(P) times.o va(s)) - integral.triple_V (div va(P)) va(s) dif^3 r = integral.surf_S sigma_P (va(r)) va(s) dif S + integral.triple_V rho_P (va(r)) va(s) dif^3 r = va(p),
$
thus the integral of the polarization is the dipole moment of a dielectric. Further, following the Lorentz model, the polarization is microscopically identifiable as a measure _electric dipole moment volume density_ (much similar $va(tau)$ being a electric dipole moment surface density); mathematically,
#claim[Lorentz model][
  For a microscopic cell $Omega$ at $va(r)$,
  $
    va(P)(va(r)) = 1 / (op("vol")Omega) integral.triple_Omega rho_"micro" (va(r)') va(xi) dif^3 r'.
  $
]
The macroscopic limit of $Omega$ replaces the entire dielectric with a continuous distribution of point dipoles.

The given model above proves to be of intuitive veracity. With respect to practicality however, it is averred to be a rather poor approximation of true polarization. In part, this is due to the rapid fluctuations and perceived singularities at a microscopic level, which collectively render the selection of $Omega$ impossible without introducing ambiguity. Examples are provided in @todo, where the choice of different cells can give rise to oppositely directed $va(P)$.

More recently in history was an unambiguous typification of polarization introduced, which abandons the Lorentz model.
