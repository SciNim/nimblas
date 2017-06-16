# Copyright 2017 UniCredit S.p.A.
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

import unittest, nimblas/cblas

template first[A](x: openArray[A]): ptr A = addr(x[0])

suite "CBLAS test":
  test "vector dot product":
    var
      u = [1.0, 2.0, 3.0, 4.0]
      v = [2.0, 2.0, 2.0, 1.0]

    let d = ddot(4, u.first, 1, v.first, 1)
    check d == 16.0

  test "matrix product":
    var
      m = [
        1.0, 2.0, 3.0, 4.0,
        5.0, 6.0, 7.0, 8.0,
        1.0, 2.0, 1.0, 1.0
      ]
      n = [
        2.0, 2.0, 2.0,
        1.0, 2.0, 3.0
      ]
      r: array[8, float]

    dgemm(CblasColMajor, CblasNoTrans, CblasNoTrans, 4, 2, 3, 1, m.first,
      4, n.first, 3, 0, r.first, 4)
    check @r[0..3] == @[14.0, 20.0, 22.0, 26.0]
    check @r[4..7] == @[14.0, 20.0, 20.0, 23.0]
