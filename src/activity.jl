###########################
#  Activity Calculations  #
###########################


"""

    RadUnit

Supertype for all radioactivity units. Any `RadUnit` is callable by its single field `n` or by calling it as a function (see examples below). Converting between types is accomplished by inputting any `RadUnit` type into the constructor of another `RadUnit` type. 

See also: [`Becquerel`](@ref), [`Curie`](@ref), [`DPM`](@ref), [`PerYear`](@ref).

## Examples

    julia> r = Becquerel(3)
    Becquerel(3.0)

    julia> r.n, r()
    (3.0, 3.0)

"""
abstract type RadUnit end

(x::RadUnit)() = x.n


"""

    Becquerel

A `struct` denoting becquerels, the SI unit of radioactivity, defined as an activity of one disintegration per second (s⁻¹). Learn more: https://en.wikipedia.org/wiki/Becquerel. Also converts any [`RadUnit`](@ref) to a Bq.

    julia> Becquerel(Curie(1))
    Becquerel(3.7e10)

"""
struct Becquerel <: RadUnit
    n::Float64
end


"""

    Curie

A `struct` denoting curies, a non-SI unit of radioactivity named in honor of Marie Skłodowska-Curie.  Originally defined by radon emnation from a gram of radium, the curie (Ci) is now defined 1 Ci = 3.7 × 10¹⁰ Bq. Learn more: https://en.wikipedia.org/wiki/Curie_(unit). 

Also converts any [`RadUnit`](@ref) to a Ci.

    julia> Curie(Becquerel(3.7e10))
    Curie(1.0)

"""
struct Curie <: RadUnit
    n::Float64
end

"""

    DPM

A `struct` denoting disintegrations per minute (dpm), a non-SI unit of radioactivity.

Also converts any [`RadUnit`](@ref) to a dpm.

    julia> DPM(Becquerel(1))
    DPM(60.0)

"""
struct DPM <: RadUnit 
    n::Float64
end


"""

    PerYear

A `struct` denoting disintegrations per year, a non-SI unit of radioactivity.

Also converts any [`RadUnit`](@ref) to a y⁻¹.

    julia> PerYear(Curie(1))
    PerYear(1172.459249119071)

"""
struct PerYear <: RadUnit
    n::Float64
end

const secondsperyear = float(31557600)
const secondsperminute = float(60)
const bqperci = 3.7e10

Becquerel(x::Becquerel) = x 
Becquerel(x::Curie) = Becquerel(x.n * bqperci )
Becquerel(x::PerYear) = Becquerel(x.n / secondsperyear)
Becquerel(x::DPM) = Becquerel(x.n / secondsperminute)

Curie(x::Curie) = x
Curie(x::Becquerel) = Curie( x.n / bqperci)
Curie(x::PerYear) = Curie(Becquerel(x))
Curie(x::DPM) = Curie(Becquerel(x))

DPM(x::DPM) = x
DPM(x::Becquerel) = DPM(secondsperminute * x.n)
DPM(x::Curie) = DPM(Becquerel(x))
DPM(x::PerYear) = DPM(Becquerel(x))

PerYear(x::PerYear) = x
PerYear(x::Becquerel) = PerYear(x.n * secondsperyear)
PerYear(x::DPM) = PerYear(Becquerel(x))
PerYear(x::Curie) = PerYear(Becquerel(x))


Ci(x::RadUnit) = Curie(x)
Ci(x::Number) = Curie(x)

Bq(x::RadUnit) = Becquerel(x)
Bq(x::Number) = Becquerel(x)


"""

    act2conc(A, lambda, atomic_mass)

    Convert a per gram activity to a concentration of radioisotope of interest, given its activity (as a [`RadUnit`](@ref)), its decay constant (a⁻¹, see [`Decay.λ`](@ref)), and its `atomic_mass` (in amu or g/mol). 
    
"""
function act2conc(A::RadUnit, lambda::Float64, atomic_mass::Number)
    atoms_per_gram = PerYear(A)() / float(lambda) # convert to per year decays and divide by decay constant, i.e. N = -λ/ΔN
    g_per_atom = float(atomic_mass) / 6.02214076e23 # convert the atomic mass to the g/atom using Avogadro's Number. 
    atoms_per_gram * g_per_atom 
end

"""

    conc2act(C, lambda, atomic_mass)

    Convert a  concentration of a radioisotope to a Bq/g activity, given its concentration (g/g), its decay constant (a⁻¹, see [`Decay.λ`](@ref)), and its `atomic_mass` (in amu or g/mol). 
    
"""
function conc2act(C::Number, lambda::Float64, atomic_mass::Number)
    g_per_atom  = float(atomic_mass) / 6.02214076e23 # convert the atomic mass to the g/atom using Avogadro's Number. 
    atoms_per_gram = float(C) / g_per_atom # convert gᵣ/gₜ to atoms/gₜ using the gᵣ/atomᵣ
    Becquerel(PerYear(float(lambda) * atoms_per_gram)) # calculate activity in Bq/g, i.e. ΔN = -λN
end
