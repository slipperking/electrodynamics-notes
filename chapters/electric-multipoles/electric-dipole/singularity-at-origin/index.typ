#import "/lib.typ": *
#show: docs-subsubchapter.with(
  ..dargs("The Singularity at the Origin"),
)

Allow us to chance a closer examination of @eq:electric-dipole-field, wherein we made (implicitly) the assumption of $s != 0$. We shall preliminarily aver that the relationship (in a distributional or integrated sense) does not hold at the origin $va(r) = va(r)_0$.

To allow a more detailed observation thereof, first we derive
#theorem[
  An arbitrary localized electrostatic charge density distribution $rho(va(r))$ generates an electric field $va(E)(va(r))$. For any spherical volume $V$ (where we impose no restriction upon its center $va(r)_0$) enclosing the support of $rho$, the electric dipole moment about $va(r)_0$ is determinable from
  $
    va(p) = -3 epsilon_0 integral.triple_V va(E)(va(r)) dif^3 r.
  $
]
#proof[
  $
    integral.triple_V va(E)(va(r)) dif^3 r &= 1 / (4 uppi epsilon_0) integral.triple_V integral.triple_V (rho(va(r)')) / norm(va(r) - va(r)')^3 (va(r) - va(r)') dif^3 r' dif^3 r \
    & = -1 / (4 uppi epsilon_0) integral.triple_V integral.triple_V (rho(va(r)')) / norm(va(r)' - va(r))^3 (va(r)' - va(r)) dif^3 r dif^3 r',
  $
  wherein the inner integral
  $
    rho(va(r)') / (4 uppi epsilon_0) integral.triple_V (va(r)' - va(r)) / norm(va(r)' - va(r))^3 dif^3 r
  $
  is electric field given by the constant volume distribution $va(r) |-> rho(va(r)')$ supported in $V$ when evaluated at $va(r)'$.

  By Gauss' Law (@eq:gauss-law-integral) or considering the Spherical Shell Theorem (@thm:spherical-shell), where $va(s)' = va(r)' - va(r)_0$, $s' = norm(va(s)')$, this quantity is given by
  $
    rho(va(r)') / (4 uppi epsilon_0) integral.triple_V (va(r)' - va(r)) / norm(va(r)' - va(r))^3 dif^3 r = cases(va(E) "from pt. charge" 4 / 3 uppi R^3 rho(va(r)') & "if" va(r)' in.not V\,, va(E) "from pt. charge" 4 / 3 uppi s'^3 rho(va(r)') & "otherwise",)
  $
  wherein the former is an impossibility, whence
  $
    integral.triple_V va(E)(va(r)) dif^3 r &= -1 / (4 uppi epsilon_0) integral.triple_V integral.triple_V (rho(va(r)')) / norm(va(r)' - va(r))^3 (va(r)' - va(r)) dif^3 r dif^3 r' \
    &= -1/ (4 uppi epsilon_0) integral.triple_V (4 / 3 uppi s'^3 rho(va(r)')) va(s)' / s'^3 dif^3 r' \
    &= -1/ (3 epsilon_0) integral.triple_V rho(va(r)') va(s)' dif^3 r' = -1/ (3 epsilon_0) va(p). qedhere
  $
]
In consideration therewith and of @eq:electric-dipole-potential, the point dipole must give, for $V = B_R$ a sphere of radius $R$ centered about $va(r)_0$,
$
  va(p) / (3 epsilon_0) & = integral.triple_V grad phi dif^3 r = 1 / (4 uppi epsilon_0) (integral.surf_(s = R) - integral.surf_(s = epsilon)) (va(p) dot va(s)) / s^3 dif va(S) - integral.triple_B_epsilon va(E) dif^3 r #tag[(@cor:divergence-substitutions)] \
  &= 1 / (4 uppi epsilon_0) (1 / R^3 integral.surf_(s = R) - 1 / epsilon^3 integral.surf_(s = epsilon)) va(p) dot va(s) dif va(S) - integral.triple_B_epsilon va(E) dif^3 r \
  &=1 / (4 uppi epsilon_0) (1 / R^3 integral.triple_V - 1 / epsilon^3 integral.triple_B_epsilon) partial_i vu(e)_i p_j s_j dif^3 r - integral.triple_B_epsilon va(E) dif^3 r \
  &=1 / (4 uppi epsilon_0) (1 / R^3 integral.triple_V - 1 / epsilon^3 integral.triple_B_epsilon) vu(e)_i p_j delta_(i j) dif^3 r - integral.triple_B_epsilon va(E) dif^3 r \
  &=1 / (4 uppi epsilon_0) (1 / R^3 integral.triple_V - 1 / epsilon^3 integral.triple_B_epsilon) vu(e)_i p_i dif^3 r - integral.triple_B_epsilon va(E) dif^3 r \
  &=1 / (4 uppi epsilon_0) (4 / 3 uppi - 4 / 3 uppi) va(p) - integral.triple_B_epsilon va(E) dif^3 r = -integral.triple_B_epsilon va(E) dif^3 r,
$ <eq:moment-electric-field-point-dipole>
wherein the equality must hold for all $epsilon < R$. From the last expression gives the motivation to write
#theorem[Electric Point Dipole Field][
  Distributionally,
  $
    va(E)(va(r)) = pv 1 / (4 uppi epsilon_0) (3 vu(s) (va(p) dot vu(s)) - va(p)) / s^3 - va(p) / (3 epsilon_0) delta(va(s)),
  $
  where the Cauchy principal value is defined as follows:
  $
    pv integral.triple 1 / (4 uppi epsilon_0) (3 vu(s) (va(p) dot vu(s)) - va(p)) / s^3 dif^3 r = lim_(epsilon ->0^+) integral.triple_(s > epsilon) 1 / (4 uppi epsilon_0) (3 vu(s) (va(p) dot va(s)) - va(p)) / s^3 dif^3 r
  $
] <thm:electric-point-dipole-field>
We shall now give intuition for the veracity of the above.

Its well-definedness of the principal value is given in @eq:moment-electric-field-point-dipole in the case of spherical regions./*  For an arbitrary region $V$, it may be written as the union of a ball centered at $va(r)_0$ and its complement. */ Now assuming $rho = -va(p) dot grad delta(s)$, we have from @eq:electric-point-dipole-potential that
$
  -grad phi(va(r)) = 1 / (4 uppi epsilon_0) grad [va(p) dot (-vu(s) / s^2)] = 1 / (4 uppi epsilon_0) grad [va(p) dot grad 1 / s]
$
$
  va(E) &= 1 / (4 uppi epsilon_0) p_j vu(e)_i partial_i partial_j 1 / s = 1 / (4 uppi epsilon_0) p_j partial_j vu(e)_i partial_i 1 / s \
  &= 1 / (4 uppi epsilon_0) (va(p) dot grad) grad 1 / s = 1 / (4 uppi epsilon_0) va(p) dot grad times.o grad 1 / s.
$
The trace of the dyadic $grad times.o grad 1 / s$ is given by
$
  trace(grad times.o grad 1 / s) = laplacian 1 / s = -4 uppi delta(va(s)),
$
which is the source of the necessitated $delta$.
