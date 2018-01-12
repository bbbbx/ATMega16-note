TICK     EQU    4700
;STOPWATCHTICK   EQU   50   
STOPWATCHTICK   EQU   65536-9200
TICKADDRESS EQU 30h
STOPWATCHTICKADDRESS EQU  31h
T0INIT   EQU    256-200
;T1INIT   EQU    256-200
LED0     EQU    P1.0
LED1     EQU    P1.1
LED2     EQU    P1.2
LED3     EQU    P1.3
FLAG     BIT    20h.0
CLOCKFLAG     BIT    20h.1
CLOCKVALUE    EQU    70h
KEYBOARD0 EQU   P3.2
KEYBOARD1 EQU   P3.3
KEYBOARD2 EQU   P3.4
KEYBOARD3 EQU   P3.5
seconds0Addr  EQU   50h
seconds1Addr  EQU   51h
minutes0Addr  EQU   52h
minutes1Addr  EQU   53h
hours0Addr    EQU   54h
hours1Addr    EQU   55h
stopwatch0Addr    EQU   60h
stopwatch1Addr    EQU   61h
stopwatch2Addr    EQU   62h
stopwatch3Addr    EQU   63h
stopwatch0Addr1    EQU   64h
stopwatch1Addr1    EQU   65h
stopwatch2Addr1    EQU   66h
stopwatch3Addr1    EQU   67h

    ORG   0000H
    LJMP  MAIN
    ORG   000BH
    LJMP  timer0
    ORG   001BH
    LJMP  timer1

ORG  0031H
LEDMAP:              ; ¹²ÑôÊıÂë¹Ü¶ÎÂë
    DB  0C0H, 0F9H, 0A4H, 0B0H, 99H, 92H, 82H, 0F8H, 80H, 90H
LEDWITHDOTMAP:              ; ¹²ÑôÊıÂë¹Ü¶ÎÂë
    DB  40H, 79H, 24H, 30H, 19H, 12H, 02H, 78H, 00H, 10H

Delay: ;
    MOV   R7, #0
delayLoop:
    DJNZ  R7, delayLoop
    DJNZ  R6, delayLoop
    RET

    ORG 300h
timer0: ; ¶¨Ê±¼ÆÊıÆ÷0×Ó³ÌĞò
    PUSH    PSW
    PUSH    A

    MOV     A, TICKADDRESS+1  ; å®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°ä½å…«ä½
    JNZ     tickLowNoEquZero      ; Aï¼ˆå®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°ä½å…«ä½ï¼‰ä¸ç­‰äº0
    DEC     TICKADDRESS       ; å®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°é«˜å…«ä½-1
tickLowNoEquZero:
    DEC     TICKADDRESS+1       ; å®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°ä½å…«ä½-1
    MOV     A, TICKADDRESS      ; åˆ¤æ–­å®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°é«˜ã€ä½å…«ä½æ˜¯å¦åŒæ—¶ä¸º0
    ORL     A, TICKADDRESS+1    ; åˆ¤æ–­å®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°é«˜ã€ä½å…«ä½æ˜¯å¦åŒæ—¶ä¸º0
    JNZ     exit   ; å®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°é«˜å…«ä½ä¸ä¸º0
    MOV     TICKADDRESS, #HIGH(TICK)  ; é‡æ–°è®¾ç½®å®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°é«˜å…«ä½
    MOV     TICKADDRESS+1, #LOW(TICK) ; é‡æ–°è®¾ç½®å®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°ä½å…«ä½
    ; [TODO] æ·»åŠ  1s åè¦åšçš„åŠ¨ä½œ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOV     A, CLOCKVALUE
    ;JZ      clockvalueIsZero
    ; [TODO] start ·äÃùÆ÷Öµ²»Îª0 
    ; [TODO] end ·äÃùÆ÷Öµ²»Îª0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
clockvalueIsZero:  
    MOV     A, seconds0Addr
    CJNE    A, #9, seconds0AddrNoEqu9
    MOV     seconds0Addr, #0  ; ç§’ä¸ªä½ç­‰äº9ï¼Œé‡æ–°èµ‹å€¼ä¸º0
    MOV     A, seconds1Addr
    CJNE    A, #5, seconds1AddrNoEqu5
    MOV     seconds1Addr, #0  ; ç§’åä½=5ï¼Œé‡æ–°ç½®0
    MOV     A, minutes0Addr
    CJNE    A, #9, minutes0AddrNoEqu9
    MOV     minutes0Addr, #0
    MOV     A, minutes1Addr
    CJNE    A, #5, minutes1AddrNoEqu5
    MOV     minutes1Addr, #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOV     A, hours0Addr
    ADD     A, hours1Addr
    MOV     CLOCKVALUE, A    
    INC     CLOCKVALUE
    ;CLR     CLOCKFLAG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOV     A, hours0Addr
    CJNE    A, #9, hours0AddrNoEqu9
    MOV     hours0Addr, #0
    MOV     A, hours1Addr
    CJNE    A, #1, hours1AddrNoEqu1
    MOV     hours1Addr, #0
    LJMP    exit   
hours1AddrNoEqu1:
    INC     A
    MOV     hours1Addr, A
    LJMP    exit
hours0AddrNoEqu9:
    MOV     R6, A
    MOV     A, hours1Addr
    CJNE    A, #1, hours1AddrAlsoNoEqu1
    MOV     A, R6
    CJNE    A, #1, hoursEqu10
    MOV     hours0Addr, #0
    MOV     hours1Addr, #0
    LJMP    exit
hoursEqu10:
    INC     A
    MOV     hours0Addr, A
    LJMP    exit
hours1AddrAlsoNoEqu1:
    MOV     A, R6
    INC     A
    MOV     hours0Addr, A
    LJMP    exit
minutes1AddrNoEqu5:
    INC     A
    MOV     minutes1Addr, A
    LJMP    exit
minutes0AddrNoEqu9:
    INC     A
    MOV     minutes0Addr, A
    LJMP    exit
seconds1AddrNoEqu5:
    INC     A
    MOV     seconds1Addr, A   ; ç§’åä½+1
    LJMP    exit
seconds0AddrNoEqu9:           ; ç§’ä¸ªä½ä¸ç­‰äº9
    INC     A                 ; ç§’ä¸ªä½+1
    MOV     seconds0Addr, A   ; ç§’ä¸ªä½+
exit:
    POP     A
    POP     PSW
    RETI

timer1:
    PUSH    PSW
    PUSH    A
    MOV     TH1, #HIGH(STOPWATCHTICK)
    MOV     TL1, #LOW(STOPWATCHTICK)
    ;DEC     STOPWATCHTICKADDRESS 
    ;MOV     A, STOPWATCHTICKADDRESS
    ;JNZ     exitTimer1
    ;MOV     STOPWATCHTICKADDRESS, STOPWATCHTICK
    MOV     A, stopwatch0Addr
    CJNE    A, #9, stopwatch0AddrNotEqu9
    MOV     stopwatch0Addr, #0
    MOV     A, stopwatch1Addr
    CJNE    A, #9, stopwatch1AddrNotEqu9
    MOV     stopwatch1Addr, #0
    MOV     A, stopwatch2Addr
    CJNE    A, #9, stopwatch2AddrNotEqu9
    MOV     stopwatch2Addr, #0
    MOV     A, stopwatch3Addr
    CJNE    A, #9, stopwatch3AddrNotEqu9
    MOV     stopwatch3Addr, #0
    LJMP    exitTimer1
stopwatch0AddrNotEqu9:
    INC     A
    MOV     stopwatch0Addr, A
    LJMP    exitTimer1
stopwatch1AddrNotEqu9:
    INC     A
    MOV     stopwatch1Addr, A
    LJMP    exitTimer1
stopwatch2AddrNotEqu9:
    INC     A
    MOV     stopwatch2Addr, A
    LJMP    exitTimer1
stopwatch3AddrNotEqu9:
    INC     A
    MOV     stopwatch3Addr, A   
exitTimer1:    
    POP     PSW
    POP     A
    RETI

showSecondsAndMinutes:
      MOV   R2, #11101111B   ; æ•°ç ç®¡ä½é€‰ä½ï¼Œå…ˆæ˜¾ç¤º P2.4ï¼Œå†ä¾æ¬¡å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, seconds0Addr             ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºç§’ä¸ªä½
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      RL    A           ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   R2, A       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, seconds1Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºç§’åä½
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      RL    A           ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   R2, A       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, minutes0Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºåˆ†ä¸ªä½
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      RL    A           ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   R2, A       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, minutes1Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºåˆ†åä½
      MOV   R6, #1
      CALL  Delay
      MOV   P2, #0FFH
      MOV   R6, #1
      CALL  Delay
      RET

showMinutes:
      MOV   R2, #10111111B   ; æ•°ç ç®¡ä½é€‰ä½ï¼Œå…ˆæ˜¾ç¤º P2.4ï¼Œå†ä¾æ¬¡å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, minutes0Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºç§’ä¸ªä½
      MOV   R6, #4
      CALL  Delay

      MOV   A, R2       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      RL    A           ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   R2, A       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, minutes1Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºç§’åä½
      MOV   R6, #4
      CALL  Delay
      MOV   P2, #0FFH
      MOV   R6, #1
      CALL  Delay
      MOV   P2, #0FFH
      RET
      
showMinutesAtLow:
      MOV   R2, #11101111B   ; æ•°ç ç®¡ä½é€‰ä½ï¼Œå…ˆæ˜¾ç¤º P2.4ï¼Œå†ä¾æ¬¡å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, minutes0Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºç§’ä¸ªä½
      MOV   R6, #2
      CALL  Delay

      MOV   A, R2       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      RL    A           ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   R2, A       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, minutes1Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºç§’åä½
      MOV   R6, #2
      CALL  Delay
      MOV   P2, #0FFH
      MOV   R6, #1
      CALL  Delay
      MOV   P2, #0FFH
      RET      

showHours:
      MOV   R2, #10111111B   ; æ•°ç ç®¡ä½é€‰ä½ï¼Œå…ˆæ˜¾ç¤º P2.4ï¼Œå†ä¾æ¬¡å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, hours0Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºç§’ä¸ªä½
      MOV   R6, #2
      CALL  Delay

      MOV   A, R2       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      RL    A           ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   R2, A       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, hours1Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºç§’åä½
      MOV   R6, #2
      CALL  Delay
      MOV   P2, #0FFH
      MOV   R6, #1
      CALL  Delay
      MOV   P2, #0FFH
      RET  
      
showMinutesAndHours:
      MOV   R2, #11101111B
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, minutes0Addr              ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºç§’ä¸ªä½
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      RL    A           ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   R2, A       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, minutes1Addr    ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºç§’åä½
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      RL    A           ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   R2, A       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, hours0Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºåˆ†ä¸ªä½
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      RL    A           ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   R2, A       ; æ•°ç ç®¡ä½é€‰ä½å·¦ç§»
      MOV   P2, R2           ; æ•°ç ç®¡ä½é€‰
      MOV   A, hours1Addr  ; æ®µé€‰åç§»é‡
      MOV   DPTR, #LEDMAP    ; æ®µé€‰åç§»é‡
      MOVC  A, @A+DPTR       ; æ®µé€‰åç§»é‡
      MOV   P0, A            ; æ˜¾ç¤ºåˆ†åä½
      MOV   R6, #1
      CALL  Delay
      MOV   P2, #0FFH
      RET

showStopwatch:
      MOV   R6, #10
ro:
      MOV   A, stopwatch0Addr              ; ??€?????
      MOV   DPTR, #LEDMAP    ; ??€?????
      MOVC  A, @A+DPTR       ; ??€?????
      MOV   stopwatch0Addr1, A            ; ????????
      MOV   A, stopwatch1Addr; ??€?????
      MOV   DPTR, #LEDMAP ; ??€?????
      MOVC  A, @A+DPTR       ; ??€?????
      MOV   stopwatch1Addr1, A            ; ????????
      MOV   A, stopwatch2Addr ; ??€?????
      MOV   DPTR, #LEDWITHDOTMAP     ; ??€?????
      MOVC  A, @A+DPTR       ; ??€?????
      MOV   stopwatch2Addr1,A            ; ????????
      MOV   A, stopwatch3Addr ; ??€?????
      MOV   DPTR, #LEDMAP    ; ??€?????
      MOVC  A, @A+DPTR       ; ??€?????
      MOV   stopwatch3Addr1,A          ; ????????
      
      djnz  r6,ro
      nop
      nop
      nop
     ; MOV   R2, #11101111B
      MOV   P0,#0FFH
      MOV   P2,#0FH
      MOV   P0,stopwatch0Addr1
      MOV   P2, #0EFH           ; ????'???
      MOV   R6, #1
      CALL  Delay
      MOV   P0,#0FFH
      MOV   P2,#0FH

      MOV   P0,stopwatch1Addr1            ; ????????
      MOV   P2,#0DFH          ; ????'???
      MOV   R6, #1
      CALL  Delay
      MOV   P0,#0FFH
      MOV   P2,#0FH
      MOV   P0,stopwatch2Addr1            ; ????????
      MOV   P2, #0BFH           ; ????'???
      MOV   R6, #1
      CALL  Delay
      MOV   P0,#0FFH
      MOV   P2,#0FH
      MOV   P0,stopwatch3Addr1           ; ????????
      MOV   P2,#7FH
      MOV   R6, #1
      CALL  Delay
      MOV   P0,#0FFH
      MOV   P2,#0FH
      RET      

MAIN:
      NOP
      ; å¼€å§‹åˆå§‹åŒ–å®šæ—¶å™¨0
      MOV   TMOD, #12h      ; å®šæ—¶å™¨0ï¼Œå·¥ä½œæ¨¡å¼2
      MOV   TH0, #T0INIT
      MOV   TL0, #T0INIT
      MOV   TH1, #HIGH(STOPWATCHTICK)
      MOV   TL1, #LOW(STOPWATCHTICK)
      SETB  EA      ; ×ÜÖĞ¶ÏÊ¹ÄÜ
      SETB  ET0     ; Ê±ÖÓÖĞ¶ÏÊ¹ÄÜ
      CLR   ET1     ; Ãë±íÖĞ¶ÏÊ¹ÄÜ
      SETB  TR0     ; ¿ªÆôÊ±ÖÓÖĞ¶Ï
      CLR   TR1     ; ¹Ø±ÕÃë±íÖĞ¶Ï
      MOV   TICKADDRESS, #HIGH(TICK)    ; å®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°é«˜å…«ä½
      MOV   TICKADDRESS+1, #LOW(TICK)  ; å®šæ—¶å™¨ä¸­æ–­æ¬¡æ•°ä½å…«ä½
      ;MOV   STOPWATCHTICKADDRESS, #HIGH(STOPWATCHTICK)
      ;MOV   STOPWATCHTICKADDRESS+1, #LOW(STOPWATCHTICK)
      ; ç»“æŸåˆå§‹åŒ–å®šæ—¶å™¨0
      MOV   P0, #0FFH       ; ÊıÂë¹Ü¶ÎÎ»£¬µÍµçÆ½ÓĞĞ§
      MOV   P1, #00H        ; LED
      MOV   P2, #0F0H       ; æ•°ç ç®¡ä½é€‰ä½ P2.4~P2.7
      MOV   DPTR, #LEDMAP
      MOV   A, #0
      ;MOV   R1, #3           ; 3ä½æ•°ç ç®¡
      MOV   seconds0Addr, #0
      MOV   seconds1Addr, #0
      MOV   minutes0Addr, #0
      MOV   minutes1Addr, #0
      MOV   hours0Addr, #0
      MOV   hours1Addr, #0
      MOV   stopwatch0Addr, #0
      MOV   stopwatch1Addr, #0
      MOV   stopwatch2Addr, #0
      MOV   stopwatch3Addr, #0
      MOV   CLOCKVALUE, #0
      SETB  FLAG
      SETB  CLOCKFLAG
loop:
      ;CLR   P2.0        ; ·äÃùÆ÷
      JNB   FLAG, callShowMinutesAndHours
      LCALL showSecondsAndMinutes    ; ÏÔÊ¾·ÖÃë
      LJMP  testKeyBoard
callShowMinutesAndHours:
      LCALL showMinutesAndHours        ; ÏÔÊ¾Ê±·Ö
      MOV   R1, hours0Addr      
testKeyBoard:
      JNB   KEYBOARD0, keyboard0IsShake
      JNB   KEYBOARD1, keyboard1IsShake
      JNB   KEYBOARD2, keyboard2IsShake
      JNB   KEYBOARD3, keyboard3IsShake
      LJMP  loop
keyboard0IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD0, keyboard0IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  loop           ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard1IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard1IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  loop           ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard2IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  loop           ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard3IsShake:
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD3, keyboard3IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  loop           ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard0IsNotShake:
      CPL   LED0
      LJMP  keyboard0IsPressing
keyboard1IsNotShake:
      CPL   LED1
      LJMP  keyboard1IsPressing
keyboard2IsNotShake:
      CPL   LED2
      LJMP  keyboard2IsPressing
keyboard3IsNotShake:
      CPL   LED3
      LJMP  keyboard3IsPressing
keyboard0IsPressing:
      JNB   KEYBOARD0, keyboard0IsPressing
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD0, keyboard0IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD 0 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      CPL   LED0
      CPL   FLAG
      ; [TODO] ½áÊø KEYBOARD 0 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      LJMP  loop
keyboard1IsPressing:
      JNB   KEYBOARD1, keyboard1IsPressing
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard1IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD 1 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      CPL   LED1
      
      ; [TODO] ½áÊø KEYBOARD 1 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      LJMP  loop
keyboard2IsPressing:
      JNB   KEYBOARD2, keyboard2IsPressing
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD 2 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      CPL   LED2
      
      CLR   TR0         ; Í£Ö¹¶¨Ê±/¼ÆÊıÆ÷0
testKeyboard2:
      MOV   R1, #180
showingMinutesAndHours:      
      ;LCALL showSecondsAndMinutes
      LCALL showMinutesAndHours
      JNB   KEYBOARD0, keyboard2_keyboard0IsShake
      JNB   KEYBOARD1, keyboard2_keyboard1IsShake
      JNB   KEYBOARD2, keyboard2_keyboard2IsShake
      DJNZ  R1, showingMinutesAndHours
      MOV   R1, #180  
showingMinutesAtLow:
      ;LCALL showMinutes
      LCALL showMinutesAtLow
      JNB   KEYBOARD0, keyboard2_keyboard0IsShake
      JNB   KEYBOARD1, keyboard2_keyboard1IsShake
      JNB   KEYBOARD2, keyboard2_keyboard2IsShake
      DJNZ  R1, showingMinutesAtLow
      LJMP  testKeyboard2
keyboard2_keyboard0IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD0, keyboard2_keyboard0IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard2                  ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard2_keyboard1IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard2_keyboard1IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard2                  ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard2_keyboard2IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2_keyboard2IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard2
keyboard2_keyboard0IsNotShake:
      CPL   LED0
      LJMP  keyboard2_keyboard0IsPressing
keyboard2_keyboard1IsNotShake:
      CPL   LED1
      LJMP  keyboard2_keyboard1IsPressing
keyboard2_keyboard2IsNotShake:
      CPL   LED2
      LJMP  keyboard2_keyboard2IsPressing
keyboard2_keyboard0IsPressing:
      JNB   KEYBOARD0, keyboard2_keyboard0IsPressing
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD0, keyboard2_keyboard0IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD2_KEYBOARD0 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      MOV     A, hours0Addr
      CJNE    A, #9, adjustHoursInc_hours0AddrNoEqu9
      MOV     hours0Addr, #0
      INC     hours1Addr
      LJMP    testKeyboard2
adjustHoursInc_hours0AddrNoEqu9:
      MOV     R6, A
      MOV     A, hours1Addr
      CJNE    A, #1, adjustHoursInc_hours1AlsoNoEqu1
      MOV     A, R6
      CJNE    A, #1, adjustHoursInc_hoursEqu10
      MOV     hours0Addr, #0
      MOV     hours1Addr, #0
      LJMP    testKeyboard2
adjustHoursInc_hoursEqu10:
      INC     hours0Addr
      LJMP    testKeyboard2
adjustHoursInc_hours1AlsoNoEqu1:
      MOV     A, R6
      INC     A
      MOV     hours0Addr, A
      LJMP    testKeyboard2
      
keyboard2_keyboard1IsPressing:
      JNB   KEYBOARD1, keyboard2_keyboard1IsPressing
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard2_keyboard1IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD2_KEYBOARD1 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      MOV     A, hours0Addr
      CJNE    A, #0, adjustHoursDesc_hoursAddrNoEqu0
      MOV     A, hours1Addr
      CJNE    A, #0, adjustHoursDesc_hoursEqu10
      MOV     hours0Addr, #1
      MOV     hours1Addr, #1
      LJMP    testKeyboard2
adjustHoursDesc_hoursEqu10:
      MOV     hours0Addr, #9
      MOV     hours1Addr, #0
      LJMP    testKeyboard2       
adjustHoursDesc_hoursAddrNoEqu0:
      DEC     hours0Addr
      LJMP    testKeyboard2      
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
keyboard2_keyboard2IsPressing:
      JNB   KEYBOARD2, keyboard2_keyboard2IsPressing
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2_keyboard2IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD2_KEYBOARD2 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
testKeyboard2_2:      
      CPL   LED2
      MOV   R1, #180
keyboard2_2_showingMinutesAndHours:      
      LCALL showMinutesAndHours
      JNB   KEYBOARD0, keyboard2_2_0IsShake
      JNB   KEYBOARD1, keyboard2_2_1IsShake
      JNB   KEYBOARD2, keyboard2_2_2IsShake
      DJNZ  R1, keyboard2_2_showingMinutesAndHours
      MOV   R1, #180  
keyboard2_2_showingHours:
      LCALL showHours
      JNB   KEYBOARD0, keyboard2_2_0IsShake
      JNB   KEYBOARD1, keyboard2_2_1IsShake
      JNB   KEYBOARD2, keyboard2_2_2IsShake
      DJNZ  R1, keyboard2_2_showingHours
      LJMP  testKeyboard2_2
keyboard2_2_0IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD0, keyboard2_2_0IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard2_2           ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard2_2_1IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard2_2_1IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard2_2            ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard2_2_2IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2_2_2IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard2_2
keyboard2_2_0IsNotShake:
      CPL   LED0
      LJMP  keyboard2_2_0IsPressing
keyboard2_2_1IsNotShake:
      CPL   LED1
      LJMP  keyboard2_2_1IsPressing
keyboard2_2_2IsNotShake:
      CPL   LED2
      LJMP  keyboard2_2_2IsPressing
keyboard2_2_0IsPressing:
      JNB   KEYBOARD0, keyboard2_2_0IsPressing
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD0, keyboard2_2_0IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD2_2_0 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷       
      MOV   A, minutes0Addr
      CJNE  A, #9, adjustMinutesInc_minutes0AddrNoEqu9
      MOV   minutes0Addr, #0
      INC   minutes1Addr
      MOV   A, minutes1Addr
      CJNE  A, #6, testKeyboard2_2
      MOV   minutes1Addr, #0
      LJMP  testKeyboard2_2
adjustMinutesInc_minutes0AddrNoEqu9:
      INC   minutes0Addr
      ; [TODO] ½áÊø KEYBOARD2_2_0 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      LJMP  testKeyboard2_2
keyboard2_2_1IsPressing:
      JNB   KEYBOARD1, keyboard2_2_1IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD1, keyboard2_2_1IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD2_2_1 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      CPL   LED0    
      MOV   A, minutes0Addr
      CJNE  A, #0, adjustMinutesDecs_minutes0AddrNoEqu0
      MOV   minutes0Addr, #9
      MOV   A, minutes1Addr
      CJNE  A, #0, adjustMinutesDecs_minutes1AddrNoEqu0
      MOV   minutes1Addr, #5
      LJMP  testKeyboard2_2
adjustMinutesDecs_minutes1AddrNoEqu0:
      DEC   minutes1Addr
      LJMP  testKeyboard2_2
adjustMinutesDecs_minutes0AddrNoEqu0:
      DEC   minutes0Addr      
      ;SETB  TR0
      ; [TODO] ½áÊø KEYBOARD2_2_1  ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      LJMP  testKeyboard2_2
keyboard2_2_2IsPressing:
      JNB   KEYBOARD2, keyboard2_2_2IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD2, keyboard2_2_2IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD2_2_2 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷       


testKeyboard2_2_2:      
      CPL   LED2
      MOV   R1, #180
keyboard2_2_2_showingSecondesAndMinutes:      
      LCALL showSecondsAndMinutes
      JNB   KEYBOARD0, keyboard2_2_2_0IsShake
      JNB   KEYBOARD1, keyboard2_2_2_1IsShake
      JNB   KEYBOARD2, keyboard2_2_2_2IsShake
      DJNZ  R1, keyboard2_2_2_showingSecondesAndMinutes
      MOV   R1, #180  
keyboard2_2_2_showingMinutes:
      LCALL showMinutes
      JNB   KEYBOARD0, keyboard2_2_2_0IsShake
      JNB   KEYBOARD1, keyboard2_2_2_1IsShake
      JNB   KEYBOARD2, keyboard2_2_2_2IsShake
      DJNZ  R1, keyboard2_2_2_showingMinutes
      LJMP  testKeyboard2_2_2
keyboard2_2_2_0IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD0, keyboard2_2_2_0IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard2_2_2                    ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard2_2_2_1IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard2_2_2_1IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard2_2_2                    ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard2_2_2_2IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2_2_2_2IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard2_2_2
keyboard2_2_2_0IsNotShake :
      CPL   LED0
      LJMP  keyboard2_2_2_0IsPressing
keyboard2_2_2_1IsNotShake :
      CPL   LED1
      LJMP  keyboard2_2_2_1IsPressing
keyboard2_2_2_2IsNotShake :
      CPL   LED2
      LJMP  keyboard2_2_2_2IsPressing
keyboard2_2_2_0IsPressing:
      JNB   KEYBOARD0, keyboard2_2_2_0IsPressing
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD0, keyboard2_2_2_0IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD2_2_2_0 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷       
      CPL   LED0
      MOV     A, seconds0Addr
      CJNE    A, #9, adjustSecondsInc_seconds0AddrNoEqu9
      MOV     seconds0Addr, #0  ; ç§’ä¸ªä½ç­‰äº9ï¼Œé‡æ–°èµ‹å€¼ä¸º0
      MOV     A, seconds1Addr
      CJNE    A, #5, adjustSecondsInc_seconds1AddrNoEqu5
      MOV     seconds1Addr, #0  ; ç§’åä½=5ï¼Œé‡æ–°ç½®0
      MOV     A, minutes0Addr
      CJNE    A, #9, adjustSecondsInc_minutes0AddrNoEqu9
      MOV     minutes0Addr, #0
      MOV     A, minutes1Addr
      CJNE    A, #5, adjustSecondsInc_minutes1AddrNoEqu5
      MOV     minutes1Addr, #0
      MOV     A, hours0Addr
      CJNE    A, #9, adjustSecondsInc_hours0AddrNoEqu9
      MOV     hours0Addr, #0
      MOV     A, hours1Addr
      CJNE    A, #1, adjustSecondsInc_hours1AddrNoEqu1
      MOV     hours1Addr, #0
      LJMP    adjustSecondsInc_exit
adjustSecondsInc_hours1AddrNoEqu1:
      INC     A
      MOV     hours1Addr, A
      LJMP    adjustSecondsInc_exit
adjustSecondsInc_hours0AddrNoEqu9:
      MOV     R6, A
      MOV     A, hours1Addr
      CJNE    A, #1, adjustSecondsInc_hours1AddrAlsoNoEqu1
      MOV     A, R6
      CJNE    A, #1, adjustSecondsInc_hoursEqu10
      MOV     hours0Addr, #0
      MOV     hours1Addr, #0
      LJMP    adjustSecondsInc_exit
adjustSecondsInc_hoursEqu10:
      INC     A
      MOV     hours0Addr, A
      LJMP    adjustSecondsInc_exit
adjustSecondsInc_hours1AddrAlsoNoEqu1:
      MOV     A, R6
      INC     A
      MOV     hours0Addr, A
      LJMP    adjustSecondsInc_exit
adjustSecondsInc_minutes1AddrNoEqu5:
      INC     A
      MOV     minutes1Addr, A
      LJMP    adjustSecondsInc_exit
adjustSecondsInc_minutes0AddrNoEqu9:
      INC     A
      MOV     minutes0Addr, A
      LJMP    adjustSecondsInc_exit
adjustSecondsInc_seconds1AddrNoEqu5:
      INC     A
      MOV     seconds1Addr, A   ; ç§’åä½+1
      AJMP    adjustSecondsInc_exit
adjustSecondsInc_seconds0AddrNoEqu9:           ; ç§’ä¸ªä½ä¸ç­‰äº9
      INC     A                 ; ç§’ä¸ªä½+1
      MOV     seconds0Addr, A   ; ç§’ä¸ªä½+1
adjustSecondsInc_exit:
      ; [TODO] ½áÊø KEYBOARD2_2_2_0 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      LJMP  testKeyboard2_2_2
keyboard2_2_2_1IsPressing:
      JNB   KEYBOARD1, keyboard2_2_2_1IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD1, keyboard2_2_2_1IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD2_2_2_1 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      CPL     LED1
      MOV     A, seconds0Addr
      CJNE    A, #0, adjustSecondsDesc_seconds0AddrNoEqu0
      MOV     seconds0Addr, #9  ; ç§’ä¸ªä½ç­‰äº9ï¼Œé‡æ–°èµ‹å€¼ä¸º0
      MOV     A, seconds1Addr
      CJNE    A, #0, adjustSecondsDesc_seconds1AddrNoEqu0
      MOV     seconds1Addr, #5  ; ç§’åä½=5ï¼Œé‡æ–°ç½®0
      MOV     A, minutes0Addr
      CJNE    A, #0, adjustSecondsDesc_minutes0AddrNoEqu0
      MOV     minutes0Addr, #9
      MOV     A, minutes1Addr
      CJNE    A, #0, adjustSecondsDesc_minutes1AddrNoEqu0
      MOV     minutes1Addr, #5
      MOV     A, hours0Addr
      CJNE    A, #0, adjustSecondsDesc_hours0AddrNoEqu0
      ;MOV     hours0Addr, #0
      MOV     A, hours1Addr
      CJNE    A, #0, adjustSecondsDesc_hours1AddrNoEqu0
      MOV     hours0Addr, #1
      MOV     hours1Addr, #1
      LJMP    adjustSecondsDesc_exit
adjustSecondsDesc_hours1AddrNoEqu0:
      DEC     A
      MOV     hours1Addr, A
      MOV     hours0Addr, #9
      LJMP    adjustSecondsDesc_exit
adjustSecondsDesc_hours0AddrNoEqu0:
      DEC     A
      MOV     hours0Addr, A
      LJMP    adjustSecondsDesc_exit
adjustSecondsDesc_minutes1AddrNoEqu0:
      DEC     A
      MOV     minutes1Addr, A
      LJMP    adjustSecondsDesc_exit
adjustSecondsDesc_minutes0AddrNoEqu0:
      DEC     A
      MOV     minutes0Addr, A
      LJMP    adjustSecondsDesc_exit
adjustSecondsDesc_seconds1AddrNoEqu0:
      DEC     A
      MOV     seconds1Addr, A   ; ç§’åä½+1
      AJMP    adjustSecondsDesc_exit
adjustSecondsDesc_seconds0AddrNoEqu0:           ; ç§’ä¸ªä½ä¸ç­‰äº9
      DEC     A                 ; ç§’ä¸ªä½+1
      MOV     seconds0Addr, A   ; ç§’ä¸ªä½+1
adjustSecondsDesc_exit:      
      ; [TODO] ½áÊø KEYBOARD2_2_2_1  ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      LJMP  testKeyboard2_2_2
keyboard2_2_2_2IsPressing:
      JNB   KEYBOARD2, keyboard2_2_2_2IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD2, keyboard2_2_2_2IsPressing
            ; [TODO] ¿ªÊ¼ KEYBOARD2_2_2_2 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
            SETB  TR0  
            LJMP  loop
      
                ;SETB  TR0
             ; [TODO] ½áÊø KEYBOARD2_2_2_2 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      ;SETB  TR0
      ; [TODO] ½áÊø KEYBOARD2_2_2 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      
                  
keyboard3IsPressing:
      JNB   KEYBOARD3, keyboard3IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD3, keyboard3IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD 3 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      
testKeyboard3:    
      LCALL showStopwatch
      JNB   KEYBOARD0, keyboard3_keyboard0IsShake
      JNB   KEYBOARD1, keyboard3_keyboard1IsShake
      JNB   KEYBOARD2, keyboard3_keyboard2IsShake
      LJMP  testKeyboard3
keyboard3_keyboard0IsShake:
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD0, keyboard3_keyboard0IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard3                  ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard3_keyboard1IsShake:
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD1, keyboard3_keyboard1IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard3                  ; ÊÇ¶¶¶¯£¬·µ»Ø
keyboard3_keyboard2IsShake:
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD2, keyboard3_keyboard2IsNotShake ; ²»ÊÇ¶¶¶¯
      LJMP  testKeyboard3
keyboard3_keyboard0IsNotShake:
      CPL   LED0
      LJMP  keyboard3_keyboard0IsPressing
keyboard3_keyboard1IsNotShake:
      CPL   LED1
      LJMP  keyboard3_keyboard1IsPressing
keyboard3_keyboard2IsNotShake:
      CPL   LED2
      LJMP  keyboard3_keyboard2IsPressing
keyboard3_keyboard0IsPressing:
      JNB   KEYBOARD0, keyboard3_keyboard0IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD0, keyboard3_keyboard0IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD3_KEYBOARD0 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      SETB  ET1
      SETB  TR1
      ; [TODO] ½áÊø KEYBOARD3_KEYBOARD0 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      LJMP  testKeyboard3
keyboard3_keyboard1IsPressing:
      JNB   KEYBOARD1, keyboard3_keyboard1IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD1, keyboard3_keyboard1IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD2_KEYBOARD1 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      CLR   ET1
      CLR   TR1
      ; [TODO] ½áÊø KEYBOARD3_KEYBOARD1 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      LJMP  testKeyboard3
keyboard3_keyboard2IsPressing:
      JNB   KEYBOARD2, keyboard3_keyboard2IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD2, keyboard3_keyboard2IsPressing
      ; [TODO] ¿ªÊ¼ KEYBOARD3_KEYBOARD2 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      CPL   LED2
      CLR   ET1
      CLR   TR1
      MOV   stopwatch0Addr, #0    
      MOV   stopwatch1Addr, #0
      MOV   stopwatch2Addr, #0
      MOV   stopwatch3Addr, #0
      ; [TODO] ½áÊø KEYBOARD3_KEYBOARD2 ÊÍ·ÅĞèÒª×öµÄ¶¯×÷
      LJMP  loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
      
      END
