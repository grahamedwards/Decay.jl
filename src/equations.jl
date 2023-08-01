############################
#  Direct Decay Equations  #
############################

# Includes: N, D, D_
    # to make: dN_dt?

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

see also: [`D_`](@ref)

"""
D(t::Number, λ::Number; N=1., Do=0.) = Do + N *(exp(λ*t)-1)





"""
```julia
D_(t, λ; No=1, Do=0)
```

Forward model a single decay system. 

Calculates the abundance of radiogenic daughter isotope `D` after time `t`,  given the INITIAL abundance of parent isotope `No` (default = 1) and its decay constant `λ`. Optionally takes an initial daughter abundance `Dₒ` (default = 0).

Equation: `D = Dₒ +  Nₒ ( 1 - exp(-λ t) )`

see also: [`D`](@ref)

"""
D_(t::Number, λ::Number; No::Number=1., Do::Number=0.) = Do + No * (1 - exp(-λ*t))





############################
#  Series Decay Equations  #
############################

# Includes: dN2_dt, N2

"""

```julia
dN2_dt(λ₂, λ₁; N2=0, N1=1)
```

Calculate the derivative of abundance of a radioactive daughter isotope in a decay-series given its decay constant `λ₂` and that of its parent `λ₁`. Optionally give the current abundance of the isotope `N2` (default = 0) and its parent `N1` (default = 1).

Equation: `dN/dt = λ₁ * N₁ - λ₂ * N₂`

MathTex: `\\frac{dN_2}{dt} = \\lambda_1 N_1 - \\lambda_2  N_2`

"""
dN2_dt(λ2::Number, λ1::Number; N2::Number=0,N1::Number=1) = λ1 * N1 - λ2 * N2


"""

```julia
N2(t, λ₂, λ₁; N1o=1, N2o=0)
```

Calculate the the abundance of a radioactive daughter isotope in a decay-series after some time `t`, given its decay constant `λ₂` and that of its parent `λ₁`. Optionally provide the initial abundances of the isotope `N2o` (default = 0) and its parent `N1o` (default = 1).

Equation: N₂ = (λ₁ / (λ₂ - λ₁)) * N₁ᵒ * (exp(-λ₁ * t) - exp(-λ₂ * t)) + N₂ᵒ * exp(-λ₂ * t)

MathTex: `N_2 = \\frac{\\lambda_1}{\\lambda_2 - \\lambda_1} N^o_1 \\left( e^{-\\lambda_1 t} - e^{-\\lambda_2 t} \\right) + N_2^o e^{-\\lambda_2 t}`

"""
N2(t::Number, λ2::Number, λ1::Number; N1o::Number=1, N2o::Number=0) = (λ1 / (λ2-λ1)) * N1o * (exp(-λ1 * t) - exp(-λ2 * t)) + N2o * exp(-λ2 * t)





# N3?






## Converting from half-life to decay constant and back again, a nucleus' tale...

"""

```julia
lambda(halflife)
```
Calculates the decay constant (λ) from a half-life (`t`) with ` = log(2)/t`

see also: [`halflife`](@ref)

"""
lambda(halflife::Number) = 0.6931471805599453/float(halflife)





"""

```julia
halflife(λ)
```
Calculates the half-life from a decay constant (λ) with ` log(2)/λ`

see also: [`lambda`](@ref)

"""
halflife(lambda::Number) = Decay.lambda(lambda)