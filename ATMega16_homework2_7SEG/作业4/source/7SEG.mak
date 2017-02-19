CC = iccavr
LIB = ilibw
CFLAGS =  -e -D__ICC_VERSION=722 -DATMega16  -l -g -MLongJump -MHasMul -MEnhanced 
ASFLAGS = $(CFLAGS) 
LFLAGS =  -g -e:0x4000 -ucrtatmega.o -bfunc_lit:0x54.0x4000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:30 -beeprom:0.512 -fihx_coff -S2
FILES = 7SEG.o 

7SEG:	$(FILES)
	$(CC) -o 7SEG $(LFLAGS) @7SEG.lk   -lcatmega
7SEG.o: "F:\ICCV for AVR\include\iom16v.h"
7SEG.o:	7SEG.c
	$(CC) -c $(CFLAGS) 7SEG.c
