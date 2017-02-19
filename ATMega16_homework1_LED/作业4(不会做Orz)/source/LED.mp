NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0054   0001 =      1. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __idata_start
       0055  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0056   060A =   1546. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       002B  __start
       002B  __text_start
       004D  _exit
       004E  _delay
       0062  _LED_down_0
       009F  _LED_down_1
       00DC  _LED_down_2
       0119  _LED_down_3
       0156  _LED_down
       019B  _LED_right_0
       01D8  _LED_right_1
       0215  _LED_right_2
       0252  _LED_right_3
       028F  _LED_right
       02D4  _LED_up
       02D5  _LED_left
       02D6  _LED_init
       02F2  _main
       0326  push_xgsetF000
       032B  pop_xgsetF000
       0330  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0001 =      1. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0060  _delayMs
       0061  __data_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

F:\ICCV for AVR\lib\crtatmega.o	[ crtatmega.s ]
LED.o	[ LED.c ]
<library>	[ gpushy.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x1e

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:0.512

