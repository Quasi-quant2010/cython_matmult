# -*- coding: utf-8 -*-

import numpy as np
cimport numpy as np
cimport cython


cdef matmult_intrn(np.ndarray[np.double_t, ndim=2] a,
                   np.ndarray[np.double_t, ndim=2] b,
                   int iterations):
    cdef int i,j,k
    cdef int row_a, col_a, col_b
    cdef int iteration
    
    row_a = a.shape[0]
    col_a = a.shape[1]
    col_b = b.shape[1]

    cdef np.ndarray[np.double_t, ndim=2] c = \
        np.zeros( (row_a,col_b), dtype=np.double )

    for iteration in xrange(iterations):
        for i in xrange(row_a):
            for j in xrange(col_b):
                for k in xrange(col_a):
                    c[i,j] += a[i,k] * b[k,j]
    return c


def wrapper_matmult(np.ndarray[np.double_t, ndim=2] x,
                    np.ndarray[np.double_t, ndim=2] y,
                    int iterations):
    """
    A warpper for matmult_intrn
    """
    cdef int row_x, col_y
    row_x = x.shape[0]
    col_y = y.shape[1] # row_b = col_a
    
    # initial
    cdef np.ndarray[np.double_t, ndim=2] z = \
        np.zeros( (row_x,col_y), dtype=np.double )
    z = matmult_intrn(x,y,iterations)
    return z
