# Copyright 2015-2017 UniCredit S.p.A.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include nimblas/private/common
import complex

type
  IndexType* = csize
  TransposeType* {.size: sizeof(int).} = enum
    noTranspose = 111, transpose = 112, conjTranspose = 113
  OrderType* {.size: sizeof(int).} = enum
    rowMajor = 101, colMajor = 102
  UploType* {.size: sizeof(int).} = enum
    upper = 121, lower = 122
  DiagType* {.size: sizeof(int).} = enum
    nonUnit = 131, unit = 132
  SideType* {.size: sizeof(int).} = enum
    left = 141, right = 142


#
#  ===========================================================================
#  Prototypes for level 1 BLAS functions (complex are recast as routines)
#  ===========================================================================
#

proc dot*(N: int; alpha: float32; X: ptr float32; incX: int; Y: ptr float32; incY: int): float32 {.
    importc: "cblas_sdsdot", dynlib: libName.}
# TODO: fix ambiguous between dsdot(f32,f32)->f64 and sdot(f32,f32)->f32
# proc dot*(N: int; X: ptr float32; incX: int; Y: ptr float32; incY: int): float64 {.
#   importc: "cblas_dsdot", dynlib: libName.}
proc dot*(N: int; X: ptr float32; incX: int; Y: ptr float32; incY: int): float32 {.
    importc: "cblas_sdot", dynlib: libName.}
proc dot*(N: int; X: ptr float64; incX: int; Y: ptr float64; incY: int): float64 {.
    importc: "cblas_ddot", dynlib: libName.}
#
#  Functions having prefixes Z and C only
#

proc dotu*(N: int; X: ptr Complex32; incX: int; Y: ptr Complex32; incY: int; dotu: ptr Complex32) {.
    importc: "cblas_cdotu_sub", dynlib: libName.}
proc dotu*(N: int; X: ptr Complex64; incX: int; Y: ptr Complex64; incY: int; dotu: ptr Complex64) {.
    importc: "cblas_zdotu_sub", dynlib: libName.}
proc dotc*(N: int; X: ptr Complex32; incX: int; Y: ptr Complex32; incY: int; dotc: ptr Complex32) {.
    importc: "cblas_cdotc_sub", dynlib: libName.}
proc dotc*(N: int; X: ptr Complex64; incX: int; Y: ptr Complex64; incY: int; dotc: ptr Complex64) {.
    importc: "cblas_zdotc_sub", dynlib: libName.}
#
#  Functions having prefixes S D SC DZ
#

proc nrm2*(N: int; X: ptr float32; incX: int): float32 {.importc: "cblas_snrm2",
    dynlib: libName.}
proc nrm2*(N: int; X: ptr float64; incX: int): float64 {.importc: "cblas_dnrm2",
    dynlib: libName.}
proc nrm2*(N: int; X: ptr Complex32; incX: int): float32 {.importc: "cblas_scnrm2",
                                                       dynlib: libName.}
proc nrm2*(N: int; X: ptr Complex64; incX: int): float64 {.importc: "cblas_dznrm2",
                                                       dynlib: libName.}

proc asum*(N: int; X: ptr float32; incX: int): float32 {.importc: "cblas_sasum",
                                                          dynlib: libName.}
proc asum*(N: int; X: ptr float64; incX: int): float64 {.importc: "cblas_dasum",
    dynlib: libName.}
proc asum*(N: int; X: ptr Complex32; incX: int): float32 {.importc: "cblas_scasum",
    dynlib: libName.}
proc asum*(N: int; X: ptr Complex64; incX: int): float64 {.importc: "cblas_dzasum",
    dynlib: libName.}
#
#  Functions having standard 4 prefixes (S D C Z)
#

proc iamax*(N: int; X: ptr float32; incX: int): IndexType {.importc: "cblas_isamax",
    dynlib: libName.}
proc iamax*(N: int; X: ptr float64; incX: int): IndexType {.importc: "cblas_idamax",
    dynlib: libName.}
proc iamax*(N: int; X: ptr Complex32; incX: int): IndexType {.importc: "cblas_icamax",
    dynlib: libName.}
proc iamax*(N: int; X: ptr Complex64; incX: int): IndexType {.importc: "cblas_izamax",
    dynlib: libName.}
#
#  ===========================================================================
#  Prototypes for level 1 BLAS routines
#  ===========================================================================
#
#
#  Routines with standard 4 prefixes (s, d, c, z)
#

proc swap*(N: int; X: ptr float32; incX: int; Y: ptr float32; incY: int) {.
    importc: "cblas_sswap", dynlib: libName.}
proc swap*(N: int; X: ptr float64; incX: int; Y: ptr float64; incY: int) {.
  importc: "cblas_dswap", dynlib: libName.}
proc swap*(N: int; X: ptr Complex32; incX: int; Y: ptr Complex32; incY: int) {.
  importc: "cblas_cswap", dynlib: libName.}
proc swap*(N: int; X: ptr Complex64; incX: int; Y: ptr Complex64; incY: int) {.
  importc: "cblas_zswap", dynlib: libName.}

proc copy*(N: int; X: ptr float32; incX: int; Y: ptr float32; incY: int) {.
    importc: "cblas_scopy", dynlib: libName.}
proc copy*(N: int; X: ptr float64; incX: int; Y: ptr float64; incY: int) {.
  importc: "cblas_dcopy", dynlib: libName.}
proc copy*(N: int; X: ptr Complex32; incX: int; Y: ptr Complex32; incY: int) {.
  importc: "cblas_ccopy", dynlib: libName.}
proc copy*(N: int; X: ptr Complex64; incX: int; Y: ptr Complex64; incY: int) {.
  importc: "cblas_zcopy", dynlib: libName.}

proc axpy*(N: int; alpha: float32; X: ptr float32; incX: int; Y: ptr float32; incY: int) {.
    importc: "cblas_saxpy", dynlib: libName.}
proc axpy*(N: int; alpha: float64; X: ptr float64; incX: int; Y: ptr float64; incY: int) {.
    importc: "cblas_daxpy", dynlib: libName.}
proc axpy*(N: int; alpha: ptr Complex32; X: ptr Complex32; incX: int; Y: ptr Complex32; incY: int) {.
    importc: "cblas_caxpy", dynlib: libName.}
proc axpy*(N: int; alpha: ptr Complex64; X: ptr Complex64; incX: int; Y: ptr Complex64; incY: int) {.
  importc: "cblas_zaxpy", dynlib: libName.}

#
#  Routines with S and D prefix only
#

proc rotg*(a: ptr float32; b: ptr float32; c: ptr float32; s: ptr float32) {.
    importc: "cblas_srotg", dynlib: libName.}
proc rotg*(a: ptr float64; b: ptr float64; c: ptr float64; s: ptr float64) {.
  importc: "cblas_drotg", dynlib: libName.}

proc rotmg*(d1: ptr float32; d2: ptr float32; b1: ptr float32; b2: float32; P: ptr float32) {.
    importc: "cblas_srotmg", dynlib: libName.}
proc rotmg*(d1: ptr float64; d2: ptr float64; b1: ptr float64; b2: float64; P: ptr float64) {.
  importc: "cblas_drotmg", dynlib: libName.}

proc rot*(N: int; X: ptr float32; incX: int; Y: ptr float32; incY: int; c: float32; s: float32) {.
    importc: "cblas_srot", dynlib: libName.}
proc rot*(N: int; X: ptr float64; incX: int; Y: ptr float64; incY: int; c: float64;
           s: float64) {.importc: "cblas_drot", dynlib: libName.}
proc rotm*(N: int; X: ptr float32; incX: int; Y: ptr float32; incY: int; P: ptr float32) {.
    importc: "cblas_srotm", dynlib: libName.}
proc rotm*(N: int; X: ptr float64; incX: int; Y: ptr float64; incY: int; P: ptr float64) {.
    importc: "cblas_drotm", dynlib: libName.}
#
#  Routines with S D C Z CS and ZD prefixes
#

proc scal*(N: int; alpha: float32; X: ptr float32; incX: int) {.importc: "cblas_sscal",
    dynlib: libName.}
proc scal*(N: int; alpha: float64; X: ptr float64; incX: int) {.importc: "cblas_dscal",
    dynlib: libName.}
proc scal*(N: int; alpha: ptr Complex32; X: ptr Complex32; incX: int) {.importc: "cblas_cscal",
    dynlib: libName.}
proc scal*(N: int; alpha: ptr Complex64; X: ptr Complex64; incX: int) {.importc: "cblas_zscal",
    dynlib: libName.}
proc scal*(N: int; alpha: float32; X: ptr Complex32; incX: int) {.importc: "cblas_csscal",
    dynlib: libName.}
proc scal*(N: int; alpha: float64; X: ptr Complex64; incX: int) {.importc: "cblas_zdscal",
    dynlib: libName.}
#
#  ===========================================================================
#  Prototypes for level 2 BLAS
#  ===========================================================================
#
#
#  Routines with standard 4 prefixes (S, D, C, Z)
#

proc gemv*(order: OrderType; TransA: TransposeType; M: int; N: int; alpha: float32;
          A: ptr float32; lda: int; X: ptr float32; incX: int; beta: float32; Y: ptr float32;
          incY: int) {.importc: "cblas_sgemv", dynlib: libName.}
proc gemv*(order: OrderType; TransA: TransposeType; M: int; N: int;
           alpha: float64; A: ptr float64; lda: int; X: ptr float64; incX: int;
           beta: float64; Y: ptr float64; incY: int) {.importc: "cblas_dgemv",
                                                       dynlib: libName.}
proc gemv*(order: OrderType; TransA: TransposeType; M: int; N: int;
           alpha: ptr Complex32; A: ptr Complex32; lda: int; X: ptr Complex32; incX: int; beta: ptr Complex32;
           Y: ptr Complex32; incY: int) {.importc: "cblas_cgemv", dynlib: libName.}
proc gemv*(order: OrderType; TransA: TransposeType; M: int; N: int;
           alpha: ptr Complex64; A: ptr Complex64; lda: int; X: ptr Complex64; incX: int; beta: ptr Complex64;
           Y: ptr Complex64; incY: int) {.importc: "cblas_zgemv", dynlib: libName.}


proc trmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; A: ptr float32; lda: int; X: ptr float32; incX: int) {.
             importc: "cblas_strmv", dynlib: libName.}
proc trmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; A: ptr float64; lda: int; X: ptr float64; incX: int) {.
             importc: "cblas_dtrmv", dynlib: libName.}
proc trmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; A: ptr Complex32; lda: int; X: ptr Complex32; incX: int) {.
             importc: "cblas_ctrmv", dynlib: libName.}
proc trmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; A: ptr Complex64; lda: int; X: ptr Complex64; incX: int) {.
             importc: "cblas_ztrmv", dynlib: libName.}


proc trsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; A: ptr float32; lda: int; X: ptr float32; incX: int) {.
             importc: "cblas_strsv", dynlib: libName.}
proc trsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; A: ptr float64; lda: int; X: ptr float64; incX: int) {.
             importc: "cblas_dtrsv", dynlib: libName.}
proc trsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; A: ptr Complex32; lda: int; X: ptr Complex32; incX: int) {.
             importc: "cblas_ctrsv", dynlib: libName.}
proc trsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; A: ptr Complex64; lda: int; X: ptr Complex64; incX: int) {.
             importc: "cblas_ztrsv", dynlib: libName.}

proc gbmv*(order: OrderType; TransA: TransposeType; M: int; N: int; KL: int;
           KU: int; alpha: float32; A: ptr float32; lda: int; X: ptr float32; incX: int;
           beta: float32; Y: ptr float32; incY: int) {.importc: "cblas_sgbmv",
                                                       dynlib: libName.}
proc gbmv*(order: OrderType; TransA: TransposeType; M: int; N: int; KL: int;
           KU: int; alpha: float64; A: ptr float64; lda: int; X: ptr float64; incX: int;
           beta: float64; Y: ptr float64; incY: int) {.importc: "cblas_dgbmv",
                                                       dynlib: libName.}
proc gbmv*(order: OrderType; TransA: TransposeType; M: int; N: int; KL: int;
           KU: int; alpha: ptr Complex32; A: ptr Complex32; lda: int; X: ptr Complex32; incX: int;
           beta: ptr Complex32; Y: ptr Complex32; incY: int) {.importc: "cblas_cgbmv",
                                                               dynlib: libName.}
proc gbmv*(order: OrderType; TransA: TransposeType; M: int; N: int; KL: int;
           KU: int; alpha: ptr Complex64; A: ptr Complex64; lda: int; X: ptr Complex64; incX: int;
           beta: ptr Complex64; Y: ptr Complex64; incY: int) {.importc: "cblas_zgbmv",
                                                               dynlib: libName.}


proc tbmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; K: int; A: ptr float32; lda: int; X: ptr float32;
           incX: int) {.importc: "cblas_stbmv", dynlib: libName.}
proc tbmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; K: int; A: ptr float64; lda: int; X: ptr float64;
           incX: int) {.importc: "cblas_dtbmv", dynlib: libName.}
proc tbmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; K: int; A: ptr Complex32; lda: int; X: ptr Complex32; incX: int) {.
             importc: "cblas_ctbmv", dynlib: libName.}
proc tbmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; K: int; A: ptr Complex64; lda: int; X: ptr Complex64; incX: int) {.
             importc: "cblas_ztbmv", dynlib: libName.}


proc tpmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; Ap: ptr float32; X: ptr float32; incX: int) {.
             importc: "cblas_stpmv", dynlib: libName.}
proc tpmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; Ap: ptr float64; X: ptr float64; incX: int) {.
             importc: "cblas_dtpmv", dynlib: libName.}
proc tpmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; Ap: ptr Complex32; X: ptr Complex32; incX: int) {.
             importc: "cblas_ctpmv", dynlib: libName.}
proc tpmv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; Ap: ptr Complex64; X: ptr Complex64; incX: int) {.
             importc: "cblas_ztpmv", dynlib: libName.}

proc tbsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; K: int; A: ptr float32; lda: int; X: ptr float32;
           incX: int) {.importc: "cblas_stbsv", dynlib: libName.}
proc tbsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; K: int; A: ptr float64; lda: int; X: ptr float64;
           incX: int) {.importc: "cblas_dtbsv", dynlib: libName.}
proc tbsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; K: int; A: ptr Complex32; lda: int; X: ptr Complex32; incX: int) {.
             importc: "cblas_ctbsv", dynlib: libName.}
proc tbsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; K: int; A: ptr Complex64; lda: int; X: ptr Complex64; incX: int) {.
             importc: "cblas_ztbsv", dynlib: libName.}


proc tpsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; Ap: ptr float32; X: ptr float32; incX: int) {.
             importc: "cblas_stpsv", dynlib: libName.}
proc tpsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; Ap: ptr float64; X: ptr float64; incX: int) {.
             importc: "cblas_dtpsv", dynlib: libName.}
proc tpsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; Ap: ptr Complex32; X: ptr Complex32; incX: int) {.
             importc: "cblas_ctpsv", dynlib: libName.}
proc tpsv*(order: OrderType; Uplo: UploType; TransA: TransposeType;
           Diag: DiagType; N: int; Ap: ptr Complex64; X: ptr Complex64; incX: int) {.
             importc: "cblas_ztpsv", dynlib: libName.}
#
#  Routines with S and D prefixes only
#

proc symv*(order: OrderType; Uplo: UploType; N: int; alpha: float32; A: ptr float32;
           lda: int; X: ptr float32; incX: int; beta: float32; Y: ptr float32; incY: int) {.
             importc: "cblas_ssymv", dynlib: libName.}
proc symv*(order: OrderType; Uplo: UploType; N: int; alpha: float64;
           A: ptr float64; lda: int; X: ptr float64; incX: int; beta: float64;
           Y: ptr float64; incY: int) {.importc: "cblas_dsymv", dynlib: libName.}


proc sbmv*(order: OrderType; Uplo: UploType; N: int; K: int; alpha: float32;
           A: ptr float32; lda: int; X: ptr float32; incX: int; beta: float32; Y: ptr float32;
           incY: int) {.importc: "cblas_ssbmv", dynlib: libName.}
proc sbmv*(order: OrderType; Uplo: UploType; N: int; K: int; alpha: float64;
           A: ptr float64; lda: int; X: ptr float64; incX: int; beta: float64;
           Y: ptr float64; incY: int) {.importc: "cblas_dsbmv", dynlib: libName.}


proc spmv*(order: OrderType; Uplo: UploType; N: int; alpha: float32; Ap: ptr float32;
           X: ptr float32; incX: int; beta: float32; Y: ptr float32; incY: int) {.
             importc: "cblas_sspmv", dynlib: libName.}
proc spmv*(order: OrderType; Uplo: UploType; N: int; alpha: float64;
           Ap: ptr float64; X: ptr float64; incX: int; beta: float64; Y: ptr float64;
           incY: int) {.importc: "cblas_dspmv", dynlib: libName.}


proc ger*(order: OrderType; M: int; N: int; alpha: float32; X: ptr float32; incX: int;
          Y: ptr float32; incY: int; A: ptr float32; lda: int) {.importc: "cblas_sger",
                                                                 dynlib: libName.}
proc ger*(order: OrderType; M: int; N: int; alpha: float64; X: ptr float64; incX: int;
          Y: ptr float64; incY: int; A: ptr float64; lda: int) {.importc: "cblas_dger",
                                                                 dynlib: libName.}


proc syr*(order: OrderType; Uplo: UploType; N: int; alpha: float32; X: ptr float32;
          incX: int; A: ptr float32; lda: int) {.importc: "cblas_ssyr", dynlib: libName.}
proc syr*(order: OrderType; Uplo: UploType; N: int; alpha: float64; X: ptr float64;
          incX: int; A: ptr float64; lda: int) {.importc: "cblas_dsyr", dynlib: libName.}


proc spr*(order: OrderType; Uplo: UploType; N: int; alpha: float32; X: ptr float32;
          incX: int; Ap: ptr float32) {.importc: "cblas_sspr", dynlib: libName.}
proc spr*(order: OrderType; Uplo: UploType; N: int; alpha: float64; X: ptr float64;
          incX: int; Ap: ptr float64) {.importc: "cblas_dspr", dynlib: libName.}


proc syr2*(order: OrderType; Uplo: UploType; N: int; alpha: float32; X: ptr float32;
           incX: int; Y: ptr float32; incY: int; A: ptr float32; lda: int) {.
             importc: "cblas_ssyr2", dynlib: libName.}
proc syr2*(order: OrderType; Uplo: UploType; N: int; alpha: float64;
           X: ptr float64; incX: int; Y: ptr float64; incY: int; A: ptr float64; lda: int) {.
             importc: "cblas_dsyr2", dynlib: libName.}


proc spr2*(order: OrderType; Uplo: UploType; N: int; alpha: float32; X: ptr float32;
           incX: int; Y: ptr float32; incY: int; A: ptr float32) {.importc: "cblas_sspr2",
                                                                   dynlib: libName.}
proc spr2*(order: OrderType; Uplo: UploType; N: int; alpha: float64;
           X: ptr float64; incX: int; Y: ptr float64; incY: int; A: ptr float64) {.
             importc: "cblas_dspr2", dynlib: libName.}
#
#  Routines with C and Z prefixes only
#

proc chemv*(order: OrderType; Uplo: UploType; N: int; alpha: ptr Complex32; A: ptr Complex32;
            lda: int; X: ptr Complex32; incX: int; beta: ptr Complex32; Y: ptr Complex32; incY: int) {.
              importc: "cblas_chemv", dynlib: libName.}
proc zhemv*(order: OrderType; Uplo: UploType; N: int; alpha: ptr Complex64; A: ptr Complex64;
            lda: int; X: ptr Complex64; incX: int; beta: ptr Complex64; Y: ptr Complex64; incY: int) {.
              importc: "cblas_zhemv", dynlib: libName.}


proc chbmv*(order: OrderType; Uplo: UploType; N: int; K: int; alpha: ptr Complex32;
            A: ptr Complex32; lda: int; X: ptr Complex32; incX: int; beta: ptr Complex32; Y: ptr Complex32;
            incY: int) {.importc: "cblas_chbmv", dynlib: libName.}
proc zhbmv*(order: OrderType; Uplo: UploType; N: int; K: int; alpha: ptr Complex64;
            A: ptr Complex64; lda: int; X: ptr Complex64; incX: int; beta: ptr Complex64; Y: ptr Complex64;
            incY: int) {.importc: "cblas_zhbmv", dynlib: libName.}


proc chpmv*(order: OrderType; Uplo: UploType; N: int; alpha: ptr Complex32; Ap: ptr Complex32;
            X: ptr Complex32; incX: int; beta: ptr Complex32; Y: ptr Complex32; incY: int) {.
              importc: "cblas_chpmv", dynlib: libName.}
proc zhpmv*(order: OrderType; Uplo: UploType; N: int; alpha: ptr Complex64; Ap: ptr Complex64;
            X: ptr Complex64; incX: int; beta: ptr Complex64; Y: ptr Complex64; incY: int) {.
              importc: "cblas_zhpmv", dynlib: libName.}


proc cgeru*(order: OrderType; M: int; N: int; alpha: ptr Complex32; X: ptr Complex32; incX: int;
            Y: ptr Complex32; incY: int; A: ptr Complex32; lda: int) {.importc: "cblas_cgeru",
                                                           dynlib: libName.}
proc zgeru*(order: OrderType; M: int; N: int; alpha: ptr Complex64; X: ptr Complex64; incX: int;
            Y: ptr Complex64; incY: int; A: ptr Complex64; lda: int) {.importc: "cblas_zgeru",
                                                           dynlib: libName.}


proc cgerc*(order: OrderType; M: int; N: int; alpha: ptr Complex32; X: ptr Complex32; incX: int;
            Y: ptr Complex32; incY: int; A: ptr Complex32; lda: int) {.importc: "cblas_cgerc",
                                                           dynlib: libName.}
proc zgerc*(order: OrderType; M: int; N: int; alpha: ptr Complex64; X: ptr Complex64; incX: int;
            Y: ptr Complex64; incY: int; A: ptr Complex64; lda: int) {.importc: "cblas_zgerc",
                                                           dynlib: libName.}


proc cher*(order: OrderType; Uplo: UploType; N: int; alpha: float32; X: ptr Complex32;
           incX: int; A: ptr Complex32; lda: int) {.importc: "cblas_cher", dynlib: libName.}
proc zher*(order: OrderType; Uplo: UploType; N: int; alpha: float64; X: ptr Complex64;
           incX: int; A: ptr Complex64; lda: int) {.importc: "cblas_zher", dynlib: libName.}


proc chpr*(order: OrderType; Uplo: UploType; N: int; alpha: float32; X: ptr Complex32;
           incX: int; A: ptr Complex32) {.importc: "cblas_chpr", dynlib: libName.}
proc zhpr*(order: OrderType; Uplo: UploType; N: int; alpha: float64; X: ptr Complex64;
           incX: int; A: ptr Complex64) {.importc: "cblas_zhpr", dynlib: libName.}


proc cher2*(order: OrderType; Uplo: UploType; N: int; alpha: ptr Complex32; X: ptr Complex32;
            incX: int; Y: ptr Complex32; incY: int; A: ptr Complex32; lda: int) {.
              importc: "cblas_cher2", dynlib: libName.}
proc zher2*(order: OrderType; Uplo: UploType; N: int; alpha: ptr Complex64; X: ptr Complex64;
            incX: int; Y: ptr Complex64; incY: int; A: ptr Complex64; lda: int) {.
              importc: "cblas_zher2", dynlib: libName.}


proc chpr2*(order: OrderType; Uplo: UploType; N: int; alpha: ptr Complex32; X: ptr Complex32;
            incX: int; Y: ptr Complex32; incY: int; Ap: ptr Complex32) {.importc: "cblas_chpr2",
                                                             dynlib: libName.}
proc zhpr2*(order: OrderType; Uplo: UploType; N: int; alpha: ptr Complex64; X: ptr Complex64;
            incX: int; Y: ptr Complex64; incY: int; Ap: ptr Complex64) {.importc: "cblas_zhpr2",
                                                             dynlib: libName.}
#
#  ===========================================================================
#  Prototypes for level 3 BLAS
#  ===========================================================================
#
#
#  Routines with standard 4 prefixes (S, D, C, Z)
#

proc gemm*(Order: OrderType; TransA: TransposeType; TransB: TransposeType;
           M: int; N: int; K: int; alpha: float32; A: ptr float32; lda: int; B: ptr float32;
           ldb: int; beta: float32; C: ptr float32; ldc: int) {.importc: "cblas_sgemm",
                                                                dynlib: libName.}
proc gemm*(Order: OrderType; TransA: TransposeType; TransB: TransposeType;
           M: int; N: int; K: int; alpha: float64; A: ptr float64; lda: int;
           B: ptr float64; ldb: int; beta: float64; C: ptr float64; ldc: int) {.
             importc: "cblas_dgemm", dynlib: libName.}
proc gemm*(Order: OrderType; TransA: TransposeType; TransB: TransposeType;
           M: int; N: int; K: int; alpha: ptr Complex32; A: ptr Complex32; lda: int; B: ptr Complex32;
           ldb: int; beta: ptr Complex32; C: ptr Complex32; ldc: int) {.importc: "cblas_cgemm",
                                                            dynlib: libName.}
proc gemm*(Order: OrderType; TransA: TransposeType; TransB: TransposeType;
           M: int; N: int; K: int; alpha: ptr Complex64; A: ptr Complex64; lda: int; B: ptr Complex64;
           ldb: int; beta: ptr Complex64; C: ptr Complex64; ldc: int) {.importc: "cblas_zgemm",
                                                            dynlib: libName.}


proc symm*(Order: OrderType; Side: SideType; Uplo: UploType; M: int; N: int;
           alpha: float32; A: ptr float32; lda: int; B: ptr float32; ldb: int; beta: float32;
           C: ptr float32; ldc: int) {.importc: "cblas_ssymm", dynlib: libName.}
proc symm*(Order: OrderType; Side: SideType; Uplo: UploType; M: int; N: int;
           alpha: float64; A: ptr float64; lda: int; B: ptr float64; ldb: int;
           beta: float64; C: ptr float64; ldc: int) {.importc: "cblas_dsymm",
                                                      dynlib: libName.}
proc symm*(Order: OrderType; Side: SideType; Uplo: UploType; M: int; N: int;
           alpha: ptr Complex32; A: ptr Complex32; lda: int; B: ptr Complex32; ldb: int; beta: ptr Complex32;
           C: ptr Complex32; ldc: int) {.importc: "cblas_csymm", dynlib: libName.}
proc symm*(Order: OrderType; Side: SideType; Uplo: UploType; M: int; N: int;
           alpha: ptr Complex64; A: ptr Complex64; lda: int; B: ptr Complex64; ldb: int; beta: ptr Complex64;
           C: ptr Complex64; ldc: int) {.importc: "cblas_zsymm", dynlib: libName.}


proc syrk*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
           K: int; alpha: float32; A: ptr float32; lda: int; beta: float32; C: ptr float32;
           ldc: int) {.importc: "cblas_ssyrk", dynlib: libName.}
proc syrk*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
           K: int; alpha: float64; A: ptr float64; lda: int; beta: float64;
           C: ptr float64; ldc: int) {.importc: "cblas_dsyrk", dynlib: libName.}
proc syrk*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
           K: int; alpha: ptr Complex32; A: ptr Complex32; lda: int; beta: ptr Complex32; C: ptr Complex32;
           ldc: int) {.importc: "cblas_csyrk", dynlib: libName.}
proc syrk*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
           K: int; alpha: ptr Complex64; A: ptr Complex64; lda: int; beta: ptr Complex64; C: ptr Complex64;
           ldc: int) {.importc: "cblas_zsyrk", dynlib: libName.}


proc syr2k*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
            K: int; alpha: float32; A: ptr float32; lda: int; B: ptr float32; ldb: int;
            beta: float32; C: ptr float32; ldc: int) {.importc: "cblas_ssyr2k",
                                                       dynlib: libName.}
proc syr2k*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
            K: int; alpha: float64; A: ptr float64; lda: int; B: ptr float64; ldb: int;
            beta: float64; C: ptr float64; ldc: int) {.importc: "cblas_dsyr2k",
                                                       dynlib: libName.}
proc syr2k*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
            K: int; alpha: ptr Complex32; A: ptr Complex32; lda: int; B: ptr Complex32; ldb: int;
            beta: ptr Complex32; C: ptr Complex32; ldc: int) {.importc: "cblas_csyr2k",
                                                   dynlib: libName.}
proc syr2k*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
            K: int; alpha: ptr Complex64; A: ptr Complex64; lda: int; B: ptr Complex64; ldb: int;
            beta: ptr Complex64; C: ptr Complex64; ldc: int) {.importc: "cblas_zsyr2k",
                                                   dynlib: libName.}


proc trmm*(Order: OrderType; Side: SideType; Uplo: UploType;
           TransA: TransposeType; Diag: DiagType; M: int; N: int; alpha: float32;
           A: ptr float32; lda: int; B: ptr float32; ldb: int) {.importc: "cblas_strmm",
                                                                 dynlib: libName.}
proc trmm*(Order: OrderType; Side: SideType; Uplo: UploType;
           TransA: TransposeType; Diag: DiagType; M: int; N: int; alpha: float64;
           A: ptr float64; lda: int; B: ptr float64; ldb: int) {.importc: "cblas_dtrmm",
                                                                 dynlib: libName.}
proc trmm*(Order: OrderType; Side: SideType; Uplo: UploType;
           TransA: TransposeType; Diag: DiagType; M: int; N: int; alpha: ptr Complex32;
           A: ptr Complex32; lda: int; B: ptr Complex32; ldb: int) {.importc: "cblas_ctrmm",
                                                         dynlib: libName.}
proc trmm*(Order: OrderType; Side: SideType; Uplo: UploType;
           TransA: TransposeType; Diag: DiagType; M: int; N: int; alpha: ptr Complex64;
           A: ptr Complex64; lda: int; B: ptr Complex64; ldb: int) {.importc: "cblas_ztrmm",
                                                         dynlib: libName.}


proc trsm*(Order: OrderType; Side: SideType; Uplo: UploType;
           TransA: TransposeType; Diag: DiagType; M: int; N: int; alpha: float32;
           A: ptr float32; lda: int; B: ptr float32; ldb: int) {.importc: "cblas_strsm",
                                                                 dynlib: libName.}
proc trsm*(Order: OrderType; Side: SideType; Uplo: UploType;
           TransA: TransposeType; Diag: DiagType; M: int; N: int; alpha: float64;
           A: ptr float64; lda: int; B: ptr float64; ldb: int) {.importc: "cblas_dtrsm",
                                                                 dynlib: libName.}
proc trsm*(Order: OrderType; Side: SideType; Uplo: UploType;
           TransA: TransposeType; Diag: DiagType; M: int; N: int; alpha: ptr Complex32;
           A: ptr Complex32; lda: int; B: ptr Complex32; ldb: int) {.importc: "cblas_ctrsm",
                                                         dynlib: libName.}
proc trsm*(Order: OrderType; Side: SideType; Uplo: UploType;
           TransA: TransposeType; Diag: DiagType; M: int; N: int; alpha: ptr Complex64;
           A: ptr Complex64; lda: int; B: ptr Complex64; ldb: int) {.importc: "cblas_ztrsm",
                                                         dynlib: libName.}
#
#  Routines with prefixes C and Z only
#

proc hemm*(Order: OrderType; Side: SideType; Uplo: UploType; M: int; N: int;
           alpha: ptr Complex32; A: ptr Complex32; lda: int; B: ptr Complex32; ldb: int; beta: ptr Complex32;
           C: ptr Complex32; ldc: int) {.importc: "cblas_chemm", dynlib: libName.}
proc hemm*(Order: OrderType; Side: SideType; Uplo: UploType; M: int; N: int;
           alpha: ptr Complex64; A: ptr Complex64; lda: int; B: ptr Complex64; ldb: int; beta: ptr Complex64;
           C: ptr Complex64; ldc: int) {.importc: "cblas_zhemm", dynlib: libName.}


proc herk*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
           K: int; alpha: float32; A: ptr Complex32; lda: int; beta: float32; C: ptr Complex32;
           ldc: int) {.importc: "cblas_cherk", dynlib: libName.}
proc herk*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
           K: int; alpha: float64; A: ptr Complex64; lda: int; beta: float64; C: ptr Complex64;
           ldc: int) {.importc: "cblas_zherk", dynlib: libName.}


proc her2k*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
            K: int; alpha: ptr Complex32; A: ptr Complex32; lda: int; B: ptr Complex32; ldb: int;
            beta: float32; C: ptr Complex32; ldc: int) {.importc: "cblas_cher2k",
                                                         dynlib: libName.}
proc her2k*(Order: OrderType; Uplo: UploType; Trans: TransposeType; N: int;
            K: int; alpha: ptr Complex64; A: ptr Complex64; lda: int; B: ptr Complex64; ldb: int;
            beta: float64; C: ptr Complex64; ldc: int) {.importc: "cblas_zher2k",
                                                         dynlib: libName.}
