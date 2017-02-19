CC = iccavr
LIB = ilibw
CFLAGS =  -e -D__ICC_VERSION=722 -DATMega16  -l -g -MLongJump -MHasMul -MEnhanced 
ASFLAGS = $(CFLAGS) 
LFLAGS =  -g -e:0x4000 -ucrtatmega.o -bfunc_lit:0x54.0x4000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:30 -beeprom:0.512 -fihx_coff -S2
FILES = TC1.o 

TC1:	$(FILES)
	$(CC) -o TC1 $(LFLAGS) @TC1.lk   -lcatmega
TC1.o: "F:\ICCV for AVR\include\iom16v.h"
TC1.o:	TC1.c
	$(CC) -c $(CFLAGS) TC1.c
