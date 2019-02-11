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

when defined(windows):
  const
    libSuffix = ".dll"
    libPrefix = ""
elif defined(macosx):
  const
    libSuffix = ".dylib"
    libPrefix = "lib"
else:
  const
    libSuffix = ".so(||.3|.2|.1|.0)"
    libPrefix = "lib"

const
  blas {.strdefine.} = "blas"
  libName = libPrefix & blas & libSuffix

when defined(atlas):
  {.warning: """
    The flag -d:atlas is deprecated since NimBLAS 0.2
Use -d:blas=LIBNAME instead
  """ .}

when  defined(openblas):
  {.warning: """
    The flag -d:openblas is deprecated since NimBLAS 0.2
Use -d:blas=LIBNAME instead
  """ .}

when defined(mkl):
  {.warning: """
    The flag -d:mkl is deprecated since NimBLAS 0.2
Use -d:blas=LIBNAME instead
  """ .}

{.hint: "Using BLAS library with name: " & libName .}
