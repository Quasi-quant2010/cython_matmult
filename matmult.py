# -*- coding: utf-8 -*-

import time
import numpy as np
import matmult1 as m1
import matmult1_2 as m1_2
import matmult2 as m2
import matmult3 as m3
import matmult4 as m4
import matmult5 as m5

import pstats, cProfile

N = 100
M = 100
L = 100
x = np.random.randn(N, L)
y = np.random.randn(L, M)
iteration = 100

# 1
print "pure python"
cProfile.runctx("m1.wrapper_matmult(x,y,iteration)", globals(), locals(), "Profile.prof")
s = pstats.Stats("Profile.prof")
s.strip_dirs().sort_stats("time").print_stats()

# 1_2
print "python numpy"
cProfile.runctx("m1_2.wrapper_matmult(x,y,iteration)", globals(), locals(), "Profile.prof")
s = pstats.Stats("Profile.prof")
s.strip_dirs().sort_stats("time").print_stats()

# 2
print "cython class"
cProfile.runctx("m2.wrapper_matmult(x,y,iteration)", globals(), locals(), "Profile.prof")
s = pstats.Stats("Profile.prof")
s.strip_dirs().sort_stats("time").print_stats()

# 3
print "cython function"
cProfile.runctx("m3.wrapper_matmult(x,y,iteration)", globals(), locals(), "Profile.prof")
s = pstats.Stats("Profile.prof")
s.strip_dirs().sort_stats("time").print_stats()

# 4
print "cython function typed memoryview and raw pointer"
cProfile.runctx("m4.wrapper_matmult(x,y,iteration)", globals(), locals(), "Profile.prof")
s = pstats.Stats("Profile.prof")
s.strip_dirs().sort_stats("time").print_stats()

# 5
print "cython class typed memoryview"
cProfile.runctx("m5.wrapper_matmult(x,y,iteration)", globals(), locals(), "Profile.prof")
s = pstats.Stats("Profile.prof")
s.strip_dirs().sort_stats("time").print_stats()
