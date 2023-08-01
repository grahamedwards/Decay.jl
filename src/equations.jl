## Direct Decay Equations: N, D, D_

"""

```julia
N(t, λ; No=1)
```

The classic decay equation. Calculate the remaining abundance of parent radioisotope `N` with decay constant `λ` after time `t`. Optionally provide an initial abundance `No` (default = 1).

Equation: `N = Nₒ exp(-λ t)`

"""
N(t::Number,λ::Number;No=1.) = No*exp(-λ*t)





"""

```julia
D(t, λ; N=1, Do=0)
```

The classic age equation. 

Calculates the abundance of stable radiogenic daughter isotope `D` after time `t`, given the MODERN abundance of parent isotope `N` (default = 1) and its decay constant `λ`.  Optionally takes an initial daughter abundance `Dₒ` (default = 0).

Equation: `D = Dₒ + N ( exp(-λ t) - 1 )`

see also: `D_`

"""
D(t::Number, λ::Number; N=1., Do=0.) = Do + N *(exp(λ*t)-1)





"""
```julia
D_(t, λ; No=1, Do=0)
```

Forward model a single decay system. 

Calculates the abundance of radiogenic daughter isotope `D` after time `t`,  given the INITIAL abundance of parent isotope `No` (default = 1) and its decay constant `λ`. Optionally takes an initial daughter abundance `Dₒ` (default = 0).

Equation: `D = Dₒ +  Nₒ ( 1 - exp(-λ t) )`

see also: `D`

"""
D_(t::Number, λ::Number; No::Number=1., Do::Number=0.) = Do + No * (1 - exp(-λ*t))





##--------------------------------------------------

## Series Decay Equations

# Probably both overspecific...
# Would rather 
# AU48(t,AU48i;λ234=2.8234e-6)= 1 + (AU48i - 1) * exp(-λ234*t)
# function dAdt(t::Int,Ao,f,λ234=2.8234e-6)
#           A = Ao
#           for i in 1:t
#              A = 1 + (A - 1) * exp(-λ234) + f
#           end   
#            A
#        end






##--------------------------------------------------

## Converting from half-life to decay constant and back again, a nucleus' tale...

"""

```julia
lambda(halflife)
```
Calculates the decay constant (λ) from a half-life (`t`) with ` = log(2)/t`

see also: `halflife`

"""
lambda(halflife::Number) = 0.6931471805599453/float(halflife)





"""

```julia
halflife(λ)
```
Calculates the half-life from a decay constant (λ) with ` log(2)/λ`

see also: `lambda`

"""
halflife(lambda::Number) = Decay.lambda(lambda)