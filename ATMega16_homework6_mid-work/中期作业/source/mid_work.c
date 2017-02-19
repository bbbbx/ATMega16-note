#include <iom16v.h>

unsigned char SEG7_num_ca[] = { 0xC0 ,0xF9 ,0xA4 ,0xB0 ,0x99 ,0x92 ,0x82 ,0xF8 ,0x80 ,0x90 };  //共阳数码管码表0-9
unsigned char SEG7_numWithDot_ca[] = { 0x40 ,0x79 ,0x24 ,0x30 ,0x19 ,0x12 ,0x02 ,0x78 ,0x00 ,0x10 };  //共阳数码管码表带小数点0-9

/*
-------说明---------
SEG7_flag：1显示年份
SEG7_flag：2显示日期
SEG7_flag：3显示时分

LED_flag：1流水灯正方向
LED_flag：2流水灯反方向

alarm_clock_flag：1开启闹钟
alarm_clock_flag：0关闭闹钟

motor：1开启舵机
motor：0关闭舵机

SEG7_flag：数码管状态，LED_flag：LED状态，alarm_clock_flag：闹钟状态，motor_EN：舵机使能
*/
int SEG7_flag=0 , alarm_clock_flag=1 , motor_EN=0;

void delay_ms(unsigned int ms)  //延时函数
{
  unsigned int i , j ; 
  for (i = 0 ; i < ms ; i++)
    for(j = 0 ; j < 1141 ; j++) ;
}

void SEG7_init()  //数码管IO初始化函数
{
  DDRA = 0xff;
  PORTA = 0x00;
  DDRB = 0xff;
  PORTB = 0x00;
  
}

void SEG7_show_year()  //数码管显示年份2017函数
{
  //渲染2
  PORTB |= (1<<PB0);
  PORTB &= ~(1<<PB1);
  PORTB &= ~(1<<PB2);
  PORTB &= ~(1<<PB3);
  PORTA = SEG7_num_ca[2];
  delay_ms(10);
  //渲染0
  PORTB &= ~(1<<PB0);
  PORTB |= (1<<PB1);
  PORTB &= ~(1<<PB2);
  PORTB &= ~(1<<PB3);
  PORTA = SEG7_num_ca[0];
  delay_ms(10);
  //渲染1
  PORTB &= ~(1<<PB0);
  PORTB &= ~(1<<PB1);
  PORTB |= (1<<PB2);
  PORTB &= ~(1<<PB3);
  PORTA = SEG7_num_ca[1];
  delay_ms(10);
  //渲染7
  PORTB &= ~(1<<PB0);
  PORTB &= ~(1<<PB1);
  PORTB &= ~(1<<PB2);
  PORTB |= (1<<PB3);
  PORTA = SEG7_num_ca[7];
  delay_ms(40);
}

void SEG7_show_date()  //数码管显示日期0203函数
{
  //渲染0
  PORTB |= (1<<PB0);
  PORTB &= ~(1<<PB1);
  PORTB &= ~(1<<PB2);
  PORTB &= ~(1<<PB3);
  PORTA = SEG7_num_ca[0];
  delay_ms(10);
  //渲染2
  PORTB &= ~(1<<PB0);
  PORTB |= (1<<PB1);
  PORTB &= ~(1<<PB2);
  PORTB &= ~(1<<PB3);
  PORTA = SEG7_num_ca[2];
  delay_ms(10);
  //渲染0
  PORTB &= ~(1<<PB0);
  PORTB &= ~(1<<PB1);
  PORTB |= (1<<PB2);
  PORTB &= ~(1<<PB3);
  PORTA = SEG7_num_ca[0];
  delay_ms(10);
  //渲染3
  PORTB &= ~(1<<PB0);
  PORTB &= ~(1<<PB1);
  PORTB &= ~(1<<PB2);
  PORTB |= (1<<PB3);
  PORTA = SEG7_num_ca[3];
  delay_ms(40);
}

void SEG7_show_time()  //数码管显示时分17.54函数
{
  //渲染1
  PORTB |= (1<<PB0);
  PORTB &= ~(1<<PB1);
  PORTB &= ~(1<<PB2);
  PORTB &= ~(1<<PB3);
  PORTA = SEG7_num_ca[1];
  delay_ms(10);
  //渲染0
  PORTB &= ~(1<<PB0);
  PORTB |= (1<<PB1);
  PORTB &= ~(1<<PB2);
  PORTB &= ~(1<<PB3);
  PORTA = SEG7_numWithDot_ca[7];
  delay_ms(10);
  //渲染0
  PORTB &= ~(1<<PB0);
  PORTB &= ~(1<<PB1);
  PORTB |= (1<<PB2);
  PORTB &= ~(1<<PB3);
  PORTA = SEG7_num_ca[5];
  delay_ms(10);
  //渲染3
  PORTB &= ~(1<<PB0);
  PORTB &= ~(1<<PB1);
  PORTB &= ~(1<<PB2);
  PORTB |= (1<<PB3);
  PORTA = SEG7_num_ca[4];
  delay_ms(40);
}

void button_init()  //矩阵按键IO初始化函数
{
  DDRC = 0x0f;
  PORTC = 0xff;
}

void button_scan()  //扫描矩阵按键函数
{
  //扫描第一列
  PORTC = 0xf7;
  switch(PINC&(0xf0))
  {
    case 0xe0: SEG7_flag=1 ;
	  	   	   break;  	   	  //按键0
	case 0xd0: alarm_clock_flag=1 ; 
	  	   	   break;  	   	  //按键4
	case 0xb0:  
	  	   	   break;  	   	  //按键8
    case 0x70: motor_EN=1 ; 
	  	   	   break;  	   	  //按键12
  }
  //扫描第二列
  PORTC = 0xfb;
  switch(PINC&(0xf0))
  {
    case 0xe0: SEG7_flag=2 ;
	  	   	   break;  	   	  //按键1
	case 0xd0: alarm_clock_flag=0 ; 
	  	   	   break;  	   	  //按键5
	case 0xb0: LED_init();
		 	   PORTD = 0x01;
			   delay_ms(100);
			   PORTD = 0x02;
			   delay_ms(100);
			   PORTD = 0x04;
			   delay_ms(100);
			   PORTD = 0x08;
			   delay_ms(100);
			   PORTD = 0x10;
			   delay_ms(100);
			   PORTD = 0x20;
			   delay_ms(100);
			   PORTD = 0x40;
			   delay_ms(100);
			   PORTD = 0x80;
			   delay_ms(100);
			   PORTD = 0x00;
	  	   	   break;  	   	  //按键9
    case 0x70:  ; 
	  	   	   break;  	   	  //按键13
  }
  //扫描第三列
  PORTC = 0xfd;
  switch(PINC&(0xf0))
  {
    case 0xe0: SEG7_flag=3 ;
	  	   	   break;  	   	  //按键2
	case 0xd0: 
	  	   	   break;  	   	  //按键6
	case 0xb0: LED_init();
		 	   PORTD = 0x80;
			   delay_ms(100);
			   PORTD = 0x40;
			   delay_ms(100);
			   PORTD = 0x20;
			   delay_ms(100);
			   PORTD = 0x10;
			   delay_ms(100);
			   PORTD = 0x08;
			   delay_ms(100);
			   PORTD = 0x04;
			   delay_ms(100);
			   PORTD = 0x02;
			   delay_ms(100);
			   PORTD = 0x01;
			   delay_ms(100);
			   PORTD = 0x00;
	  	   	   break;  	   	  //按键10
    case 0x70:  ; 
	  	   	   break;  	   	  //按键14
  }
  //扫描第四列
  PORTC = 0xfe;
  switch(PINC&(0xf0))
  {
    case 0xe0: 
	  	   	   break;  	   	  //按键3
	case 0xd0:  
	  	   	   break;  	   	  //按键7
	case 0xb0: 
	  	   	   break;  	   	  //按键11
    case 0x70:  ; 
	  	   	   break;  	   	  //按键15
  }
}

void alarm_clock_open()  //开启闹钟
{
  PORTB &= ~(1<<PB4);
}

void alarm_clock_close()  //关闭闹钟
{
  PORTB |= (1<<PB4);
}

void PWM_OC2_init()  //OC2初始化
{
  DDRD = 0x80;
  PORTD = 0x00;
  TCCR2 = (0<<WGM21)|(1<<WGM20)|(1<<COM21)|(0<<COM20)|(1<<CS22)|(1<<CS21)|(0<<CS20); //相位修正PWM模式，256分频，周期为16.4ms
  OCR2 = 0x1b;
}

void LED_init()
{
  DDRD = 0xff;
  PORTD = 0x00;
  DDRB = 0xf0;
  PORTB |= 1<<PB6;
  PORTB |= 0<<PB7;
}

void main()
{
  SEG7_init();  //初始化数码管引脚
  button_init();  //初始化矩阵键盘引脚
  
  while(1)
  {
    button_scan();  //扫描矩阵按键
	
    switch(SEG7_flag)
	{
	  case 1 : SEG7_show_year();  //数码管显示年份2017
	  	   	   break;
	  case 2 : SEG7_show_date();  //数码管显示日期0203
	  	   	   break;
	  case 3 : SEG7_show_time();  //数码管显示时分17.54
	  	   	   break;
	}
	
	switch(alarm_clock_flag)
	{
	  case 0 : alarm_clock_close();  //关闭闹钟
	  	   	   break;
	  case 1 : alarm_clock_open();  //开启闹钟
	  	   	   break;
	}
	
	switch(motor_EN)
	{
	  case 0 : break;
	  case 1 : PWM_OC2_init();  //开启舵机
	  	   	   break;
	}
  }
}