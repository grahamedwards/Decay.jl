############################
#  Direct Decay Equations  #
############################

"""

```julia
Decay.N(t, λ; No=1)
```

The classic decay equation. Calculate the remaining abundance of parent radioisotope `N` with decay constant `λ` after time `t`. Optionally provide an initial abundance `No` (default = 1).

Equation: `N = Nₒ exp(-λ t)`

"""
N(t::Number,λ::Number;No=1.) = No*exp(-λ*t)





"""

```julia
Decay.D(t, λ; N=1, Do=0)
```

The classic age equation. 

Calculates the abundance of stable radiogenic daughter isotope `D` after time `t`, given the MODERN abundance of parent isotope `N` (default = 1) and its decay constant `λ`.  Optionally takes an initial daughter abundance `Dₒ` (default = 0).

Equation: `D = Dₒ + N ( exp(-λ t) - 1 )`

see also: [`D_`](@ref)

"""
D(t::Number, λ::Number; N=1., Do=0.) = Do + N *(exp(λ*t)-1)





"""
```julia
Decay.D_(t, λ; No=1, Do=0)
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

"""

```julia
Decay.dN2_dt(λ₂, λ₁; N2=0, N1=1)
```

Calculate the derivative of abundance of a radioactive daughter isotope in a decay-series given its decay constant `λ₂` and that of its parent `λ₁`. Optionally give the current abundance of the isotope `N2` (default = 0) and its parent `N1` (default = 1).

Equation: `dN/dt = λ₁ * N₁ - λ₂ * N₂`

MathTex: `\\frac{dN_2}{dt} = \\lambda_1 N_1 - \\lambda_2  N_2`

"""
dN2_dt(λ2::Number, λ1::Number; N2::Number=0,N1::Number=1) = λ1 * N1 - λ2 * N2

"""

```julia
Decay.N2(t, λ₂, λ₁; N2o=0, N1o=1)
```

Calculate the the abundance of a radioactive daughter isotope in a decay-series after some time `t`, given its decay constant `λ₂` and that of its parent `λ₁`. Optionally provide the initial abundances of the isotope `N2o` (default = 0) and its parent `N1o` (default = 1).

Equation: N₂ = (λ₁ / (λ₂ - λ₁)) * N₁⁰ * (exp(-λ₁ * t) - exp(-λ₂ * t)) + N₂ᵒ * exp(-λ₂ * t)

MathTex: `N_2 = \\frac{\\lambda_1}{\\lambda_2 - \\lambda_1} N^0_1 \\left( e^{-\\lambda_1 t} - e^{-\\lambda_2 t} \\right) + N^0_2 e^{-\\lambda_2 t}`

see also: [Decay.Q](@ref)

"""
function N2(t::Number, λ2::Number, λ1::Number; N2o::Number=0.0, N1o::Number=1.0)
    el2t = exp(-λ2 * t)
    (λ1 / (λ2-λ1)) * N1o * (exp(-λ1 * t) - el2t) + N2o * el2t 
end


"""

```julia
Decay.Q(t, l2, l1; Q0=0, P0=1)
```

Calculate the the abundance of a radioactive daughter isotope `Q` in a decay-series after some time `t`, given its decay constant `l2` and that of its parent `l1`. Optionally provide the initial abundances of the isotope `Q0` (default = 0) and its parent `P0` (default = 1).

After the derivation of Bateman, H. 1910. Solution of a system of differential equations occurring in the theory of radioactive transformations. Proceedings of the Cambridge Philosophical Society, vol. 15.

`Q = \\frac{\\lambda_1}{\\lambda_2 - \\lambda_1} P_0 e^{-\\lambda_1 t} + \\left(  \\frac{\\lambda_1}{\\lambda_1 - \\lambda_2} + Q_0 \\right) e^{-\\lambda_2 t}`

see also: [Decay.N2](@ref)

"""
function Q(t::Number, l2::Number, l1::Number; Q0::Number=0.0, P0::Number=1.0)
    l1P0 = l1*P0 
    A = l1P0/(l2-l1)
    B = Q0 + l1P0/(l1-l2)
    A * exp(-l1*t) + B * exp(-l2*t)
end




"""

```julia
R(t, l3, l2, l1; R0=0; Q0=1, P0=1)
```

Calculate the the abundance of a radioactive daughter isotope `R` in a decay-series after some time `t`, given its decay constant `l3`, the decay constant of `l2` of its parent `Q`, and the decay constant `l1` of its parent's parent `P`. Optionally provide the initial abundances of the isotopes `R0` (default = 0), `Q0` (default = 1), and `P0` (default = 1).

After the derivation of Bateman, H. 1910. Solution of a system of differential equations occurring in the theory of radioactive transformations. Proceedings of the Cambridge Philosophical Society, vol. 15.

"""
function R(t::Number, l3::Number, l2::Number, l1::Number; R0::Number=0.0, Q0::Number=1.0, P0::Number=1.0)
    llP0 = l1 * l2 * P0
    lQ0 = l2 * Q0
    A = llP0/((l2-l1)*(l3-l1))
    B = llP0/((l1-l2)*(l3-l2)) + lQ0/(l3-l2)
    C = llP0/((l1-l3)*(l2-l3)) + lQ0/(l2-l3) + R0
    A * exp(-l1*t) + B * exp(-l2*t) + C * exp(-l3*t)
end





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