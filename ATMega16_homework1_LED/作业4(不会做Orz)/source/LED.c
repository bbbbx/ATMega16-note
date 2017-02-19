#include <iom16v.h>

const unsigned char delayMs = 100;  //延时，单位：ms

void delay(int n)  //延时函数
{
  int i , j;
  for (i = 0 ; i < n ; i ++)  
    for(j = 0 ; j < 1141 ; j++)  ;
}

void LED_down_0()  //按下下按键时
{
  if((PINC & (1<<PC3)) == 0)
  {
    while(1)
	{
      PORTA = 0x01;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x10;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x00;
	  PORTB = 0x01;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTB = 0x10;
	  delay(delayMs);
	  PORTB = 0x00;
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	}
  }
}

void LED_down_1()  //按下下按键时
{
  if((PINC & (1<<PC3)) == 0)
  {
    while(1)
	{
      PORTA = 0x02;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x20;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x00;
	  PORTB = 0x02;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTB = 0x20;
	  delay(delayMs);
	  PORTB = 0x00;
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	}
  }
}

void LED_down_2()  //按下下按键时
{
  if((PINC & (1<<PC3)) == 0)
  {
    while(1)
	{
      PORTA = 0x04;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x40;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x00;
	  PORTB = 0x04;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTB = 0x40;
	  delay(delayMs);
	  PORTB = 0x00;
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	}
  }
}

void LED_down_3()  //按下下按键时
{
  if((PINC & (1<<PC3)) == 0)
  {
    while(1)
	{
      PORTA = 0x08;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x80;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x00;
	  PORTB = 0x08;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTB = 0x80;
	  delay(delayMs);
	  PORTB = 0x00;
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC2))==0) //若按下其他的按键则跳出循环
	    break;
	}
  }
}

void LED_down()
{
  if(((PINA&(1<<PA0))==1) || ((PINA&(1<<4))==1) || ((PINB&(1<<PB0))==1) || ((PINB&(1<<4))==1))  //判断此时灯在何处是亮的
  {
    LED_down_0();
  }
  if(((PINA&(1<<1))==1) || ((PINA&(1<<5))==1) || ((PINB&(1<<1))==1) || ((PINB&(1<<5))==1))  //判断此时灯在何处是亮的
  {
    LED_down_1();
  }
  if(((PINA&(1<<2))==1) || ((PINA&(1<<6))==1) || ((PINB&(1<<2))==1) || ((PINB&(1<<6))==1))  //判断此时灯在何处是亮的
  {
    LED_down_2();
  }
  if(((PINA&(1<<3))==1) || ((PINA&(1<<7))==1) || ((PINB&(1<<3))==1) || ((PINB&(1<<7))==1))  //判断此时灯在何处是亮的
  {
    LED_down_3();
  }
}

void LED_right_0()
{
  if((PINC & (1<<PC2)) == 0)
  {
    while(1)
	{
      PORTB = 0x00;
      PORTA = 0x01;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x02;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x04;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x08;
	  delay(delayMs);
	  PORTA = 0x00;
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
    }
  }
}

void LED_right_1()
{
  if((PINC & (1<<PC2)) == 0)
  {
    while(1)
	{
      PORTB = 0x00;
      PORTA = 0x10;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x20;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x40;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTA = 0x80;
	  delay(delayMs);
	  PORTA = 0x00;
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
    }
  }
}

void LED_right_2()
{
  if((PINC & (1<<PC2)) == 0)
  {
    while(1)
	{
      PORTA = 0x00;
      PORTB = 0x01;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTB = 0x02;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTB = 0x04;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTB = 0x08;
	  delay(delayMs);
	  PORTB = 0x00;
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
    }
  }
}

void LED_right_3()
{
  if((PINC & (1<<PC2)) == 0)
  {
    while(1)
	{
      PORTA = 0x00;
      PORTB = 0x10;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTB = 0x20;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTB = 0x40;
	  delay(delayMs);
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  PORTB = 0x80;
	  delay(delayMs);
	  PORTB = 0x00;
	  if((PINC&(1<<PC0))==0 || (PINC&(1<<PC1))==0 || (PINC&(1<<PC3))==0) //若按下其他的按键则跳出循环
	    break;
	  
    }
  }
}

void LED_right()  
{
  if(((PINA&(1<<PA0))==1) || ((PINA&(1<<PA1))==1) || ((PINA&(1<<PA2))==1) || ((PINA&(1<<PA3))==1))  //判断此时灯在何处是亮的
  {
    LED_right_0();
  }
  if(((PINA&(1<<PA4))==1) || ((PINA&(1<<PA5))==1) || ((PINA&(1<<PA6))==1) || ((PINA&(1<<PA7))==1))  //判断此时灯在何处是亮的
  {
    LED_right_1();
  }
  if(((PINB&(1<<PB0))==1) || ((PINB&(1<<PB1))==1) || ((PINB&(1<<PB2))==1) || ((PINB&(1<<PB3))==1))  //判断此时灯在何处是亮的
  {
    LED_right_2();
  }
  if(((PINB&(1<<PB4))==1) || ((PINB&(1<<PB5))==1) || ((PINB&(1<<PB6))==1) || ((PINB&(1<<PB7))==1))  //判断此时灯在何处是亮的
  {
    LED_right_3();
  }
}

void LED_up()
{

}

void LED_left()
{

}

void LED_init()  //向右移动，初始值
{
  PORTA = 0x01;
  delay(delayMs);
  LED_down_0();  //按下下按键时
  PORTA = 0x02;
  delay(delayMs);
  LED_down_1();  //按下下按键时
  PORTA = 0x04;
  delay(delayMs);
  LED_down_2();  //按下下按键时
  PORTA = 0x08;
  delay(delayMs);
  LED_down_3();  //按下下按键时
}

void main()
{
  DDRA = 0xff;
  DDRB = 0xff;
  DDRC = 0x00;
  PORTA = 0x00;
  PORTB = 0x00;
  PORTC = 0x0f;
  while(1)
  {
    PORTA = 0x01;
	delay(delayMs);
	LED_up();
	LED_down();
	LED_left();
	LED_right();
	
	PORTA = 0x02;
	delay(delayMs);
	LED_up();
	LED_down();
	LED_left();
	LED_right();
	
	PORTA = 0x04;
	delay(delayMs);
	LED_up();
	LED_down();
	LED_left();
	LED_right();
	
	PORTA = 0x08;
	delay(delayMs);
	LED_up();
	LED_down();
	LED_left();
	LED_right();
  }
}