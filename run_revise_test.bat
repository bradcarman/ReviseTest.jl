@echo off
REM Batch script to test Revise hot-reloading in Julia
REM Usage: run_revise_test.bat [N] [REVISE_MODE]
REM   N = number of iterations (default: 5)
REM   REVISE_MODE = auto or off (default: auto)

setlocal

REM Set the number of iterations (default to 5 if not provided)
if "%~1"=="" (
    set N_ITERATIONS=5
) else (
    set N_ITERATIONS=%~1
)

REM Set the JULIA_REVISE mode (default to auto if not provided)
if "%~2"=="" (
    set JULIA_REVISE=auto
) else (
    set JULIA_REVISE=%~2
)

echo Running Revise test with %N_ITERATIONS% iterations (JULIA_REVISE=%JULIA_REVISE%)...
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
