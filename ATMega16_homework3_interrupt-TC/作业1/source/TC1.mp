NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0054   0010 =     16. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __idata_start
       0064  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0064   0244 =    580. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0032  __start
       0032  __text_start
       0054  _exit
       0055  _delay_ms
       006A  _TC1
       00FE  _main
       0110  mod16s
       0114  div16s
       012E  mod16u
       0130  div16u
       0131  xdiv16u
       014A  push_xgsetF000
       014F  pop_xgsetF000
       0154  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0010 =     16. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0060  _table_ca
       006A  _GEWEI
       006C  _SHIWEI
       006E  _COUNT
       0070  __data_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0024 =     36. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

F:\ICCV for AVR\lib\crtatmega.o	[ crtatmega.s ]
TC1.o	[ TC1.c ]
<library>	[ div16s.s, div16u.s, gpushy.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x1e

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:0.512

