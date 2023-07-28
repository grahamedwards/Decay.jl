using Decay
using Documenter

DocMeta.setdocmeta!(Decay, :DocTestSetup, :(using Decay); recursive=true)

makedocs(;
    modules=[Decay],
    authors="Graham Harper Edwards",
    repo="https://github.com/grahamedwards/Decay.jl/blob/{commit}{path}#{line}",
    sitename="Decay.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://grahamedwards.github.io/Decay.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/grahamedwards/Decay.jl",
    devbranch="main",
)
