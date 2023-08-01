# Decay

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://grahamedwards.github.io/Decay.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://grahamedwards.github.io/Decay.jl/dev/)
[![Build Status](https://github.com/grahamedwards/Decay.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/grahamedwards/Decay.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/grahamedwards/Decay.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/grahamedwards/Decay.jl)


🚧 Under Construction 🚧

An ultralight package to stash useful radiometric decay constants for geochronology and cosmochronology, along with useful decay and ingrowth equations. 

To add Decay.jl to your Julia environment, just type `]` into the Julia REPL to enter the built-in package manager and then type `add https://github.com/grahamedwards/Decay.jl` and hit enter.

After installing, you can load the package with `using Decay`.

Decay only exports a NamedTuple `λ`, which contains decay constants. Within the package scope, there are a few helpful equations: `D`,`D_`, `N`, `lambda`, and `halflife`. Check out the documentation to learn more. 

I will continue adding to these as free-time permits 😵‍💫