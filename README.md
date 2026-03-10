# Decay

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://grahamedwards.github.io/Decay.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://grahamedwards.github.io/Decay.jl/dev/)
[![Build Status](https://github.com/grahamedwards/Decay.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/grahamedwards/Decay.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/grahamedwards/Decay.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/grahamedwards/Decay.jl)


An ultralight package to stash useful radiometric decay constants for geochronology and cosmochronology, along with useful decay, ingrowth, and activity equations. 

## Installation

To add Decay.jl to your Julia environment, just type `]` into the Julia REPL to enter the built-in package manager and then type `add https://github.com/grahamedwards/Decay.jl` and hit enter.

After installing, you can load the package with `using Decay`.

## Decay constants

`Decay.jl` exports a `const` variable `λ`, which is a NamedTuple with fields corresponding to decay constants (in units of y⁻¹) and their uncertainties. This variable is also available through `Decay.lambda`. More information and references are available in the documentation by calling `?λ` or `?Decay.lambda`.

Within the package scope the functions `Decay.decayconstant` and `Decay.halflife` convert between decay constants to half-lives, via the relationship $\lambda = \frac{\ln 2}{t_{1/2}}$. Mean-life $\tau$ is readily calculated from the decay constant by $\tau = \lambda^{-1}$. 

## Radiometric decay equations.

Within the package scope, there are a few helpful equations that calculate decay for direct-decay and decay-series systems: `Decay.D`,`Decay.D_`, `Decay.N`, `Decay.dN2_dt`, `Decay.N2`, `Decay.Q`, and `Decay.R`.  

Check out the documentation `?...` to learn more. 

## Activity calculations

`Decay` exports a type structure and equations to estimate and convert radioactivity. The supertype `RadUnit` has subtypes `Becquerel` (also `Bq`), `Curie` (also `Ci`), `DPM`, and `PerYear`. RadUnit constructor functions automatically convert units, e.g.

```julia
julia> Becquerel(Curie(1))
Becquerel(3.7e10)
```

The functions `act2conc` and `conc2act` respectively convert RadUnit activities to concentrations and concentrations to activities. 

Check out `?act2conc` and `?conc2act` for more information on using the functions. 

### Maths relating activities and concentrations

The radioactivity $A$ of a substance is the direct result of decays and this rate of decay $\frac{dN}{dt}$ is directly proportional to the atomic abundance of the radioisotope $N$:

$$
A = -\frac{dN}{dt} = \lambda N
$$

Therefore, we can rearrange the equation to calculate the atomic abundance via $N = A \lambda^{-1}$ (in comparable units, e.g. both $\text{y}^{-1}$ or $\text{Bq}$ and $\text{s}^{-1}$) and convert to the mass of the radioisotope via its atomic mass $m_a$ in $\text{g~mol}^{-1}$ and the Avogadro number $N_A$:

$$
m = \frac{A}{\lambda}~\frac{m_a}{N_A}
$$


If $A$ is a massic activity (Bq/g), then this calculation provides a concentration in g/g.


## Upkeep and maintenance

I will continue updating and adding decay constants (and equations) as free-time permits 😵‍💫 

Please let me know if there are specific decay constants you would like me to add!