# -*- coding: utf-8 -*-

import numpy as np
cimport numpy as np
cimport cython

# define a function pointer to a metric
ctypedef void (*metric_ptr)(double*, int, int,
                            double*, int,
                            double*)

@cython.boundscheck(False)
@cython.wraparound(False)
cdef void matmult_intrn(double *x, int row_x, int col_x,
                        double *y, int col_y,
                        double *z):

    cdef int i,j,k
    for i in xrange(row_x):
        for j in xrange(col_y):
            for k in xrange(col_x):
                z[i*row_x + j] += x[i*row_x + k] * y[k*col_x + j]


@cython.boundscheck(False)
@cython.wraparound(False)
def wrapper_matmult(double[:, ::1] X,
                    double[:, ::1] Y,
                    int iterations):

    cdef metric_ptr dist_func
    dist_func = &matmult_intrn

    cdef int row_x, col_y
    row_x = X.shape[0]
    col_x = X.shape[1]
    col_y = Y.shape[1] # row_b = col_a
        
    # initial
    cdef double[:, ::1] Z = np.zeros((row_x, col_y))
    
    # 配列にポインターを使ってアクセス
    #ZptrにDの先頭アドレスを渡す.　ただし、cdef double *Zptr = &Z はエラー
    cdef double *Zptr = &Z[0, 0] 
    cdef double *Xptr = &X[0, 0]
    cdef double *Yptr = &Y[0, 0]
    
    cdef int iteration
    for iteration in xrange(iterations):
        matmult_intrn(Xptr, row_x, col_x,
                      Yptr, col_y,
                      Zptr)
    
    ascontig = np.ascontiguousarray
    return ascontig(Z,dtype=np.double)
