#!/bin/bash
# Shell script to test Revise hot-reloading in Julia
# Usage: ./run_revise_test.sh [N]
#   N = number of iterations (default: 5)

# Set the number of iterations (default to 5 if not provided)
if [ -z "$1" ]; then
    export N_ITERATIONS=5
else
    export N_ITERATIONS=$1
fi

echo "Running Revise test with $N_ITERATIONS iterations..."
echo

# Run the Julia script with Revise
julia revise_test.jl

# Check if the tests passed
if [ $? -eq 0 ]; then
    echo
    echo "========================================"
    echo "SUCCESS: All tests passed!"
    echo "========================================"
    exit 0
else
    echo
    echo "========================================"
    echo "FAILURE: Tests failed!"
    echo "========================================"
    exit 1
fi
