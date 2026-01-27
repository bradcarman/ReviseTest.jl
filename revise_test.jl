using Revise
using Pkg

# Activate the current package
Pkg.activate(".")

# Load the package in dev mode so Revise can track it
using ReviseTest
using Test
using ModelingToolkit
using OrdinaryDiffEq

# Number of iterations
N = parse(Int, get(ENV, "N_ITERATIONS", "5"))
sleep_time = parse(Float64, get(ENV, "SLEEP_TIME", "0"))

println("Starting Revise test loop for $N iterations, JULIA_REVISE=$(ENV["JULIA_REVISE"]), sleep=$sleep_time [s]...")

# Initial test run
println("\n=== Initial test (i=1) ===")
include("test/runtests.jl")
println("✓ Initial test passed")

# Loop from i=2 to i=N+1
for i in 2:N
    println("\n=== Iteration $i ===")

    # Step 1: Delete generated/mtk.jl
    mtk_file = "generated/mtk.jl"
    if isfile(mtk_file)
        rm(mtk_file)
        println("Deleted $mtk_file")
    end

    # Step 2: Recreate generated/mtk.jl with x(t)=$i
    new_content = """
        using ModelingToolkit
        using ModelingToolkit: t_nounits as t, D_nounits as D
        using OrdinaryDiffEq

        @component function MainSystem(;name)
            @variables x(t)=$i
            return System([D(x)~0], t; name)
        end

        """
    write(mtk_file, new_content)
    println("Recreated $mtk_file with x(t)=$i")

    # Step 3: Modify test/runtests.jl to test for the new value
    test_content = """
        using Test
        using ReviseTest
        using ModelingToolkit
        using OrdinaryDiffEq

        @mtkcompile sys = ReviseTest.MainSystem()
        prob = ODEProblem(sys, [], (0, 1))
        sol = solve(prob)
        @test sol(1.0; idxs=sys.x) == $i.0
        """
    write("test/runtests.jl", test_content)
    println("Modified test/runtests.jl to expect x == $i.0")



    # If JULIA_REVISE is set to "off", manually trigger revise()
    # if get(ENV, "JULIA_REVISE", "auto") == "off"
    #     println("JULIA_REVISE=off: Running revise()...")
    #     revise()
    # else
    #     # Give Revise a moment to detect changes
    #     sleep(2)
    # end   
    sleep(sleep_time)
    revise()

    # Step 4: Run the tests
    try
        include("test/runtests.jl")
        println("✓ Test passed for i=$i")
    catch e
        println("✗ Test failed for i=$i")
        println("Error: $e")
        exit(1)
    end
end

println("\n=== All $N iterations completed successfully! ===")
