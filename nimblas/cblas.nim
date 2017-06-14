include private/common

# Allow the use in C++ code.

#
#  Enumerated and derived types
#

type
  CBLAS_INDEX* = int

type
  CBLAS_ORDER* {.size: sizeof(cint).} = enum
    CblasRowMajor = 101, CblasColMajor = 102


type
  CBLAS_TRANSPOSE* {.size: sizeof(cint).} = enum
    CblasNoTrans = 111, CblasTrans = 112, CblasConjTrans = 113


type
  CBLAS_UPLO* {.size: sizeof(cint).} = enum
    CblasUpper = 121, CblasLower = 122


type
  CBLAS_DIAG* {.size: sizeof(cint).} = enum
    CblasNonUnit = 131, CblasUnit = 132


type
  CBLAS_SIDE* {.size: sizeof(cint).} = enum
    CblasLeft = 141, CblasRight = 142


#
#  ===========================================================================
#  Prototypes for level 1 BLAS functions (complex are recast as routines)
#  ===========================================================================
#

proc sdsdot*(N: cint; alpha: cfloat; X: ptr cfloat; incX: cint; Y: ptr cfloat; incY: cint): cfloat {.
    importc: "cblas_sdsdot", dynlib: libName.}
proc dsdot*(N: cint; X: ptr cfloat; incX: cint; Y: ptr cfloat; incY: cint): cdouble {.
    importc: "cblas_dsdot", dynlib: libName.}
proc sdot*(N: cint; X: ptr cfloat; incX: cint; Y: ptr cfloat; incY: cint): cfloat {.
    importc: "cblas_sdot", dynlib: libName.}
proc ddot*(N: cint; X: ptr cdouble; incX: cint; Y: ptr cdouble; incY: cint): cdouble {.
    importc: "cblas_ddot", dynlib: libName.}
#
#  Functions having prefixes Z and C only
#

proc cdotu_sub*(N: cint; X: pointer; incX: cint; Y: pointer; incY: cint; dotu: pointer) {.
    importc: "cblas_cdotu_sub", dynlib: libName.}
proc cdotc_sub*(N: cint; X: pointer; incX: cint; Y: pointer; incY: cint; dotc: pointer) {.
    importc: "cblas_cdotc_sub", dynlib: libName.}
proc zdotu_sub*(N: cint; X: pointer; incX: cint; Y: pointer; incY: cint; dotu: pointer) {.
    importc: "cblas_zdotu_sub", dynlib: libName.}
proc zdotc_sub*(N: cint; X: pointer; incX: cint; Y: pointer; incY: cint; dotc: pointer) {.
    importc: "cblas_zdotc_sub", dynlib: libName.}
#
#  Functions having prefixes S D SC DZ
#

proc snrm2*(N: cint; X: ptr cfloat; incX: cint): cfloat {.importc: "cblas_snrm2",
    dynlib: libName.}
proc sasum*(N: cint; X: ptr cfloat; incX: cint): cfloat {.importc: "cblas_sasum",
    dynlib: libName.}
proc dnrm2*(N: cint; X: ptr cdouble; incX: cint): cdouble {.importc: "cblas_dnrm2",
    dynlib: libName.}
proc dasum*(N: cint; X: ptr cdouble; incX: cint): cdouble {.importc: "cblas_dasum",
    dynlib: libName.}
proc scnrm2*(N: cint; X: pointer; incX: cint): cfloat {.importc: "cblas_scnrm2",
    dynlib: libName.}
proc scasum*(N: cint; X: pointer; incX: cint): cfloat {.importc: "cblas_scasum",
    dynlib: libName.}
proc dznrm2*(N: cint; X: pointer; incX: cint): cdouble {.importc: "cblas_dznrm2",
    dynlib: libName.}
proc dzasum*(N: cint; X: pointer; incX: cint): cdouble {.importc: "cblas_dzasum",
    dynlib: libName.}
#
#  Functions having standard 4 prefixes (S D C Z)
#

proc isamax*(N: cint; X: ptr cfloat; incX: cint): CBLAS_INDEX {.importc: "cblas_isamax",
    dynlib: libName.}
proc idamax*(N: cint; X: ptr cdouble; incX: cint): CBLAS_INDEX {.importc: "cblas_idamax",
    dynlib: libName.}
proc icamax*(N: cint; X: pointer; incX: cint): CBLAS_INDEX {.importc: "cblas_icamax",
    dynlib: libName.}
proc izamax*(N: cint; X: pointer; incX: cint): CBLAS_INDEX {.importc: "cblas_izamax",
    dynlib: libName.}
#
#  ===========================================================================
#  Prototypes for level 1 BLAS routines
#  ===========================================================================
#
#
#  Routines with standard 4 prefixes (s, d, c, z)
#

proc sswap*(N: cint; X: ptr cfloat; incX: cint; Y: ptr cfloat; incY: cint) {.
    importc: "cblas_sswap", dynlib: libName.}
proc scopy*(N: cint; X: ptr cfloat; incX: cint; Y: ptr cfloat; incY: cint) {.
    importc: "cblas_scopy", dynlib: libName.}
proc saxpy*(N: cint; alpha: cfloat; X: ptr cfloat; incX: cint; Y: ptr cfloat; incY: cint) {.
    importc: "cblas_saxpy", dynlib: libName.}
proc dswap*(N: cint; X: ptr cdouble; incX: cint; Y: ptr cdouble; incY: cint) {.
    importc: "cblas_dswap", dynlib: libName.}
proc dcopy*(N: cint; X: ptr cdouble; incX: cint; Y: ptr cdouble; incY: cint) {.
    importc: "cblas_dcopy", dynlib: libName.}
proc daxpy*(N: cint; alpha: cdouble; X: ptr cdouble; incX: cint; Y: ptr cdouble; incY: cint) {.
    importc: "cblas_daxpy", dynlib: libName.}
proc cswap*(N: cint; X: pointer; incX: cint; Y: pointer; incY: cint) {.
    importc: "cblas_cswap", dynlib: libName.}
proc ccopy*(N: cint; X: pointer; incX: cint; Y: pointer; incY: cint) {.
    importc: "cblas_ccopy", dynlib: libName.}
proc caxpy*(N: cint; alpha: pointer; X: pointer; incX: cint; Y: pointer; incY: cint) {.
    importc: "cblas_caxpy", dynlib: libName.}
proc zswap*(N: cint; X: pointer; incX: cint; Y: pointer; incY: cint) {.
    importc: "cblas_zswap", dynlib: libName.}
proc zcopy*(N: cint; X: pointer; incX: cint; Y: pointer; incY: cint) {.
    importc: "cblas_zcopy", dynlib: libName.}
proc zaxpy*(N: cint; alpha: pointer; X: pointer; incX: cint; Y: pointer; incY: cint) {.
    importc: "cblas_zaxpy", dynlib: libName.}
#
#  Routines with S and D prefix only
#

proc srotg*(a: ptr cfloat; b: ptr cfloat; c: ptr cfloat; s: ptr cfloat) {.
    importc: "cblas_srotg", dynlib: libName.}
proc srotmg*(d1: ptr cfloat; d2: ptr cfloat; b1: ptr cfloat; b2: cfloat; P: ptr cfloat) {.
    importc: "cblas_srotmg", dynlib: libName.}
proc srot*(N: cint; X: ptr cfloat; incX: cint; Y: ptr cfloat; incY: cint; c: cfloat; s: cfloat) {.
    importc: "cblas_srot", dynlib: libName.}
proc srotm*(N: cint; X: ptr cfloat; incX: cint; Y: ptr cfloat; incY: cint; P: ptr cfloat) {.
    importc: "cblas_srotm", dynlib: libName.}
proc drotg*(a: ptr cdouble; b: ptr cdouble; c: ptr cdouble; s: ptr cdouble) {.
    importc: "cblas_drotg", dynlib: libName.}
proc drotmg*(d1: ptr cdouble; d2: ptr cdouble; b1: ptr cdouble; b2: cdouble; P: ptr cdouble) {.
    importc: "cblas_drotmg", dynlib: libName.}
proc drot*(N: cint; X: ptr cdouble; incX: cint; Y: ptr cdouble; incY: cint; c: cdouble;
          s: cdouble) {.importc: "cblas_drot", dynlib: libName.}
proc drotm*(N: cint; X: ptr cdouble; incX: cint; Y: ptr cdouble; incY: cint; P: ptr cdouble) {.
    importc: "cblas_drotm", dynlib: libName.}
#
#  Routines with S D C Z CS and ZD prefixes
#

proc sscal*(N: cint; alpha: cfloat; X: ptr cfloat; incX: cint) {.importc: "cblas_sscal",
    dynlib: libName.}
proc dscal*(N: cint; alpha: cdouble; X: ptr cdouble; incX: cint) {.importc: "cblas_dscal",
    dynlib: libName.}
proc cscal*(N: cint; alpha: pointer; X: pointer; incX: cint) {.importc: "cblas_cscal",
    dynlib: libName.}
proc zscal*(N: cint; alpha: pointer; X: pointer; incX: cint) {.importc: "cblas_zscal",
    dynlib: libName.}
proc csscal*(N: cint; alpha: cfloat; X: pointer; incX: cint) {.importc: "cblas_csscal",
    dynlib: libName.}
proc zdscal*(N: cint; alpha: cdouble; X: pointer; incX: cint) {.importc: "cblas_zdscal",
    dynlib: libName.}
#
#  ===========================================================================
#  Prototypes for level 2 BLAS
#  ===========================================================================
#
#
#  Routines with standard 4 prefixes (S, D, C, Z)
#

proc sgemv*(order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; M: cint; N: cint; alpha: cfloat;
           A: ptr cfloat; lda: cint; X: ptr cfloat; incX: cint; beta: cfloat; Y: ptr cfloat;
           incY: cint) {.importc: "cblas_sgemv", dynlib: libName.}
proc sgbmv*(order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; M: cint; N: cint; KL: cint;
           KU: cint; alpha: cfloat; A: ptr cfloat; lda: cint; X: ptr cfloat; incX: cint;
           beta: cfloat; Y: ptr cfloat; incY: cint) {.importc: "cblas_sgbmv",
    dynlib: libName.}
proc strmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; A: ptr cfloat; lda: cint; X: ptr cfloat; incX: cint) {.
    importc: "cblas_strmv", dynlib: libName.}
proc stbmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; K: cint; A: ptr cfloat; lda: cint; X: ptr cfloat;
           incX: cint) {.importc: "cblas_stbmv", dynlib: libName.}
proc stpmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; Ap: ptr cfloat; X: ptr cfloat; incX: cint) {.
    importc: "cblas_stpmv", dynlib: libName.}
proc strsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; A: ptr cfloat; lda: cint; X: ptr cfloat; incX: cint) {.
    importc: "cblas_strsv", dynlib: libName.}
proc stbsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; K: cint; A: ptr cfloat; lda: cint; X: ptr cfloat;
           incX: cint) {.importc: "cblas_stbsv", dynlib: libName.}
proc stpsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; Ap: ptr cfloat; X: ptr cfloat; incX: cint) {.
    importc: "cblas_stpsv", dynlib: libName.}
proc dgemv*(order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; M: cint; N: cint;
           alpha: cdouble; A: ptr cdouble; lda: cint; X: ptr cdouble; incX: cint;
           beta: cdouble; Y: ptr cdouble; incY: cint) {.importc: "cblas_dgemv",
    dynlib: libName.}
proc dgbmv*(order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; M: cint; N: cint; KL: cint;
           KU: cint; alpha: cdouble; A: ptr cdouble; lda: cint; X: ptr cdouble; incX: cint;
           beta: cdouble; Y: ptr cdouble; incY: cint) {.importc: "cblas_dgbmv",
    dynlib: libName.}
proc dtrmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; A: ptr cdouble; lda: cint; X: ptr cdouble; incX: cint) {.
    importc: "cblas_dtrmv", dynlib: libName.}
proc dtbmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; K: cint; A: ptr cdouble; lda: cint; X: ptr cdouble;
           incX: cint) {.importc: "cblas_dtbmv", dynlib: libName.}
proc dtpmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; Ap: ptr cdouble; X: ptr cdouble; incX: cint) {.
    importc: "cblas_dtpmv", dynlib: libName.}
proc dtrsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; A: ptr cdouble; lda: cint; X: ptr cdouble; incX: cint) {.
    importc: "cblas_dtrsv", dynlib: libName.}
proc dtbsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; K: cint; A: ptr cdouble; lda: cint; X: ptr cdouble;
           incX: cint) {.importc: "cblas_dtbsv", dynlib: libName.}
proc dtpsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; Ap: ptr cdouble; X: ptr cdouble; incX: cint) {.
    importc: "cblas_dtpsv", dynlib: libName.}
proc cgemv*(order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; M: cint; N: cint;
           alpha: pointer; A: pointer; lda: cint; X: pointer; incX: cint; beta: pointer;
           Y: pointer; incY: cint) {.importc: "cblas_cgemv", dynlib: libName.}
proc cgbmv*(order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; M: cint; N: cint; KL: cint;
           KU: cint; alpha: pointer; A: pointer; lda: cint; X: pointer; incX: cint;
           beta: pointer; Y: pointer; incY: cint) {.importc: "cblas_cgbmv",
    dynlib: libName.}
proc ctrmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; A: pointer; lda: cint; X: pointer; incX: cint) {.
    importc: "cblas_ctrmv", dynlib: libName.}
proc ctbmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; K: cint; A: pointer; lda: cint; X: pointer; incX: cint) {.
    importc: "cblas_ctbmv", dynlib: libName.}
proc ctpmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; Ap: pointer; X: pointer; incX: cint) {.
    importc: "cblas_ctpmv", dynlib: libName.}
proc ctrsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; A: pointer; lda: cint; X: pointer; incX: cint) {.
    importc: "cblas_ctrsv", dynlib: libName.}
proc ctbsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; K: cint; A: pointer; lda: cint; X: pointer; incX: cint) {.
    importc: "cblas_ctbsv", dynlib: libName.}
proc ctpsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; Ap: pointer; X: pointer; incX: cint) {.
    importc: "cblas_ctpsv", dynlib: libName.}
proc zgemv*(order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; M: cint; N: cint;
           alpha: pointer; A: pointer; lda: cint; X: pointer; incX: cint; beta: pointer;
           Y: pointer; incY: cint) {.importc: "cblas_zgemv", dynlib: libName.}
proc zgbmv*(order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; M: cint; N: cint; KL: cint;
           KU: cint; alpha: pointer; A: pointer; lda: cint; X: pointer; incX: cint;
           beta: pointer; Y: pointer; incY: cint) {.importc: "cblas_zgbmv",
    dynlib: libName.}
proc ztrmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; A: pointer; lda: cint; X: pointer; incX: cint) {.
    importc: "cblas_ztrmv", dynlib: libName.}
proc ztbmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; K: cint; A: pointer; lda: cint; X: pointer; incX: cint) {.
    importc: "cblas_ztbmv", dynlib: libName.}
proc ztpmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; Ap: pointer; X: pointer; incX: cint) {.
    importc: "cblas_ztpmv", dynlib: libName.}
proc ztrsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; A: pointer; lda: cint; X: pointer; incX: cint) {.
    importc: "cblas_ztrsv", dynlib: libName.}
proc ztbsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; K: cint; A: pointer; lda: cint; X: pointer; incX: cint) {.
    importc: "cblas_ztbsv", dynlib: libName.}
proc ztpsv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; TransA: CBLAS_TRANSPOSE;
           Diag: CBLAS_DIAG; N: cint; Ap: pointer; X: pointer; incX: cint) {.
    importc: "cblas_ztpsv", dynlib: libName.}
#
#  Routines with S and D prefixes only
#

proc ssymv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cfloat; A: ptr cfloat;
           lda: cint; X: ptr cfloat; incX: cint; beta: cfloat; Y: ptr cfloat; incY: cint) {.
    importc: "cblas_ssymv", dynlib: libName.}
proc ssbmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; K: cint; alpha: cfloat;
           A: ptr cfloat; lda: cint; X: ptr cfloat; incX: cint; beta: cfloat; Y: ptr cfloat;
           incY: cint) {.importc: "cblas_ssbmv", dynlib: libName.}
proc sspmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cfloat; Ap: ptr cfloat;
           X: ptr cfloat; incX: cint; beta: cfloat; Y: ptr cfloat; incY: cint) {.
    importc: "cblas_sspmv", dynlib: libName.}
proc sger*(order: CBLAS_ORDER; M: cint; N: cint; alpha: cfloat; X: ptr cfloat; incX: cint;
          Y: ptr cfloat; incY: cint; A: ptr cfloat; lda: cint) {.importc: "cblas_sger",
    dynlib: libName.}
proc ssyr*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cfloat; X: ptr cfloat;
          incX: cint; A: ptr cfloat; lda: cint) {.importc: "cblas_ssyr", dynlib: libName.}
proc sspr*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cfloat; X: ptr cfloat;
          incX: cint; Ap: ptr cfloat) {.importc: "cblas_sspr", dynlib: libName.}
proc ssyr2*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cfloat; X: ptr cfloat;
           incX: cint; Y: ptr cfloat; incY: cint; A: ptr cfloat; lda: cint) {.
    importc: "cblas_ssyr2", dynlib: libName.}
proc sspr2*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cfloat; X: ptr cfloat;
           incX: cint; Y: ptr cfloat; incY: cint; A: ptr cfloat) {.importc: "cblas_sspr2",
    dynlib: libName.}
proc dsymv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cdouble;
           A: ptr cdouble; lda: cint; X: ptr cdouble; incX: cint; beta: cdouble;
           Y: ptr cdouble; incY: cint) {.importc: "cblas_dsymv", dynlib: libName.}
proc dsbmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; K: cint; alpha: cdouble;
           A: ptr cdouble; lda: cint; X: ptr cdouble; incX: cint; beta: cdouble;
           Y: ptr cdouble; incY: cint) {.importc: "cblas_dsbmv", dynlib: libName.}
proc dspmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cdouble;
           Ap: ptr cdouble; X: ptr cdouble; incX: cint; beta: cdouble; Y: ptr cdouble;
           incY: cint) {.importc: "cblas_dspmv", dynlib: libName.}
proc dger*(order: CBLAS_ORDER; M: cint; N: cint; alpha: cdouble; X: ptr cdouble; incX: cint;
          Y: ptr cdouble; incY: cint; A: ptr cdouble; lda: cint) {.importc: "cblas_dger",
    dynlib: libName.}
proc dsyr*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cdouble; X: ptr cdouble;
          incX: cint; A: ptr cdouble; lda: cint) {.importc: "cblas_dsyr", dynlib: libName.}
proc dspr*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cdouble; X: ptr cdouble;
          incX: cint; Ap: ptr cdouble) {.importc: "cblas_dspr", dynlib: libName.}
proc dsyr2*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cdouble;
           X: ptr cdouble; incX: cint; Y: ptr cdouble; incY: cint; A: ptr cdouble; lda: cint) {.
    importc: "cblas_dsyr2", dynlib: libName.}
proc dspr2*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cdouble;
           X: ptr cdouble; incX: cint; Y: ptr cdouble; incY: cint; A: ptr cdouble) {.
    importc: "cblas_dspr2", dynlib: libName.}
#
#  Routines with C and Z prefixes only
#

proc chemv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: pointer; A: pointer;
           lda: cint; X: pointer; incX: cint; beta: pointer; Y: pointer; incY: cint) {.
    importc: "cblas_chemv", dynlib: libName.}
proc chbmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; K: cint; alpha: pointer;
           A: pointer; lda: cint; X: pointer; incX: cint; beta: pointer; Y: pointer;
           incY: cint) {.importc: "cblas_chbmv", dynlib: libName.}
proc chpmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: pointer; Ap: pointer;
           X: pointer; incX: cint; beta: pointer; Y: pointer; incY: cint) {.
    importc: "cblas_chpmv", dynlib: libName.}
proc cgeru*(order: CBLAS_ORDER; M: cint; N: cint; alpha: pointer; X: pointer; incX: cint;
           Y: pointer; incY: cint; A: pointer; lda: cint) {.importc: "cblas_cgeru",
    dynlib: libName.}
proc cgerc*(order: CBLAS_ORDER; M: cint; N: cint; alpha: pointer; X: pointer; incX: cint;
           Y: pointer; incY: cint; A: pointer; lda: cint) {.importc: "cblas_cgerc",
    dynlib: libName.}
proc cher*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cfloat; X: pointer;
          incX: cint; A: pointer; lda: cint) {.importc: "cblas_cher", dynlib: libName.}
proc chpr*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cfloat; X: pointer;
          incX: cint; A: pointer) {.importc: "cblas_chpr", dynlib: libName.}
proc cher2*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: pointer; X: pointer;
           incX: cint; Y: pointer; incY: cint; A: pointer; lda: cint) {.
    importc: "cblas_cher2", dynlib: libName.}
proc chpr2*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: pointer; X: pointer;
           incX: cint; Y: pointer; incY: cint; Ap: pointer) {.importc: "cblas_chpr2",
    dynlib: libName.}
proc zhemv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: pointer; A: pointer;
           lda: cint; X: pointer; incX: cint; beta: pointer; Y: pointer; incY: cint) {.
    importc: "cblas_zhemv", dynlib: libName.}
proc zhbmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; K: cint; alpha: pointer;
           A: pointer; lda: cint; X: pointer; incX: cint; beta: pointer; Y: pointer;
           incY: cint) {.importc: "cblas_zhbmv", dynlib: libName.}
proc zhpmv*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: pointer; Ap: pointer;
           X: pointer; incX: cint; beta: pointer; Y: pointer; incY: cint) {.
    importc: "cblas_zhpmv", dynlib: libName.}
proc zgeru*(order: CBLAS_ORDER; M: cint; N: cint; alpha: pointer; X: pointer; incX: cint;
           Y: pointer; incY: cint; A: pointer; lda: cint) {.importc: "cblas_zgeru",
    dynlib: libName.}
proc zgerc*(order: CBLAS_ORDER; M: cint; N: cint; alpha: pointer; X: pointer; incX: cint;
           Y: pointer; incY: cint; A: pointer; lda: cint) {.importc: "cblas_zgerc",
    dynlib: libName.}
proc zher*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cdouble; X: pointer;
          incX: cint; A: pointer; lda: cint) {.importc: "cblas_zher", dynlib: libName.}
proc zhpr*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: cdouble; X: pointer;
          incX: cint; A: pointer) {.importc: "cblas_zhpr", dynlib: libName.}
proc zher2*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: pointer; X: pointer;
           incX: cint; Y: pointer; incY: cint; A: pointer; lda: cint) {.
    importc: "cblas_zher2", dynlib: libName.}
proc zhpr2*(order: CBLAS_ORDER; Uplo: CBLAS_UPLO; N: cint; alpha: pointer; X: pointer;
           incX: cint; Y: pointer; incY: cint; Ap: pointer) {.importc: "cblas_zhpr2",
    dynlib: libName.}
#
#  ===========================================================================
#  Prototypes for level 3 BLAS
#  ===========================================================================
#
#
#  Routines with standard 4 prefixes (S, D, C, Z)
#

proc sgemm*(Order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; TransB: CBLAS_TRANSPOSE;
           M: cint; N: cint; K: cint; alpha: cfloat; A: ptr cfloat; lda: cint; B: ptr cfloat;
           ldb: cint; beta: cfloat; C: ptr cfloat; ldc: cint) {.importc: "cblas_sgemm",
    dynlib: libName.}
proc ssymm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO; M: cint; N: cint;
           alpha: cfloat; A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; beta: cfloat;
           C: ptr cfloat; ldc: cint) {.importc: "cblas_ssymm", dynlib: libName.}
proc ssyrk*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
           K: cint; alpha: cfloat; A: ptr cfloat; lda: cint; beta: cfloat; C: ptr cfloat;
           ldc: cint) {.importc: "cblas_ssyrk", dynlib: libName.}
proc ssyr2k*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
            K: cint; alpha: cfloat; A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint;
            beta: cfloat; C: ptr cfloat; ldc: cint) {.importc: "cblas_ssyr2k",
    dynlib: libName.}
proc strmm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO;
           TransA: CBLAS_TRANSPOSE; Diag: CBLAS_DIAG; M: cint; N: cint; alpha: cfloat;
           A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint) {.importc: "cblas_strmm",
    dynlib: libName.}
proc strsm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO;
           TransA: CBLAS_TRANSPOSE; Diag: CBLAS_DIAG; M: cint; N: cint; alpha: cfloat;
           A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint) {.importc: "cblas_strsm",
    dynlib: libName.}
proc dgemm*(Order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; TransB: CBLAS_TRANSPOSE;
           M: cint; N: cint; K: cint; alpha: cdouble; A: ptr cdouble; lda: cint;
           B: ptr cdouble; ldb: cint; beta: cdouble; C: ptr cdouble; ldc: cint) {.
    importc: "cblas_dgemm", dynlib: libName.}
proc dsymm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO; M: cint; N: cint;
           alpha: cdouble; A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
           beta: cdouble; C: ptr cdouble; ldc: cint) {.importc: "cblas_dsymm",
    dynlib: libName.}
proc dsyrk*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
           K: cint; alpha: cdouble; A: ptr cdouble; lda: cint; beta: cdouble;
           C: ptr cdouble; ldc: cint) {.importc: "cblas_dsyrk", dynlib: libName.}
proc dsyr2k*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
            K: cint; alpha: cdouble; A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
            beta: cdouble; C: ptr cdouble; ldc: cint) {.importc: "cblas_dsyr2k",
    dynlib: libName.}
proc dtrmm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO;
           TransA: CBLAS_TRANSPOSE; Diag: CBLAS_DIAG; M: cint; N: cint; alpha: cdouble;
           A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint) {.importc: "cblas_dtrmm",
    dynlib: libName.}
proc dtrsm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO;
           TransA: CBLAS_TRANSPOSE; Diag: CBLAS_DIAG; M: cint; N: cint; alpha: cdouble;
           A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint) {.importc: "cblas_dtrsm",
    dynlib: libName.}
proc cgemm*(Order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; TransB: CBLAS_TRANSPOSE;
           M: cint; N: cint; K: cint; alpha: pointer; A: pointer; lda: cint; B: pointer;
           ldb: cint; beta: pointer; C: pointer; ldc: cint) {.importc: "cblas_cgemm",
    dynlib: libName.}
proc csymm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO; M: cint; N: cint;
           alpha: pointer; A: pointer; lda: cint; B: pointer; ldb: cint; beta: pointer;
           C: pointer; ldc: cint) {.importc: "cblas_csymm", dynlib: libName.}
proc csyrk*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
           K: cint; alpha: pointer; A: pointer; lda: cint; beta: pointer; C: pointer;
           ldc: cint) {.importc: "cblas_csyrk", dynlib: libName.}
proc csyr2k*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
            K: cint; alpha: pointer; A: pointer; lda: cint; B: pointer; ldb: cint;
            beta: pointer; C: pointer; ldc: cint) {.importc: "cblas_csyr2k",
    dynlib: libName.}
proc ctrmm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO;
           TransA: CBLAS_TRANSPOSE; Diag: CBLAS_DIAG; M: cint; N: cint; alpha: pointer;
           A: pointer; lda: cint; B: pointer; ldb: cint) {.importc: "cblas_ctrmm",
    dynlib: libName.}
proc ctrsm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO;
           TransA: CBLAS_TRANSPOSE; Diag: CBLAS_DIAG; M: cint; N: cint; alpha: pointer;
           A: pointer; lda: cint; B: pointer; ldb: cint) {.importc: "cblas_ctrsm",
    dynlib: libName.}
proc zgemm*(Order: CBLAS_ORDER; TransA: CBLAS_TRANSPOSE; TransB: CBLAS_TRANSPOSE;
           M: cint; N: cint; K: cint; alpha: pointer; A: pointer; lda: cint; B: pointer;
           ldb: cint; beta: pointer; C: pointer; ldc: cint) {.importc: "cblas_zgemm",
    dynlib: libName.}
proc zsymm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO; M: cint; N: cint;
           alpha: pointer; A: pointer; lda: cint; B: pointer; ldb: cint; beta: pointer;
           C: pointer; ldc: cint) {.importc: "cblas_zsymm", dynlib: libName.}
proc zsyrk*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
           K: cint; alpha: pointer; A: pointer; lda: cint; beta: pointer; C: pointer;
           ldc: cint) {.importc: "cblas_zsyrk", dynlib: libName.}
proc zsyr2k*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
            K: cint; alpha: pointer; A: pointer; lda: cint; B: pointer; ldb: cint;
            beta: pointer; C: pointer; ldc: cint) {.importc: "cblas_zsyr2k",
    dynlib: libName.}
proc ztrmm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO;
           TransA: CBLAS_TRANSPOSE; Diag: CBLAS_DIAG; M: cint; N: cint; alpha: pointer;
           A: pointer; lda: cint; B: pointer; ldb: cint) {.importc: "cblas_ztrmm",
    dynlib: libName.}
proc ztrsm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO;
           TransA: CBLAS_TRANSPOSE; Diag: CBLAS_DIAG; M: cint; N: cint; alpha: pointer;
           A: pointer; lda: cint; B: pointer; ldb: cint) {.importc: "cblas_ztrsm",
    dynlib: libName.}
#
#  Routines with prefixes C and Z only
#

proc chemm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO; M: cint; N: cint;
           alpha: pointer; A: pointer; lda: cint; B: pointer; ldb: cint; beta: pointer;
           C: pointer; ldc: cint) {.importc: "cblas_chemm", dynlib: libName.}
proc cherk*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
           K: cint; alpha: cfloat; A: pointer; lda: cint; beta: cfloat; C: pointer;
           ldc: cint) {.importc: "cblas_cherk", dynlib: libName.}
proc cher2k*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
            K: cint; alpha: pointer; A: pointer; lda: cint; B: pointer; ldb: cint;
            beta: cfloat; C: pointer; ldc: cint) {.importc: "cblas_cher2k",
    dynlib: libName.}
proc zhemm*(Order: CBLAS_ORDER; Side: CBLAS_SIDE; Uplo: CBLAS_UPLO; M: cint; N: cint;
           alpha: pointer; A: pointer; lda: cint; B: pointer; ldb: cint; beta: pointer;
           C: pointer; ldc: cint) {.importc: "cblas_zhemm", dynlib: libName.}
proc zherk*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
           K: cint; alpha: cdouble; A: pointer; lda: cint; beta: cdouble; C: pointer;
           ldc: cint) {.importc: "cblas_zherk", dynlib: libName.}
proc zher2k*(Order: CBLAS_ORDER; Uplo: CBLAS_UPLO; Trans: CBLAS_TRANSPOSE; N: cint;
            K: cint; alpha: pointer; A: pointer; lda: cint; B: pointer; ldb: cint;
            beta: cdouble; C: pointer; ldc: cint) {.importc: "cblas_zher2k",
    dynlib: libName.}
# proc xerbla*(p: cint; rout: cstring; form: cstring) {.varargs, importc: "cblas_xerbla",
#     dynlib: libName.}