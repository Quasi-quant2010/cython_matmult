# cython: boundscheck=False
# cython: wraparound=False
# cython: profile=True

import numpy as np
cimport numpy as np
cimport cython

cdef extern from 'stdlib.h':
    ctypedef unsigned long size_t
    void *malloc(size_t size)
    void free(void *prt)

cdef class matmult2:

    cdef:
        int row_a, col_a, col_b
        double *a, *b, *c

    def __cinit__(self,
                  np.ndarray[np.double_t, ndim=2] a,
                  np.ndarray[np.double_t, ndim=2] b):
        #print '__cinit__'
        self.row_a = a.shape[0]
        self.col_a = a.shape[1]        
        self.col_b = b.shape[1] # row_b = col_a

        # allocate a,b,c
        self.a = <double*>malloc((self.row_a*self.col_a) * sizeof(double))
        self.b = <double*>malloc((self.col_a*self.col_b) * sizeof(double))
        self.c = <double*>malloc((self.row_a*self.col_b) * sizeof(double))
        if not self.a or not self.b or not self.c:
            raise MemoryError("Cannot allocate memory.")

        # initialize
        cdef i,j        
        for i in xrange(self.row_a):
            for j in xrange(self.col_a):
                self.a[i*self.col_a + j] = a[i,j]

        for i in xrange(self.col_a):
            for j in xrange(self.col_b):
                self.b[i*self.col_b + j] = b[i,j]

        for i in xrange(self.row_a):
            for j in xrange(self.col_b):
                self.c[i*self.col_b + j] = 0.0             

    cdef void main(self, double *_c):
        cdef i,j,k
        for i in xrange(self.row_a):
            for j in xrange(self.col_b):
                for k in xrange(self.col_a):
                    self.c[i*self.col_b + j] += \
                        self.a[i*self.col_a + k] * self.b[k*self.col_b + j]
                _c[i*self.col_b + j] = self.c[i*self.col_b + j]

    def __dealloc__(self):
        #print '__dealloc__'
        # called when cleaning up the object; free malloc'd memory
        if self.a:
            free(self.a); self.a == NULL
        if self.b:
            free(self.b); self.b == NULL
        if self.c:
            free(self.c); self.c == NULL    


def wrapper_matmult(np.ndarray[np.double_t, ndim=2] x,
                    np.ndarray[np.double_t, ndim=2] y,
                    int iterations):
    """ a wrapper for matmult() """
    cdef int i
    cdef np.ndarray[np.double_t, ndim=2] z

    # initialize
    mat = matmult2(x, y)
    for i in xrange(iterations):
        #print 'iterations is %d' % (i)
        z = np.zeros((x.shape[0], y.shape[1]), dtype=np.double)
        mat.main(<double*>z.data)
    return z
