CC = iccavr
LIB = ilibw
CFLAGS =  -e -D__ICC_VERSION=722 -DATMega16  -l -g -MLongJump -MHasMul -MEnhanced 
ASFLAGS = $(CFLAGS) 
LFLAGS =  -g -e:0x4000 -ucrtatmega.o -bfunc_lit:0x54.0x4000 -dram_end:0x45f -bdata:0x60.0x45f -dhwstk_size:30 -beeprom:0.512 -fihx_coff -S2
FILES = mid_work.o 

MID_WORK:	$(FILES)
	$(CC) -o MID_WORK $(LFLAGS) @MID_WORK.lk   -lcatmega
mid_work.o: "F:\ICCV for AVR\include\iom16v.h"
mid_work.o:	mid_work.c
	$(CC) -c $(CFLAGS) mid_work.c
