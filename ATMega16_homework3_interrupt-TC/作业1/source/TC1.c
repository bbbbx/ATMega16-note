#include <iom16v.h>

unsigned char table_ca[]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};
int GEWEI=0,SHIWEI=0,COUNT=0;

void delay_ms(unsigned int n)
{
  unsigned int i,j;
  for(i = 0 ; i < n ; i++)
    for(j = 0 ; j < 1141; j++) ;
}

#pragma interrupt_handler TC1:9
void TC1()
{
  PORTD = 0x02;			  	   //置PD1为高电平
  PORTC = table_ca[GEWEI];	   //渲染个位数
  delay_ms(20);
  
  if(GEWEI==10)
  {
    GEWEI = 0;
	SHIWEI++;
  }
  if(SHIWEI==10)
  {
    SHIWEI=0;
  }
  PORTD = 0x01;			  	   //置PD0为高电平
  PORTC = table_ca[SHIWEI];	   //渲染十位数
  delay_ms(20);
  
  COUNT++;
  if(COUNT%25==0)
  {
    COUNT=0;
	GEWEI++;
  }
  
  TCNT1H = 0xff;
  TCNT1L = 0xfe;
}

void main()
{
  DDRC = 0xff;
  PORTC = 0x00;
  DDRD = 0x03;
  PORTD = 0x00;
  
  TCCR1B = 0x04;     //时钟选择，8M时钟256分频
  TCNT1H = 0xff;     //先写高位
  TCNT1L = 0xfe;	 //后写低位
  TIMSK = (1<<2);    //定时计数器1溢出中断使能
  SREG |= 0x80;      //开全局中断
  
  while(1) { }
}