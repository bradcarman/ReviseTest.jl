#!/bin/bash
# Shell script to test Revise hot-reloading in Julia
# Usage: ./run_revise_test.sh [N] [REVISE_MODE]  [SLEEP_TIME]
#   N = number of iterations (default: 5)
#   REVISE_MODE = auto or off (default: auto)
#   SLEEP_TIME = sleep time before calling revise() (default: 0)

# Set the number of iterations (default to 5 if not provided)
if [ -z "$1" ]; then
    export N_ITERATIONS=5
else
    export N_ITERATIONS=$1
fi

# Set the JULIA_REVISE mode (default to auto if not provided)
if [ -z "$2" ]; then
    export JULIA_REVISE=auto
else
    export JULIA_REVISE=$2
fi

if [ -z "$3" ]; then
    export SLEEP_TIME=0
else
    export SLEEP_TIME=$3
fi

# Reset the package
git restore generated/mtk.jl
git restore test/runtests.jl

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
