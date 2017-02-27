FC=ifort
FFLAG=-O2
INC=../include
LIB=../lib

TARGET=libcfgio.a
OBJECTS= string_conv_mod.o cfgio_mod.o

all: $(TARGET)

$(TARGET): $(OBJECTS)
	ar rc $@ $^
	ranlib $@

.SUFFIXES: .o .f90
%.o: %.f90
	$(FC) $(FFLAG) -c $< -I$(INC)

install: $(TARGET)
	mkdir -p $(INC) $(LIB)
	cp *.mod $(INC)
	cp $(TARGET) $(LIB)

clean:
	rm *.mod *.o *.a
