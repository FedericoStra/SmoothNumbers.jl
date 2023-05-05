module SmoothNumbers

import Primes

export pratt, smooth, with_bases

"""
Computes smooth numbers.
"""
function smooth end

"""
    smooth(k::Integer, n::Integer)

Computes the first `n` `k`-smooth numbers and returns them as a `Vector{typeof(k)}`.
"""
smooth(k::Integer, n::Integer) = smooth(typeof(k), k, n)

"""
    smooth(::Type{T}, k::Integer, n::Integer) where T<:Integer

Computes the first `n` `k`-smooth numbers and returns them as a `Vector{T}`.
"""
function smooth(::Type{T}, k::Integer, n::Integer) where T<:Integer
    primes = convert(Vector{T}, Primes.primes(Int(k)))
    with_bases(primes, n)
end

"""
Computes numbers that can be written as a product of powers of a given set of bases.
"""
function with_bases end

"""
    with_bases(bases::AbstractVector{T}, n::Integer) where T<:Integer

Computes the first `n` numbers that can be written as a product of powers of the `bases`.

The result is a `Vector` with the same element type as `bases`.
"""
function with_bases(bases::AbstractVector{T}, n::Integer) where T<:Integer
    if n <= 0
        return T[]
    end

    num_bases = length(bases)

    if isempty(bases)
        return T[1]
    end

    if num_bases == 1
        v = Vector{T}(undef, n)
        x = T(1)
        v[1] = x
        for write_index in 2:n
            x *= bases[1]
            v[write_index] = x
        end
        return v
    end

    v = Vector{T}(undef, n)
    indices = ones(Int, num_bases)
    v[1] = T(1)

    for write_index in 2:n
        new = minimum(p * v[j] for (p, j) in zip(bases, indices))
        v[write_index] = new
        for j in eachindex(bases)
            if bases[j] * v[indices[j]] == new
                indices[j] += 1
            end
        end
    end

    v
end

"""
Computes 3-smooth numbers.
"""
function pratt end

"""
    pratt(n::Integer)

Computes the first `n` 3-smooth numbers and returns them as a `Vector{Int}`.
"""
pratt(n::Integer) = pratt(Int, n)

"""
    pratt(::Type{T}, n::Integer) where T<:Integer

Computes the first `n` 3-smooth numbers and returns them as a `Vector{T}`.
"""
function pratt(::Type{T}, n::Integer) where T<:Integer
    if n <= 0
        return T[]
    end

    v = T[1]
    two = 1
    three = 1
    for _ in 1:n-1
        times_two = T(2) * v[two]
        times_three = T(3) * v[three]
        if times_two < times_three
            push!(v, times_two)
            two += 1
        elseif times_two == times_three
            push!(v, times_two)
            two += 1
            three += 1
        else
            push!(v, times_three)
            three += 1
        end
    end
    v
end

end
