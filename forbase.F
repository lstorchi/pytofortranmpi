      module for_wrapper

      use, intrinsic :: iso_c_binding

      implicit none

      contains

ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

      subroutine run() 

      implicit none

      include "mpif.h"

      character*(MPI_MAX_PROCESSOR_NAME) name
      integer :: mpierr, numprocs, rank, resultlen

      call MPI_Comm_rank (MPI_COMM_WORLD, rank, mpierr)
      call MPI_Comm_size (MPI_COMM_WORLD, numprocs, mpierr)

      call MPI_Comm_rank (MPI_COMM_WORLD, rank, mpierr)
      call MPI_Comm_size (MPI_COMM_WORLD, numprocs, mpierr)
      call MPI_Get_processor_name(name, resultlen, mpierr)

      write(*,*) "  => In Fortran: ", rank, " of ", numprocs

      end subroutine run

ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

      end module
