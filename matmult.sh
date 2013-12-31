# !/bin/sh
python setup.py build_ext --inplace

OMP_NUM_THREADS=4 python matmult.py > time.txt

