using Test
using ErrorCorp
using ModelingToolkit
using OrdinaryDiffEq

@mtkcompile sys = ErrorCorp.MainSystem()
prob = ODEProblem(sys, [], (0, 1))
sol = solve(prob)
@test sol(1.0; idxs=sys.x) == 2.0
