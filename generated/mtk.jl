using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
using OrdinaryDiffEq

function MainSystem(;name)
    @variables x(t)=1
    return System([D(x)~0], t; name)
end

