module Decay

export λ

include("equations.jl")

"""

```
Decay.λ
```

A `NamedTuple` library containing the decay constants and uncertainties of a selection of useful radiochronometric isotopes.

Decay constant central tendencies (typically means) are returned by providing the element (e.g. `U`) and isotope (e.g. `238`), as in `λ.U238`. To call the 1σ uncertainty (standard error of the mean), give the same value with a `σ` prefix, as in `λ.σU238`.

References to be formatted:

238,235U Jaffey et al. 1971, Phys. Rev. C, doi: 10.1103/PhysRevC.4.1889
232Th ~~  Holden (1990) which is very near to the oft-used value of Le Roux & Glendenin 1963 (1.40 ± 0.007 Gy). Audi et al. 1997 (Nuc. Phys. A, doi: 10.1016/S0375-9474(97)00482-X) reports 14.05 ± 0.04 Gy and references Bonetti+ 1995, Phys. Rev. C, doi: https://doi.org/10.1103/PhysRevC.51.2530, which does not appear to report a λ_α.
²³⁴U, ²³⁰Th --- Cheng et al. 2013, EPSL, doi: 10.1016/j.epsl.2013.04.006
²²⁶Ra --- Holden, 1990 (Pure and Applied Chem., doi: 10.1351/pac199062050941) 

"""
const λ = (; 
# Uranium series
    U238 = lambda(4.4683e9),
    σU238 = lambda(2.4e6),
    U234 = lambda(245_620),
    σU234 = lambda(130),
    Th230 = lambda(75_584),
    σTh230 = lambda(55),
    Ra226 = lambda(1599),
    σRa226 = lambda(4), 
# Actinitde series
    U235 = lambda(703.81e6),
    σU235 = lambda(480_000),

# Thorium series
    Th232 = lambda(14.0e9),
    σTh232 = lambda(0.01e9),
# Potassium-40
    K40 = (; β =  4.9548e-10, e = 5.757e-10),
    σK40 =(; β = 0.0134e-10,  e = 0.016e-11),
    SteigerJager1977 = (; β=4.962e-10, e=5.81e-11, K40_K = 0.0001167)
)
end
