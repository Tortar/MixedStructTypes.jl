
module DynamicSumTypes

using ExprTools
using MacroTools
using SumTypes

export @sum_structs
export @pattern
export kindof
export allkinds
export kindconstructor

const __modules_cache__ = Set{Module}()
const __variants_types_cache__ = Dict{Module, Dict{Symbol, Symbol}}()
const __variants_types_with_params_cache__ = Dict{Module, Dict{Symbol, Vector{Any}}}()

"""
    kindof(instance)

Return a symbol representing the conceptual type of an instance:

```julia
julia> @sum_structs AB begin
           struct A x::Int end
           struct B y::Int end
       end

julia> a = A(1);

julia> kindof(a)
:A
```
"""
function kindof end

"""
    allkinds(type)

Return a `Tuple` containing all kinds associated with the overarching 
type defined with `@sum_structs`

```julia
julia> @sum_structs AB begin
           struct A x::Int end
           struct B y::Int end
       end

julia> allkinds(AB)
(:A, :B)
```
"""
function allkinds end

"""
    kindconstructor(instance)

Return the constructor of an instance:

```julia
julia> @sum_structs AB begin
           struct A x::Int end
           struct B y::Int end
       end

julia> a = A(1);

julia> kindconstructor(a)
A
```
"""
function kindconstructor end

"""
    finalize_patterns()

When `@pattern` is used inside a module or a script, it is 
needed to define at some points all the functions it constructed.
this can be done by invoking `finalize_patterns()`.

If you don't need to call any of them before the functions 
are imported, you can just put this invocation at the end of
the module. 

Notice that every `Module` using `@pattern` has its own definition of 
`finalize_patterns`.
"""
function finalize_patterns end

include("SumStructsOnFields.jl")
include("SumStructsOnTypes.jl")
include("Pattern.jl")
include("precompile.jl")

end