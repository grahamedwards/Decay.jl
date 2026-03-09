module Decay

include("equations.jl")
include("activity.jl")
export RadUnit, Becquerel, Curie, DPM, PerYear, Ci, Bq


"""

```
Decay.λ
Decay.lambda
```

A `NamedTuple` library containing the decay constants and uncertainties of a selection of useful radiochronometric isotopes.

Decay constant central tendencies (typically means) are returned by providing the element (e.g. `U`) and isotope (e.g. `238`), as in `λ.U238`. To call the 1s uncertainty (standard error of the mean), give the same value with a `s` prefix, as in `λ.sU238`.

In most cases, I try to cite the original publications containing accepted measurements. In a few cases, I use compilations from reviews. 


isotope(s) | reference | doi | note | 
:--------- | :-------- | :-- | ---:
²³⁸U, ²³⁵U | Jaffey+ 1991 | [10.1103/PhysRevC.4.1889](https://doi.org/10.1103/PhysRevC.4.1889) |
²³²Th | Holden 1990 | [10.1351/pac199062050941](https://doi.org/10.1351/pac199062050941) | [1]
²³⁴U, ²³⁰Th | Cheng+ 2013 | [10.1016/j.epsl.2013.04.006](https://doi.org/10.1016/j.epsl.2013.04.006)
²²⁶Ra | Holden 1990 | [10.1351/pac199062050941](https://doi.org/10.1351/pac199062050941) |
⁴⁰K | Renne+ 2011 | [10.1016/j.gca.2011.06.021](https://doi.org/10.1016/j.gca.2011.06.021) | [2]
²³³U | Wikipedia | [Isotopes of Uranium](https://en.wikipedia.org/wiki/Isotopes_of_uranium) |
²³⁶U | Wikipedia | [Isotopes of Uranium](https://en.wikipedia.org/wiki/Isotopes_of_uranium)|
²²⁹Th | compilation | [SRM 4328d certificate](https://tsapps.nist.gov/srmext/certificates/4328d.pdf) |

[1] This value is similar to the often-used value of Le Roux & Glendenin 1963 (1.40 ± 0.007 Gy). Audi+ 1997 ( doi: [10.1016/S0375-9474(97)00482-X](https://doi.org/10.1016/S0375-9474(97)00482-X)) reports 14.05 ± 0.04 Gy and references Bonetti+ 1995 (doi: [https://doi.org/10.1103/PhysRevC.51.2530, which does not appear to report a λ for α-decay.

[2] `K40` and `sK40` are NamedTuples containing fields `β` and `e` for the branched decay. The total decay constant is obtained with `sum(λ.K40)`. I also include the now deprecated decay constants of Steiger & Jager 1977 (doi: [10.1016/0012-821X(77)90060-7](https://doi.org/10.1016/0012-821X(77)90060-7)). See also Renne+ 2010 (doi: [10.1016/j.gca.2010.06.017](https://doi.org/10.1016/j.gca.2010.06.017)).

"""
const lambda = λ = (; 
# Uranium series
    U238 = decayconstant(4.4683e9),
    sU238 = decayconstant(2.4e6),
    U234 = decayconstant(245_620),
    sU234 = decayconstant(130),
    Th230 = decayconstant(75_584),
    sTh230 = decayconstant(55),
    Ra226 = decayconstant(1599),
    sRa226 = decayconstant(4), 
# Actinitde series
    U235 = decayconstant(703.81e6),
    sU235 = decayconstant(480_000),

# Thorium series
    Th232 = decayconstant(14.0e9),
    sTh232 = decayconstant(0.01e9),
# Potassium-40
    K40 = (; β =  4.9548e-10, e = 5.757e-11),
    sK40 =(; β = 0.0134e-10,  e = 0.016e-11),
    SteigerJager1977 = (; β=4.962e-10, e=5.81e-11, K40_K = 0.0001167),
# Synthetic
    U233 = decayconstant(159190),
    sU233 = decayconstant(150),
    U236 = decayconstant(2.342e7),
    sU236 = decayconstant(4e4),
    Th229 = decayconstant(7889), # unweighted mean used in SRM 4328d calibration 
    sTh229 = decayconstant(24),
)

end
