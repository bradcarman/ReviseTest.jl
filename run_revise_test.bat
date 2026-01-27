@echo off
REM Batch script to test Revise hot-reloading in Julia
REM Usage: run_revise_test.bat [N]
REM   N = number of iterations (default: 5)

setlocal

REM Set the number of iterations (default to 5 if not provided)
if "%~1"=="" (
    set N_ITERATIONS=5
) else (
    set N_ITERATIONS=%~1
)

echo Running Revise test with %N_ITERATIONS% iterations...
echo.

REM Run the Julia script with Revise
julia revise_test.jl

REM Check if the tests passed
if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================
    echo SUCCESS: All tests passed!
    echo ========================================
    exit /b 0
) else (
    echo.
    echo ========================================
    echo FAILURE: Tests failed!
    echo ========================================
    exit /b 1
)
