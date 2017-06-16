# BLAS for Nim

This is a Nim wrapper for the [BLAS](http://www.netlib.org/blas/) routines.

You can `import cblas` to use the standard BLAS interface, or `import nimblas`
for a version that is more Nim-friendly.

The Nim version removes the prefixes and uses dispatch based on types instead.
This means that, for instance, both `cblas_saxpy` and `cblas_daxpy` become
simply `axpy`, and the correct version is chosen by checking the size of
parameters at the usage site.

Only a subset of BLAS is available under `nimblas`, with more operations added
on necessity.

For a higher-level linear algebra library based on this, check out
[linalg](http://unicredit.github.io/linear-algebra/).

## Linking BLAS implementations

The library requires to link some BLAS implementation to perform the actual
linear algebra operations. By default, it tries to link whatever is the default
system-wide BLAS implementation.

A few compile flags are available to link specific BLAS implementations

    -d:atlas
    -d:openblas
    -d:mkl
    -d:mkl -d:threaded

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