from mpi4py import MPI
import ctypes
import sys

size = MPI.COMM_WORLD.Get_size()
rank = MPI.COMM_WORLD.Get_rank()
name = MPI.Get_processor_name()

sys.stdout.write(\
    "Hello, World! I am process %d of %d on %s.\n"% \
            (rank, size, name))

torun = ctypes.cdll.LoadLibrary("./basic_wrapper.so")

torun.init()
