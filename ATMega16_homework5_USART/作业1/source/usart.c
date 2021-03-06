#include <iom16v.h>

void USART_Init()
{
  DDRD |= 1<<PD1;
  PORTD |= 1<<PD1;
  UCSRB |= 1<<TXEN;   //发送使能
  UCSRC |= (1<<URSEL)|(1<<UCSZ1)|(1<<UCSZ0);  //设置8位字符长度
  UBRRL = 51;    //9600bps
}

void USART_Send(unsigned char data)
{
  while( ! (UCSRA& (1<<UDRE) ) ) ;  //等待数据寄存器UDR为空
  UDR = data;
  while(! (UCSRA & (1<<TXC)) ) ;    //等待发送结束
  
}

void delay_ms(unsigned int ms) 
{
  unsigned int i , j;
  for(i = 0 ; i < ms ; i++)
    for(j = 0 ; j < 1141 ; j++) ;
}

void main()
{
  SREG |= 1<<7;
  USART_Init();
  
  while(1)
  {
    USART_Send('A'); //发送字符'A'
	delay_ms(1000);  //延时1000ms
  }
}