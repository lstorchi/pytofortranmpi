# redo

# debug yes or no
DEBUG=no

# profile yes or no
PROFILE=no

# shared library
SHARED=yes

#is used only by serial
#use Intel compiler
USEINTEL=no

ifeq ($(USEINTEL),yes)
  FC = ifort
  CC = icc

  ifeq ($(PROFILE),yes)
    FFLAGS = -pg
    CFLAGS = -pg
    LINKFLAGS = -pg
  else
    FFLAGS =
    CFLAGS =
  endif

  INCLUDE = 

  ifeq ($(DEBUG),yes)
    FFLAGS += -r8 -check all -check noarg_temp_created -traceback -warn all -O0 -g -132
    CFLAGS += -D_FILE_OFFSET_BITS=64 -O0 -g
  else
    FFLAGS += -r8 -check all -check noarg_temp_created -traceback -warn all -O2 -132 
    FFLAGS = -r8 -warn all -O3 -132
    #FFLAGS += -C -O0 -r8 -warn all -132 -I./$(MODIR)
    CFLAGS += -D_FILE_OFFSET_BITS=64 -O3
  endif

  LIBS += $(BLASLAPACK)
else
  FC = gfortran
  CC = gcc
  FOPT = 
  INCLUDE = 
  
  ifeq ($(PROFILE),yes)
    FFLAGS = -pg
    CFLAGS = -pg
    LINKFLAGS = -pg
  else
    FFLAGS =
    CFLAGS =
  endif

  ifeq ($(DEBUG),yes)
    FFLAGS += -finit-local-zero -fdefault-double-8 -fdefault-real-8 -O0 -ffixed-line-length-132 -fbacktrace -ffpe-trap=zero,overflow,underflow -g -W -Wall -I./$(MODIR)
    CFLAGS += -D_FILE_OFFSET_BITS=64 -O0 -g -W -Wall
  else
    #FFLAGS += -finit-local-zero -fdefault-double-8 -fdefault-real-8 -O2 -I./$(MODIR) -W -Wall -ffixed-line-length-132
    FFLAGS +=  -fdefault-double-8 -fdefault-real-8 -O2 -I./$(MODIR) -W -ffixed-line-length-132
    CFLAGS += -D_FILE_OFFSET_BITS=64 -O2 -W 
  endif

  LIBS += $(BLASLAPACK)
endif

CFLAGS += -W -Wall -DUSE_UNDER

.SUFFIXES:

%.o:	%.c
	$(CC) $(CFLAGS) $(COPT) $(INCLUDE) -c $< 

%.o:	%.F
	$(FC) $(FFLAGS) $(FOPT) $(INCLUDE) -o $@ -c $< 

%.o:	%.f
	$(FC) $(FFLAGS) $(FOPT) $(INCLUDE) -o $@ -c $< 

%.o:	%.f90
	$(FC) $(FFLAGS) $(FOPT) $(INCLUDE) -o $@ -c $< 

%.o:	%.F90
	$(FC) $(FFLAGS) $(FOPT) $(INCLUDE) -o $@ -c $< 

ifeq ($(FORBGQ),no)
%.o:    %.f90
	$(FC) $(FFLAGS) $(FOPT) $(INCLUDE) -o $@ -c $< 
else
%.o : %.f90
	$(FC) $(FBASICF) -o $@ -c $<
endif
