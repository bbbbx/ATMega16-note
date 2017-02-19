NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0054   00DC =    220. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       002A  __text_start
       002A  __start
       004C  _exit
       004D  _usart_init
       0058  _usart_sendEnd
       008D  _usart_send
       0093  _main
       0098  __text_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0038 =     56. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

F:\ICCV for AVR\lib\crtatmega.o	[ crtatmega.s ]
usart.o	[ usart.c ]
<library>	

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x1e

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:0.512

