include ./config.mk

BASICWLIB = basic_wrapper.so

OBJ = forbase.o \
      c_wrapper.o 

all : $(BASICWLIB)

FFLAGS+= -fPIC 
CFLAGS+= -fPIC 

$(BASICWLIB): $(OBJ)
	$(FC) -shared $(OBJ) -o $(BASICWLIB) $(LIBS)
	cp $(BASICWLIB) ../lib

clean:
	rm -f *.o *.mod *__genmod.f90 $(BASICWLIB) 
