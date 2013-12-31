# -*- coding: utf-8 -*-

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy as np
import sys, os, shutil
import itertools


path = os.getenv('PATH').split(':')
ld_library_path = os.getenv('LD_LIBRARY_PATH').split(':')
man_path = os.getenv('MANPATH').split(':')
cplus_include_path = os.getenv('CPLUS_INCLUDE_PATH').split(':')

# clean previous build
for root, dirs, files in os.walk('.',topdown=False):
    for name in files:
        if name.endswith('.so'):
            os.remove(os.path.join(root,name))
            #print os.path.join(root,name)
    for name in dirs:
        if (name=='build'):
            shutil.rmtree(name)

# build
ext1 = Extension(
    'matmult1', ['matmult1.py'],
    include_dirs = [element for element in itertools.chain([np.get_include()], cplus_include_path)],
    library_dirs = [element for element in itertools.chain(ld_library_path, man_path)],
    libraries=['openblas'],
    extra_compile_args=['-fopenmp','-O3']
    )

ext1_2 = Extension(
    'matmult1_2', ['matmult1_2.py'],
    include_dirs = [element for element in itertools.chain([np.get_include()], cplus_include_path)],
    library_dirs = [element for element in itertools.chain(ld_library_path, man_path)],
    libraries=['openblas'],
    extra_compile_args=['-fopenmp','-O3']
    )

ext2 = Extension(
    'matmult2', ['matmult2.pyx'],
    include_dirs = [element for element in itertools.chain([np.get_include()], cplus_include_path)],
    library_dirs = [element for element in itertools.chain(ld_library_path, man_path)],
    libraries=['openblas'],
    extra_compile_args=['-fopenmp','-O3']
    )

ext3 = Extension(
    'matmult3', ['matmult3.pyx'],
    include_dirs = [element for element in itertools.chain([np.get_include()], cplus_include_path)],
    library_dirs = [element for element in itertools.chain(ld_library_path, man_path)],
    libraries=['openblas'],
    extra_compile_args=['-fopenmp','-O3']
    )

ext4 = Extension(
    'matmult4', ['matmult4.pyx'],
    include_dirs = [element for element in itertools.chain([np.get_include()], cplus_include_path)],
    library_dirs = [element for element in itertools.chain(ld_library_path, man_path)],
    libraries=['openblas'],
    extra_compile_args=['-fopenmp','-O3']
    )

ext5 = Extension(
    'matmult5', ['matmult5.pyx'],
    include_dirs = [element for element in itertools.chain([np.get_include()], cplus_include_path)],
    library_dirs = [element for element in itertools.chain(ld_library_path, man_path)],
    libraries=['openblas'],
    extra_compile_args=['-fopenmp','-O3']
    )


setup(ext_modules=[ext1,ext1_2,ext2,ext3,ext4,ext5],
      cmdclass = {'build_ext': build_ext})
