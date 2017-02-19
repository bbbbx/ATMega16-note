NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0054   0008 =      8. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __lit_start
       005C  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   005C   00A8 =    168. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       005C  __idata_start
       0104  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0104   062A =   1578. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0082  __start
       0082  __text_start
       00A4  _exit
       00A5  _delay_ms
       00BA  _PWM_OC2_init
       00C8  _PWM_OC0_init
       00D6  _PWM_OC1A_init
       00DD  _main
       0145  mod16s
       0149  div16s
       0163  mod16u
       0165  div16u
       0166  xdiv16u
       017F  push_xgsetF000
       0184  pop_xgsetF000
       0189  neg32
       0192  lpm32
       01A6  fpsub
       01A8  fpadd
       01A9  fpadd_alt
       0210  fpsub2
       021B  fpint
       024D  uint2fp
       024F  int2fp
       0258  ulong2fp
       025A  long2fp
       0271  fpdiv1
       027A  fpdiv2
       0284  fpdiv1x
       0290  fpdiv2x
       030B  unpacks
       0313  tstR16_R19
       031B  unpacku
       0334  normalize_and_pack
       0369  pack
       0379  saveFPRegs
       0388  restoreFPRegs
       0397  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   00A8 =    168. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  _MUSIC_F
       0060  __data_start
       00B4  _MUSIC_time
       0108  __data_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

F:\ICCV for AVR\lib\crtatmega.o	[ crtatmega.s ]
PWM.o	[ PWM.c ]
<library>	[ div16s.s, div16u.s, gpushy.s, lneg.s, lpm32.s, fpadd.s, fpsub2.s, fpint.s, int2fp.s, fpdiv_new.s, fputil.s ]


User Global Definitions

ram_end = 0x45f
hwstk_size = 0x1e

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:0.512

