module pkgExample

export plusone

greet() = print("Hello World!")

plusone(x::Int) = x + 1

include("sumRand.jl")

end # module
