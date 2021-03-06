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
LEDMAP:              ; ��������ܶ���
    DB  0C0H, 0F9H, 0A4H, 0B0H, 99H, 92H, 82H, 0F8H, 80H, 90H
LEDWITHDOTMAP:              ; ��������ܶ���
    DB  40H, 79H, 24H, 30H, 19H, 12H, 02H, 78H, 00H, 10H

Delay: ;
    MOV   R7, #0
delayLoop:
    DJNZ  R7, delayLoop
    DJNZ  R6, delayLoop
    RET

    ORG 300h
timer0: ; ��ʱ������0�ӳ���
    PUSH    PSW
    PUSH    A

    MOV     A, TICKADDRESS+1  ; 定时器中断次数低八位
    JNZ     tickLowNoEquZero      ; A（定时器中断次数低八位）不等于0
    DEC     TICKADDRESS       ; 定时器中断次数高八位-1
tickLowNoEquZero:
    DEC     TICKADDRESS+1       ; 定时器中断次数低八位-1
    MOV     A, TICKADDRESS      ; 判断定时器中断次数高、低八位是否同时为0
    ORL     A, TICKADDRESS+1    ; 判断定时器中断次数高、低八位是否同时为0
    JNZ     exit   ; 定时器中断次数高八位不为0
    MOV     TICKADDRESS, #HIGH(TICK)  ; 重新设置定时器中断次数高八位
    MOV     TICKADDRESS+1, #LOW(TICK) ; 重新设置定时器中断次数低八位
    ; [TODO] 添加 1s 后要做的动作
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOV     A, CLOCKVALUE
    ;JZ      clockvalueIsZero
    ; [TODO] start ������ֵ��Ϊ0 
    ; [TODO] end ������ֵ��Ϊ0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
clockvalueIsZero:  
    MOV     A, seconds0Addr
    CJNE    A, #9, seconds0AddrNoEqu9
    MOV     seconds0Addr, #0  ; 秒个位等于9，重新赋值为0
    MOV     A, seconds1Addr
    CJNE    A, #5, seconds1AddrNoEqu5
    MOV     seconds1Addr, #0  ; 秒十位=5，重新置0
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
    MOV     seconds1Addr, A   ; 秒十位+1
    LJMP    exit
seconds0AddrNoEqu9:           ; 秒个位不等于9
    INC     A                 ; 秒个位+1
    MOV     seconds0Addr, A   ; 秒个位+
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
      MOV   R2, #11101111B   ; 数码管位选位，先显示 P2.4，再依次左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, seconds0Addr             ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示秒个位
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; 数码管位选位左移
      RL    A           ; 数码管位选位左移
      MOV   R2, A       ; 数码管位选位左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, seconds1Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示秒十位
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; 数码管位选位左移
      RL    A           ; 数码管位选位左移
      MOV   R2, A       ; 数码管位选位左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, minutes0Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示分个位
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; 数码管位选位左移
      RL    A           ; 数码管位选位左移
      MOV   R2, A       ; 数码管位选位左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, minutes1Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示分十位
      MOV   R6, #1
      CALL  Delay
      MOV   P2, #0FFH
      MOV   R6, #1
      CALL  Delay
      RET

showMinutes:
      MOV   R2, #10111111B   ; 数码管位选位，先显示 P2.4，再依次左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, minutes0Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示秒个位
      MOV   R6, #4
      CALL  Delay

      MOV   A, R2       ; 数码管位选位左移
      RL    A           ; 数码管位选位左移
      MOV   R2, A       ; 数码管位选位左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, minutes1Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示秒十位
      MOV   R6, #4
      CALL  Delay
      MOV   P2, #0FFH
      MOV   R6, #1
      CALL  Delay
      MOV   P2, #0FFH
      RET
      
showMinutesAtLow:
      MOV   R2, #11101111B   ; 数码管位选位，先显示 P2.4，再依次左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, minutes0Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示秒个位
      MOV   R6, #2
      CALL  Delay

      MOV   A, R2       ; 数码管位选位左移
      RL    A           ; 数码管位选位左移
      MOV   R2, A       ; 数码管位选位左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, minutes1Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示秒十位
      MOV   R6, #2
      CALL  Delay
      MOV   P2, #0FFH
      MOV   R6, #1
      CALL  Delay
      MOV   P2, #0FFH
      RET      

showHours:
      MOV   R2, #10111111B   ; 数码管位选位，先显示 P2.4，再依次左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, hours0Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示秒个位
      MOV   R6, #2
      CALL  Delay

      MOV   A, R2       ; 数码管位选位左移
      RL    A           ; 数码管位选位左移
      MOV   R2, A       ; 数码管位选位左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, hours1Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示秒十位
      MOV   R6, #2
      CALL  Delay
      MOV   P2, #0FFH
      MOV   R6, #1
      CALL  Delay
      MOV   P2, #0FFH
      RET  
      
showMinutesAndHours:
      MOV   R2, #11101111B
      MOV   P2, R2           ; 数码管位选
      MOV   A, minutes0Addr              ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示秒个位
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; 数码管位选位左移
      RL    A           ; 数码管位选位左移
      MOV   R2, A       ; 数码管位选位左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, minutes1Addr    ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示秒十位
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; 数码管位选位左移
      RL    A           ; 数码管位选位左移
      MOV   R2, A       ; 数码管位选位左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, hours0Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示分个位
      MOV   R6, #1
      CALL  Delay

      MOV   A, R2       ; 数码管位选位左移
      RL    A           ; 数码管位选位左移
      MOV   R2, A       ; 数码管位选位左移
      MOV   P2, R2           ; 数码管位选
      MOV   A, hours1Addr  ; 段选偏移量
      MOV   DPTR, #LEDMAP    ; 段选偏移量
      MOVC  A, @A+DPTR       ; 段选偏移量
      MOV   P0, A            ; 显示分十位
      MOV   R6, #1
      CALL  Delay
      MOV   P2, #0FFH
      RET

showStopwatch:
      MOV   R6, #10
ro:
      MOV   A, stopwatch0Addr              ; ??�?????
      MOV   DPTR, #LEDMAP    ; ??�?????
      MOVC  A, @A+DPTR       ; ??�?????
      MOV   stopwatch0Addr1, A            ; ????????
      MOV   A, stopwatch1Addr; ??�?????
      MOV   DPTR, #LEDMAP ; ??�?????
      MOVC  A, @A+DPTR       ; ??�?????
      MOV   stopwatch1Addr1, A            ; ????????
      MOV   A, stopwatch2Addr ; ??�?????
      MOV   DPTR, #LEDWITHDOTMAP     ; ??�?????
      MOVC  A, @A+DPTR       ; ??�?????
      MOV   stopwatch2Addr1,A            ; ????????
      MOV   A, stopwatch3Addr ; ??�?????
      MOV   DPTR, #LEDMAP    ; ??�?????
      MOVC  A, @A+DPTR       ; ??�?????
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
      ; 开始初始化定时器0
      MOV   TMOD, #12h      ; 定时器0，工作模式2
      MOV   TH0, #T0INIT
      MOV   TL0, #T0INIT
      MOV   TH1, #HIGH(STOPWATCHTICK)
      MOV   TL1, #LOW(STOPWATCHTICK)
      SETB  EA      ; ���ж�ʹ��
      SETB  ET0     ; ʱ���ж�ʹ��
      CLR   ET1     ; ����ж�ʹ��
      SETB  TR0     ; ����ʱ���ж�
      CLR   TR1     ; �ر�����ж�
      MOV   TICKADDRESS, #HIGH(TICK)    ; 定时器中断次数高八位
      MOV   TICKADDRESS+1, #LOW(TICK)  ; 定时器中断次数低八位
      ;MOV   STOPWATCHTICKADDRESS, #HIGH(STOPWATCHTICK)
      ;MOV   STOPWATCHTICKADDRESS+1, #LOW(STOPWATCHTICK)
      ; 结束初始化定时器0
      MOV   P0, #0FFH       ; ����ܶ�λ���͵�ƽ��Ч
      MOV   P1, #00H        ; LED
      MOV   P2, #0F0H       ; 数码管位选位 P2.4~P2.7
      MOV   DPTR, #LEDMAP
      MOV   A, #0
      ;MOV   R1, #3           ; 3位数码管
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
      ;CLR   P2.0        ; ������
      JNB   FLAG, callShowMinutesAndHours
      LCALL showSecondsAndMinutes    ; ��ʾ����
      LJMP  testKeyBoard
callShowMinutesAndHours:
      LCALL showMinutesAndHours        ; ��ʾʱ��
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
      JNB   KEYBOARD0, keyboard0IsNotShake ; ���Ƕ���
      LJMP  loop           ; �Ƕ���������
keyboard1IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard1IsNotShake ; ���Ƕ���
      LJMP  loop           ; �Ƕ���������
keyboard2IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2IsNotShake ; ���Ƕ���
      LJMP  loop           ; �Ƕ���������
keyboard3IsShake:
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD3, keyboard3IsNotShake ; ���Ƕ���
      LJMP  loop           ; �Ƕ���������
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
      ; [TODO] ��ʼ KEYBOARD 0 �ͷ���Ҫ���Ķ���
      CPL   LED0
      CPL   FLAG
      ; [TODO] ���� KEYBOARD 0 �ͷ���Ҫ���Ķ���
      LJMP  loop
keyboard1IsPressing:
      JNB   KEYBOARD1, keyboard1IsPressing
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard1IsPressing
      ; [TODO] ��ʼ KEYBOARD 1 �ͷ���Ҫ���Ķ���
      CPL   LED1
      
      ; [TODO] ���� KEYBOARD 1 �ͷ���Ҫ���Ķ���
      LJMP  loop
keyboard2IsPressing:
      JNB   KEYBOARD2, keyboard2IsPressing
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2IsPressing
      ; [TODO] ��ʼ KEYBOARD 2 �ͷ���Ҫ���Ķ���
      CPL   LED2
      
      CLR   TR0         ; ֹͣ��ʱ/������0
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
      JNB   KEYBOARD0, keyboard2_keyboard0IsNotShake ; ���Ƕ���
      LJMP  testKeyboard2                  ; �Ƕ���������
keyboard2_keyboard1IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard2_keyboard1IsNotShake ; ���Ƕ���
      LJMP  testKeyboard2                  ; �Ƕ���������
keyboard2_keyboard2IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2_keyboard2IsNotShake ; ���Ƕ���
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
      ; [TODO] ��ʼ KEYBOARD2_KEYBOARD0 �ͷ���Ҫ���Ķ���
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
      ; [TODO] ��ʼ KEYBOARD2_KEYBOARD1 �ͷ���Ҫ���Ķ���
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
      ; [TODO] ��ʼ KEYBOARD2_KEYBOARD2 �ͷ���Ҫ���Ķ���
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
      JNB   KEYBOARD0, keyboard2_2_0IsNotShake ; ���Ƕ���
      LJMP  testKeyboard2_2           ; �Ƕ���������
keyboard2_2_1IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard2_2_1IsNotShake ; ���Ƕ���
      LJMP  testKeyboard2_2            ; �Ƕ���������
keyboard2_2_2IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2_2_2IsNotShake ; ���Ƕ���
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
      ; [TODO] ��ʼ KEYBOARD2_2_0 �ͷ���Ҫ���Ķ���       
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
      ; [TODO] ���� KEYBOARD2_2_0 �ͷ���Ҫ���Ķ���
      LJMP  testKeyboard2_2
keyboard2_2_1IsPressing:
      JNB   KEYBOARD1, keyboard2_2_1IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD1, keyboard2_2_1IsPressing
      ; [TODO] ��ʼ KEYBOARD2_2_1 �ͷ���Ҫ���Ķ���
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
      ; [TODO] ���� KEYBOARD2_2_1  �ͷ���Ҫ���Ķ���
      LJMP  testKeyboard2_2
keyboard2_2_2IsPressing:
      JNB   KEYBOARD2, keyboard2_2_2IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD2, keyboard2_2_2IsPressing
      ; [TODO] ��ʼ KEYBOARD2_2_2 �ͷ���Ҫ���Ķ���       


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
      JNB   KEYBOARD0, keyboard2_2_2_0IsNotShake ; ���Ƕ���
      LJMP  testKeyboard2_2_2                    ; �Ƕ���������
keyboard2_2_2_1IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD1, keyboard2_2_2_1IsNotShake ; ���Ƕ���
      LJMP  testKeyboard2_2_2                    ; �Ƕ���������
keyboard2_2_2_2IsShake:
      MOV   R6, #0FH
      ACALL Delay
      JNB   KEYBOARD2, keyboard2_2_2_2IsNotShake ; ���Ƕ���
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
      ; [TODO] ��ʼ KEYBOARD2_2_2_0 �ͷ���Ҫ���Ķ���       
      CPL   LED0
      MOV     A, seconds0Addr
      CJNE    A, #9, adjustSecondsInc_seconds0AddrNoEqu9
      MOV     seconds0Addr, #0  ; 秒个位等于9，重新赋值为0
      MOV     A, seconds1Addr
      CJNE    A, #5, adjustSecondsInc_seconds1AddrNoEqu5
      MOV     seconds1Addr, #0  ; 秒十位=5，重新置0
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
      MOV     seconds1Addr, A   ; 秒十位+1
      AJMP    adjustSecondsInc_exit
adjustSecondsInc_seconds0AddrNoEqu9:           ; 秒个位不等于9
      INC     A                 ; 秒个位+1
      MOV     seconds0Addr, A   ; 秒个位+1
adjustSecondsInc_exit:
      ; [TODO] ���� KEYBOARD2_2_2_0 �ͷ���Ҫ���Ķ���
      LJMP  testKeyboard2_2_2
keyboard2_2_2_1IsPressing:
      JNB   KEYBOARD1, keyboard2_2_2_1IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD1, keyboard2_2_2_1IsPressing
      ; [TODO] ��ʼ KEYBOARD2_2_2_1 �ͷ���Ҫ���Ķ���
      CPL     LED1
      MOV     A, seconds0Addr
      CJNE    A, #0, adjustSecondsDesc_seconds0AddrNoEqu0
      MOV     seconds0Addr, #9  ; 秒个位等于9，重新赋值为0
      MOV     A, seconds1Addr
      CJNE    A, #0, adjustSecondsDesc_seconds1AddrNoEqu0
      MOV     seconds1Addr, #5  ; 秒十位=5，重新置0
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
      MOV     seconds1Addr, A   ; 秒十位+1
      AJMP    adjustSecondsDesc_exit
adjustSecondsDesc_seconds0AddrNoEqu0:           ; 秒个位不等于9
      DEC     A                 ; 秒个位+1
      MOV     seconds0Addr, A   ; 秒个位+1
adjustSecondsDesc_exit:      
      ; [TODO] ���� KEYBOARD2_2_2_1  �ͷ���Ҫ���Ķ���
      LJMP  testKeyboard2_2_2
keyboard2_2_2_2IsPressing:
      JNB   KEYBOARD2, keyboard2_2_2_2IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD2, keyboard2_2_2_2IsPressing
            ; [TODO] ��ʼ KEYBOARD2_2_2_2 �ͷ���Ҫ���Ķ���
            SETB  TR0  
            LJMP  loop
      
                ;SETB  TR0
             ; [TODO] ���� KEYBOARD2_2_2_2 �ͷ���Ҫ���Ķ���
      ;SETB  TR0
      ; [TODO] ���� KEYBOARD2_2_2 �ͷ���Ҫ���Ķ���
      
                  
keyboard3IsPressing:
      JNB   KEYBOARD3, keyboard3IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD3, keyboard3IsPressing
      ; [TODO] ��ʼ KEYBOARD 3 �ͷ���Ҫ���Ķ���
      
testKeyboard3:    
      LCALL showStopwatch
      JNB   KEYBOARD0, keyboard3_keyboard0IsShake
      JNB   KEYBOARD1, keyboard3_keyboard1IsShake
      JNB   KEYBOARD2, keyboard3_keyboard2IsShake
      LJMP  testKeyboard3
keyboard3_keyboard0IsShake:
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD0, keyboard3_keyboard0IsNotShake ; ���Ƕ���
      LJMP  testKeyboard3                  ; �Ƕ���������
keyboard3_keyboard1IsShake:
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD1, keyboard3_keyboard1IsNotShake ; ���Ƕ���
      LJMP  testKeyboard3                  ; �Ƕ���������
keyboard3_keyboard2IsShake:
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD2, keyboard3_keyboard2IsNotShake ; ���Ƕ���
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
      ; [TODO] ��ʼ KEYBOARD3_KEYBOARD0 �ͷ���Ҫ���Ķ���
      SETB  ET1
      SETB  TR1
      ; [TODO] ���� KEYBOARD3_KEYBOARD0 �ͷ���Ҫ���Ķ���
      LJMP  testKeyboard3
keyboard3_keyboard1IsPressing:
      JNB   KEYBOARD1, keyboard3_keyboard1IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD1, keyboard3_keyboard1IsPressing
      ; [TODO] ��ʼ KEYBOARD2_KEYBOARD1 �ͷ���Ҫ���Ķ���
      CLR   ET1
      CLR   TR1
      ; [TODO] ���� KEYBOARD3_KEYBOARD1 �ͷ���Ҫ���Ķ���
      LJMP  testKeyboard3
keyboard3_keyboard2IsPressing:
      JNB   KEYBOARD2, keyboard3_keyboard2IsPressing
      MOV   R6, #0FH
      LCALL Delay
      JNB   KEYBOARD2, keyboard3_keyboard2IsPressing
      ; [TODO] ��ʼ KEYBOARD3_KEYBOARD2 �ͷ���Ҫ���Ķ���
      CPL   LED2
      CLR   ET1
      CLR   TR1
      MOV   stopwatch0Addr, #0    
      MOV   stopwatch1Addr, #0
      MOV   stopwatch2Addr, #0
      MOV   stopwatch3Addr, #0
      ; [TODO] ���� KEYBOARD3_KEYBOARD2 �ͷ���Ҫ���Ķ���
      LJMP  loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
      
      END
