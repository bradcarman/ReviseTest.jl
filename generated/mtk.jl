using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
using OrdinaryDiffEq

@component function MainSystem(;name)
    @variables x(t)=2
    return System([D(x)~0], t; name)
end

