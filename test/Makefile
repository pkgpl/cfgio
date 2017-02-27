FC=ifort
FFLAGS=-O2 -assume byterecl

INC= ../include
LIB= ../lib


all: test_write.e test_read.e test_intpl.e

.SUFFIXES: .e .o .f90
%.e: %.o
	$(FC) $(FFLAGS) -o $@ $^ -L$(LIB) -lcfgio

%.o: %.f90
	$(FC) $(FFLAG) -c $< -I$(INC)

clean:
	rm *.e
