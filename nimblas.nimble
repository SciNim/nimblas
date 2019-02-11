version       = "0.2.2"
author        = "Andrea Ferretti"
description   = "BLAS interface for Nim"
license       = "Apache2"
skipDirs      = @["tests"]

requires "nim >= 0.11.2"

proc configForTests() =
  --hints: off
  --linedir: on
  --stacktrace: on
  --linetrace: on
  --debuginfo
  --path: "."
  --run

task test, "run NimBLAS tests":
  configForTests()
  setCommand "c", "tests/test.nim"

task testopenblas, "run NimBLAS tests with openBLAS":
  configForTests()
  --define:"blas=openblas"
  setCommand "c", "tests/test.nim"

task testatlas, "run NimBLAS tests with ATLAS":
  configForTests()
  --define:"blas=cblas"
  setCommand "c", "tests/test.nim"

task testmkl, "run NimBLAS tests with MKL":
  configForTests()
  --define:"blas=mkl_intel_lp64"
  --clibdir: "/opt/intel/mkl/lib/intel64"
  --passl: "/opt/intel/mkl/lib/intel64/libmkl_intel_lp64.a"
  --passl: "-lmkl_core"
  --passl: "-lmkl_sequential"
  --passl: "-lpthread"
  --passl: "-lm"
  --dynlibOverride:mkl_intel_lp64
  setCommand "c", "tests/test.nim"

task testmklthreaded, "run NimBLAS tests with MKL threaded":
  configForTests()
  --define: "blas=mkl_intel_lp64"
  --clibdir: "/opt/intel/mkl/lib/intel64"
  --passl: "/opt/intel/mkl/lib/intel64/libmkl_intel_lp64.a"
  --passl: "-lmkl_core"
  --passl: "-lmkl_gnu_thread"
  --passl: "-lgomp"
  --passl: "-lm"
  --dynlibOverride:mkl_intel_lp64
  setCommand "c", "tests/test.nim"

task tests, "run tests with all BLAS versions":
  exec("nimble test")
  exec("nimble testopenblas")
  exec("nimble testatlas")
  exec("nimble testmkl")
  exec("nimble testmklthreaded")