# SmoothNumbers.jl

> Algorithms to generate smooth numbers

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://FedericoStra.github.io/SmoothNumbers.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://FedericoStra.github.io/SmoothNumbers.jl/dev/)
[![Build Status](https://github.com/FedericoStra/SmoothNumbers.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/FedericoStra/SmoothNumbers.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)

See the definition of *smooth number* on
[Wikipedia](https://en.wikipedia.org/wiki/Smooth_number) and
[MathWorld](https://mathworld.wolfram.com/SmoothNumber.html).

## Examples

Compute the first 10 3-smooth numbers, i.e. numbers of the form `2^i * 3^j`:

```julia
julia> using SmoothNumbers

julia> smooth(3, 10)
10-element Vector{Int64}:
  1
  2
  3
  4
  6
  8
  9
 12
 16
 18
```

Compute the first 10 numbers of the form `2^3 * 3^i * 7^i`:

```julia
julia> using SmoothNumbers

julia> with_bases([2, 3, 7], 10)
10-element Vector{Int64}:
  1
  2
  3
  4
  6
  7
  8
  9
 12
 14
 ```
