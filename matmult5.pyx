# -*- coding: utf-8 -*-

import numpy as np
cimport numpy as np
cimport cython

cdef class matmult_intrn:

    cdef:
        int row_a, col_a, col_b
        double[:, ::1] a,b,c

    @cython.boundscheck(False)
    @cython.wraparound(False)        
    def __init__(self,
                 double[:, ::1] a,
                 double[:, ::1] b):
        self.row_a = a.shape[0]
        self.col_a = a.shape[1]
        self.col_b = b.shape[1]
        self.a = a
        self.b = b
        self.c = np.zeros((self.row_a, self.col_b), dtype=np.double)
    
    def calculate(self):
        cdef int i,j,k
        for i in xrange(self.row_a):
            for j in xrange(self.col_b):
                for k in xrange(self.col_a):
                    self.c[i, j] += self.a[i, k] * self.b[k, j]
        ascontig = np.ascontiguousarray
        return ascontig(self.c,dtype=np.double)

@cython.boundscheck(False)
@cython.wraparound(False)
def wrapper_matmult(double[:, ::1] X,
                    double[:, ::1] Y,
                    int iterations):

    cdef int row_x, col_y
    row_x = X.shape[0]
    col_x = X.shape[1]
    col_y = Y.shape[1] # row_b = col_a
        
    # initial
    cdef np.ndarray[np.double_t, ndim=2] Z
    cdef int iteration
    mat = matmult_intrn(X,Y)
    for iteration in xrange(iterations):
        Z = mat.calculate()
    return Z
