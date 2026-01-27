# ReviseTest.jl
This repo is to demonstrate and test Revise.jl under 2 modes, auto or manual Revise mode.  The script `run_revise_test` is given for both Windows and Linux.  To run on Windows...

```batch
run_revise_test.bat [N] [REVISE_MODE]
```

Or on Linux...

```bash
./run_revise_test.sh [N] [REVISE_MODE]
```

# Sample Runs
From my own tests, `i` rarely is able to exceed 3 on Windows or Linux.

## Windows - Auto
```
C:\Work\Packages\ReviseTest>run_revise_test.bat 5     
Running Revise test with 5 iterations (JULIA_REVISE=auto)...

  Activating project at `C:\Work\Packages\ReviseTest`
Precompiling ReviseTest finished.
  1 dependency successfully precompiled in 13 seconds. 462 already precompiled.
Starting Revise test loop for 5 iterations...

=== Initial test (i=1) ===
✓ Initial test passed

=== Iteration 2 ===
Deleted generated/mtk.jl
Recreated generated/mtk.jl with x(t)=2
Modified test/runtests.jl to expect x == 2.0
Test Failed at C:\Work\Packages\ReviseTest\test\runtests.jl:9
  Expression: sol(1.0; idxs = sys.x) == 2.0
   Evaluated: 1.0 == 2.0

✗ Test failed for i=2
Error: LoadError("C:\\Work\\Packages\\ReviseTest\\test\\runtests.jl", 9, Test.FallbackTestSetException("There was an error during testing"))

========================================
FAILURE: Tests failed!
========================================
```

## Windows - Manual
```
C:\Work\Packages\ReviseTest>run_revise_test.bat 5 off
Running Revise test with 5 iterations (JULIA_REVISE=off)...

  Activating project at `C:\Work\Packages\ReviseTest`
Precompiling ReviseTest finished.
  1 dependency successfully precompiled in 14 seconds. 462 already precompiled.
Starting Revise test loop for 5 iterations...

=== Initial test (i=1) ===
✓ Initial test passed

=== Iteration 2 ===
Deleted generated/mtk.jl
Recreated generated/mtk.jl with x(t)=2
Modified test/runtests.jl to expect x == 2.0
JULIA_REVISE=off: Running revise()...
✓ Test passed for i=2

=== Iteration 3 ===
Deleted generated/mtk.jl
Recreated generated/mtk.jl with x(t)=3
Modified test/runtests.jl to expect x == 3.0
JULIA_REVISE=off: Running revise()...
Test Failed at C:\Work\Packages\ReviseTest\test\runtests.jl:9
  Expression: sol(1.0; idxs = sys.x) == 3.0
   Evaluated: 2.0 == 3.0

✗ Test failed for i=3
Error: LoadError("C:\\Work\\Packages\\ReviseTest\\test\\runtests.jl", 9, Test.FallbackTestSetException("There was an error during testing"))

========================================
FAILURE: Tests failed!
========================================
```

## Linux - Auto
```
bradcarman@demeter2:~/ReviseTest.jl$ ./run_revise_test.sh
Running Revise test with 5 iterations (JULIA_REVISE=auto)...

  Activating project at `~/ReviseTest.jl`
Precompiling ReviseTest finished.
  1 dependency successfully precompiled in 8 seconds. 462 already precompiled.
Starting Revise test loop for 5 iterations...

=== Initial test (i=1) ===
✓ Initial test passed

=== Iteration 2 ===
Deleted generated/mtk.jl
Recreated generated/mtk.jl with x(t)=2
Modified test/runtests.jl to expect x == 2.0
Test Failed at /home/bradcarman/ReviseTest.jl/test/runtests.jl:9
  Expression: sol(1.0; idxs = sys.x) == 2.0
   Evaluated: 3.0 == 2.0

✗ Test failed for i=2
Error: LoadError("/home/bradcarman/ReviseTest.jl/test/runtests.jl", 9, Test.FallbackTestSetException("There was an error during testing"))

========================================
FAILURE: Tests failed!
========================================
```

## Linux - Manual
```
bradcarman@demeter2:~/ReviseTest.jl$ ./run_revise_test.sh 5 off
Running Revise test with 5 iterations (JULIA_REVISE=off)...

  Activating project at `~/ReviseTest.jl`
Precompiling ReviseTest finished.
  1 dependency successfully precompiled in 9 seconds. 462 already precompiled.
Starting Revise test loop for 5 iterations...

=== Initial test (i=1) ===
✓ Initial test passed

=== Iteration 2 ===
Deleted generated/mtk.jl
Recreated generated/mtk.jl with x(t)=2
Modified test/runtests.jl to expect x == 2.0
JULIA_REVISE=off: Running revise()...
✓ Test passed for i=2

=== Iteration 3 ===
Deleted generated/mtk.jl
Recreated generated/mtk.jl with x(t)=3
Modified test/runtests.jl to expect x == 3.0
JULIA_REVISE=off: Running revise()...
Test Failed at /home/bradcarman/ReviseTest.jl/test/runtests.jl:9
  Expression: sol(1.0; idxs = sys.x) == 3.0
   Evaluated: 2.0 == 3.0

✗ Test failed for i=3
Error: LoadError("/home/bradcarman/ReviseTest.jl/test/runtests.jl", 9, Test.FallbackTestSetException("There was an error during testing"))

========================================
FAILURE: Tests failed!
========================================
```