#=
This file is auto-generated. Do not edit.
=#

#! format: off

"""
    mutable struct TGTypeII <: TurbineGov
        R::Float64
        T1::Float64
        T2::Float64
        τ_limits::MinMax
        P_ref::Float64
        ext::Dict{String, Any}
        states::Vector{Symbol}
        n_states::Int
        internal::InfrastructureSystemsInternal
    end

Parameters of a Turbine Governor Type II.

# Arguments
- `R::Float64`: Droop parameter, validation range: `(0, nothing)`
- `T1::Float64`: Transient gain time constant, validation range: `(0, nothing)`
- `T2::Float64`: Power fraction time constant, validation range: `(0, nothing)`
- `τ_limits::MinMax`: Power into the governor limits
- `P_ref::Float64`: (optional) Reference Power Set-point (pu), validation range: `(0, nothing)`
- `ext::Dict{String, Any}`: (optional) An *ext*ra dictionary for users to add metadata that are not used in simulation, such as latitude and longitude. See [Adding additional fields](@ref).
- `states::Vector{Symbol}`: (**Do not modify.**) The [states](@ref S) of the TGTypeI model are:
	x_g1: lead-lag state
- `n_states::Int`: (**Do not modify.**) TGTypeII has 1 state
- `internal::InfrastructureSystemsInternal`: (**Do not modify.**) PowerSystems.jl internal reference.
"""
mutable struct TGTypeII <: TurbineGov
    "Droop parameter"
    R::Float64
    "Transient gain time constant"
    T1::Float64
    "Power fraction time constant"
    T2::Float64
    "Power into the governor limits"
    τ_limits::MinMax
    "(optional) Reference Power Set-point (pu)"
    P_ref::Float64
    "(optional) An *ext*ra dictionary for users to add metadata that are not used in simulation, such as latitude and longitude. See [Adding additional fields](@ref)."
    ext::Dict{String, Any}
    "(**Do not modify.**) The [states](@ref S) of the TGTypeI model are:
	x_g1: lead-lag state"
    states::Vector{Symbol}
    "(**Do not modify.**) TGTypeII has 1 state"
    n_states::Int
    "(**Do not modify.**) PowerSystems.jl internal reference."
    internal::InfrastructureSystemsInternal
end

function TGTypeII(R, T1, T2, τ_limits, P_ref=1.0, ext=Dict{String, Any}(), )
    TGTypeII(R, T1, T2, τ_limits, P_ref, ext, [:xg], 1, InfrastructureSystemsInternal(), )
end

function TGTypeII(; R, T1, T2, τ_limits, P_ref=1.0, ext=Dict{String, Any}(), states=[:xg], n_states=1, internal=InfrastructureSystemsInternal(), )
    TGTypeII(R, T1, T2, τ_limits, P_ref, ext, states, n_states, internal, )
end

# Constructor for demo purposes; non-functional.
function TGTypeII(::Nothing)
    TGTypeII(;
        R=0,
        T1=0,
        T2=0,
        τ_limits=(min=0.0, max=0.0),
        P_ref=0,
        ext=Dict{String, Any}(),
    )
end

"""Get [`TGTypeII`](@ref) `R`."""
get_R(value::TGTypeII) = value.R
"""Get [`TGTypeII`](@ref) `T1`."""
get_T1(value::TGTypeII) = value.T1
"""Get [`TGTypeII`](@ref) `T2`."""
get_T2(value::TGTypeII) = value.T2
"""Get [`TGTypeII`](@ref) `τ_limits`."""
get_τ_limits(value::TGTypeII) = value.τ_limits
"""Get [`TGTypeII`](@ref) `P_ref`."""
get_P_ref(value::TGTypeII) = value.P_ref
"""Get [`TGTypeII`](@ref) `ext`."""
get_ext(value::TGTypeII) = value.ext
"""Get [`TGTypeII`](@ref) `states`."""
get_states(value::TGTypeII) = value.states
"""Get [`TGTypeII`](@ref) `n_states`."""
get_n_states(value::TGTypeII) = value.n_states
"""Get [`TGTypeII`](@ref) `internal`."""
get_internal(value::TGTypeII) = value.internal

"""Set [`TGTypeII`](@ref) `R`."""
set_R!(value::TGTypeII, val) = value.R = val
"""Set [`TGTypeII`](@ref) `T1`."""
set_T1!(value::TGTypeII, val) = value.T1 = val
"""Set [`TGTypeII`](@ref) `T2`."""
set_T2!(value::TGTypeII, val) = value.T2 = val
"""Set [`TGTypeII`](@ref) `τ_limits`."""
set_τ_limits!(value::TGTypeII, val) = value.τ_limits = val
"""Set [`TGTypeII`](@ref) `P_ref`."""
set_P_ref!(value::TGTypeII, val) = value.P_ref = val
"""Set [`TGTypeII`](@ref) `ext`."""
set_ext!(value::TGTypeII, val) = value.ext = val
