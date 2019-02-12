# BLAS for Nim

This is a Nim wrapper for the [BLAS](http://www.netlib.org/blas/) routines.

You can `import nimblas/cblas` to use the standard BLAS interface, or just
`import nimblas` for a version that is more Nim-friendly.

The Nim version removes the prefixes and uses dispatch based on types instead.
This means that, for instance, both `cblas_saxpy` and `cblas_daxpy` become
simply `axpy`, and the correct version is chosen by checking the size of
parameters at the usage site.

Only a subset of BLAS is available under `nimblas`, with more operations added
on necessity.

For a higher-level linear algebra library based on this, check out
[neo](http://unicredit.github.io/neo/).

## Linking BLAS implementations

The library requires to link some BLAS implementation to perform the actual
linear algebra operations. By default, it tries to link whatever is the default
system-wide BLAS implementation.

You can link against a different BLAS implementation by a combination of:

* changing the path for linked libraries (use
  [`--clibdir`](https://nim-lang.org/docs/nimc.html#compiler-usage-command-line-switches)
  for this)
* using the `--define:blas` flag. By default, the system tries to load a BLAS
  library called `blas`, which translates into something called `blas.dll`
  or `libblas.so` according to the underling operating system. To link,
  say, the library `libopenblas.so.3` on Linux, you should pass to Nim the
  option `--define:blas=openblas`.

For instance, the Linux Arch distribution and its derivatives (such as Manjaro)
expose the C API for BLAS inside a library called `libcblas.so` (unlike most
other distributions that put it into `libblas.so`). In this case, you can make
use of this library with the flag `--define:blas=cblas`. For more examples, see
the tasks inside [nimblas.nimble](https://github.com/unicredit/nimblas/blob/master/nimblas.nimble).

(Previously there was a more ad hoc mechanism using flags called `-d:atlas`,
`-d:openblas` or `-d:mkl`, which is deprecated as of NimBLAS 0.2.)

Packages for various BLAS implementations are available from the package
managers of many Linux distributions. On OSX one can add the brew formulas
from [Homebrew Science](https://github.com/Homebrew/homebrew-science), such
as `brew install homebrew/science/openblas`.

You may also need to add suitable paths for the includes and library dirs.
On OSX, this should do the trick

```nim
switch("clibdir", "/usr/local/opt/openblas/lib")
switch("cincludes", "/usr/local/opt/openblas/include")
```

If you have problems with MKL, you may want to link it statically. Just pass
the options

```nim
--dynlibOverride:mkl_intel_lp64
--passL:${PATH_TO_MKL}/libmkl_intel_lp64.a
```

to enable static linking.