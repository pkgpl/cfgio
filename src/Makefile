# PRJ:=cfgio
PRJ:= 
FC=ifort
FFLAG=-O2
INC=../include

# Added installation Path
# prefix:=$(HOME)/.local
prefix:=..
INSTALL_LIB= $(prefix)/lib
INSTALL_INCLUDE= $(prefix)/include/$(PRJ)

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
	mkdir -p $(INSTALL_INCLUDE) $(INSTALL_LIB)
	cp *.mod $(INSTALL_INCLUDE)
	cp $(TARGET) $(INSTALL_LIB)

clean:
	rm *.mod *.o *.a
	
