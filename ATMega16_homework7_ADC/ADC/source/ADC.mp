NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   0054   000C =     12. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __lit_start
       0060  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0060   0014 =     20. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __idata_start
       0074  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0074   072C =   1836. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       003A  __text_start
       003A  __start
       005C  _exit
       005D  _delay_ms
       0072  _ADC_init
       0077  _get_AD
       007E  _main
       0165  div32u
       0167  mod32u
       016B  div32s
       016D  mod32s
       0199  long_div_prolog
       01AC  long_div_epilog
       01BC  tst_R16_R19
       01C1  tst_R24_R27
       01C6  neg_R24_R27
       01CF  push_xgsetF000
       01D4  pop_xgsetF000
       01D9  neg32
       01E2  lpm32
       01F6  fpint
       0228  uint2fp
       022A  int2fp
       0233  ulong2fp
       0235  long2fp
       024C  fpdiv1
       0255  fpdiv2
       025F  fpdiv1x
       026B  fpdiv2x
       02E6  unpacks
       02EE  tstR16_R19
       02F6  unpacku
       030F  normalize_and_pack
       0344  pack
       0354  saveFPRegs
       0363  restoreFPRegs
       0372  fpmule
       03C5  fpmule2
       03D0  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   0014 =     20. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  __data_start
       0060  _SEG7_table_ca
       0074  __data_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

F:\ICCV for AVR\lib\crtatmega.o	[ crtatmega.s ]
ADC.o	[ ADC.c ]
<library>	[ div32.s, gpushy.s, lneg.s, lpm32.s, fpint.s, int2fp.s, fpdiv_new.s, fputil.s, fpmule.s, fpmule2.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x1e

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:0.512

