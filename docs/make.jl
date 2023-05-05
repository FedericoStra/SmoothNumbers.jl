using SmoothNumbers
using Documenter

DocMeta.setdocmeta!(SmoothNumbers, :DocTestSetup, :(using SmoothNumbers); recursive=true)

makedocs(;
    modules=[SmoothNumbers],
    authors="Federico Stra <stra.federico@gmail.com> and contributors",
    repo="https://github.com/FedericoStra/SmoothNumbers.jl/blob/{commit}{path}#{line}",
    sitename="SmoothNumbers.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://FedericoStra.github.io/SmoothNumbers.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/FedericoStra/SmoothNumbers.jl",
    devbranch="master",
)
