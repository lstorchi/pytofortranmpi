include ./config.mk

BASICWLIB = basic_wrapper.so

OBJ = forbase.o \
      c_wrapper.o 

LIBS = /usr/lib/x86_64-linux-gnu/openmpi/lib/libmpi_mpifh.so

all : $(BASICWLIB)

FFLAGS+= -fPIC -I /usr/lib/x86_64-linux-gnu/openmpi/include/
CFLAGS+= -fPIC 

$(BASICWLIB): $(OBJ)
	$(FC) -shared $(OBJ) -o $(BASICWLIB) $(LIBS) 

clean:
	rm -f *.o *.mod *__genmod.f90 $(BASICWLIB) 
