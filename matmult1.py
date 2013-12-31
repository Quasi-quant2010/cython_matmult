# -*- coding: utf-8 -*-

import numpy as np

def matmult_intrn(a,b,iterations):
    
    row_c = a.shape[0]
    col_c = b.shape[1]
    c = np.zeros( (row_c,col_c), dtype=np.double )

    for iteration in xrange(iterations):
        for i in xrange(a.shape[0]):
            for j in xrange(b.shape[1]):
                for k in xrange(a.shape[1]):
                    c[i,j] += a[i,k] * b[k,j]
    return c


def wrapper_matmult(x,y,iterations):
    """
    A warpper for matmult_intrn
    """

    row_x = x.shape[0]
    col_y = y.shape[1] # row_b = col_a
    
    # initial
    z = np.zeros( (row_x,col_y), dtype=np.double )
    z = matmult_intrn(x,y,iterations)
    return z
