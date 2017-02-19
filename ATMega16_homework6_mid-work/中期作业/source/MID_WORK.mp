NOTE: AVR Code addresses are word addresses
All other addresses (including ones in FLASH) are byte addresses

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                           idata   0054   001A =     26. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0054  __idata_start
       006E  __idata_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   006E   044A =   1098. bytes (rel,con,rom)

       Addr  Global Symbol
      -----  --------------------------------
       0037  __start
       0037  __text_start
       0059  _exit
       005A  _delay_ms
       006F  _SEG7_init
       0076  _SEG7_show_year
       009E  _SEG7_show_date
       00C6  _SEG7_show_time
       00EE  _button_init
       00F3  _button_scan
       0200  _alarm_clock_open
       0202  _alarm_clock_close
       0204  _PWM_OC2_init
       020D  _LED_init
       0217  _main
       0252  push_xgsetF000
       0257  pop_xgsetF000
       025C  __text_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            data   0060   001A =     26. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0060  _SEG7_num_ca
       0060  __data_start
       006A  _SEG7_numWithDot_ca
       0074  _SEG7_flag
       0076  _alarm_clock_flag
       0078  _motor_EN
       007A  __data_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                          vector   0000   0004 =      4. bytes (abs,ovr,rom)

Files Linked      [ module(s) ]

F:\ICCV for AVR\lib\crtatmega.o	[ crtatmega.s ]
mid_work.o	[ mid_work.c ]
<library>	[ gpushy.s ]

User Global Definitions

ram_end = 0x45f
hwstk_size = 0x1e

User Base Address Definitions

func_lit = 0x54
data = 0x60
eeprom:0.512

