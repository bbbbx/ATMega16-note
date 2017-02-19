#include <iom16v.h> 

void delay(int n)
{
  int i , j;
  for (i = 0 ; i < n ; i ++)  
    for(j = 0 ; j < 1141 ; j++)  ;
}

void main()
{
  unsigned int run = 0;
  DDRA = 0xff;
  PORTA = 0x00;
  DDRB = 0x00;
  PORTB = 0x01;
  while(1)
  {
    if ((PINB & (1<<PB0) ) == 0)  //判断是否按下按键
    {
	  run++;
    }
	switch(run)
	{
	  case 1:
	  	     PORTA = 0x01;  delay(100);  if((PINB & (1<<PB0) ) == 0)    //判断是否按下按键
			 	   	 					 { 
										   delay(75); 
										   if((PINB & (1<<PB0) ) == 0)   //75ms后再次判断是否按下按键，有则跳出switch（多次试验后75ms效果较好）
										   { 
										     break;
										   } 
										 }
			 PORTA = 0x02;  delay(100);  if((PINB & (1<<PB0) ) == 0)  //判断是否按下按键
			 	   	 					 { 
										   delay(75); 
										   if((PINB & (1<<PB0) ) == 0)  //75ms后再次判断是否按下按键，有则跳出switch（多次试验后75ms效果较好）
										   { 
										     break;
										   } 
										 }
			 PORTA = 0x04;  delay(100);  if((PINB & (1<<PB0) ) == 0)  //判断是否按下按键
			 	   	 					 { 
										   delay(75); 
										   if((PINB & (1<<PB0) ) == 0)  //75ms后再次判断是否按下按键，有则跳出switch（多次试验后75ms效果较好）
										   { 
										     break;
										   } 
										 }
			 PORTA = 0x08;  delay(100);  if((PINB & (1<<PB0) ) == 0)  //判断是否按下按键
			 	   	 					 { 
										   delay(75); 
										   if((PINB & (1<<PB0) ) == 0)  //75ms后再次判断是否按下按键，有则跳出switch（多次试验后75ms效果较好）
										   { 
										     break;
										   } 
										 }
			 PORTA = 0x10;  delay(100);  if((PINB & (1<<PB0) ) == 0)  //判断是否按下按键
			 	   	 					 { 
										   delay(75); 
										   if((PINB & (1<<PB0) ) == 0)  //75ms后再次判断是否按下按键，有则跳出switch（多次试验后75ms效果较好）
										   { 
										     break;
										   } 
										 }
			 PORTA = 0x20;  delay(100);  if((PINB & (1<<PB0) ) == 0)  //判断是否按下按键
			 	   	 					 { 
										   delay(75); 
										   if((PINB & (1<<PB0) ) == 0)  //75ms后再次判断是否按下按键，有则跳出switch（多次试验后75ms效果较好）
										   { 
										     break;
										   } 
										 }
			 PORTA = 0x40;  delay(100);  if((PINB & (1<<PB0) ) == 0)  //判断是否按下按键
			 	   	 					 { 
										   delay(75); 
										   if((PINB & (1<<PB0) ) == 0)  //75ms后再次判断是否按下按键，有则跳出switch（多次试验后75ms效果较好）
										   { 
										     break;
										   } 
										 }
			 PORTA = 0x80;  delay(100);  if((PINB & (1<<PB0) ) == 0)  //判断是否按下按键
			 	   	 					 { 
										   delay(75); 
										   if((PINB & (1<<PB0) ) == 0)  //75ms后再次判断是否按下按键，有则跳出switch（多次试验后75ms效果较好）
										   { 
										     break;
										   } 
										 }
			 break;
	  case 2:
	  	     PORTA = 0x00;
			 break;
	  default : break;
	}
  }
}