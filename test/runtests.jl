using Test
using ReviseTest
using ModelingToolkit
using OrdinaryDiffEq

@mtkcompile sys = ReviseTest.MainSystem()
prob = ODEProblem(sys, [], (0, 1))
sol = solve(prob)
@test sol(1.0; idxs=sys.x) == 1.0
