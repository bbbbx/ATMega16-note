#include <iom16v.h>

void delay_ms(unsigned int x)  //延时函数
{
  unsigned int i,j;
  for(i = 0 ; i < x ; i ++)
    for(j = 0 ; j <1141 ; j ++)  ;
}

const unsigned char table_ca[]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90};  //共阳数码管键码

void main()
{
  char gewei=0 , shiwei=0 ,daoshu_gewei=9 , daoshu_shiwei=9;
  int count=1 , flag=0;
  
  DDRA = 0x00;
  DDRC = 0xff;
  DDRD = 0x03;
  
  PORTA = 0xff;
  PORTC = 0x00;
  PORTD = 0x00;
  
  while(1)
  {
    if((PINA&(1<<PA0))==0)  //判断按键PA0是否被按下
	{
      flag=1;
	}
	
	if((PINA&(1<<PA1))==0)  //判断按键PA1是否被按下
	{
	  flag=2;
	}
	
	if((PINA&(1<<PA2))==0)  //判断按键PA2是否被按下
	{
	  flag=3;
	}
	
	if(flag==1)				//正数
	{
	  PORTD = 0x02;
	  PORTC = table_ca[gewei];
	  delay_ms(20);
	  
	  PORTD = 0x01;
	  PORTC = table_ca[shiwei];
	  delay_ms(20);
	  
	  count++;
	  if(count==25)
	  {
	    gewei++;
	    count=0;
	  }
	}
	
	if(flag==2)	   			//倒数
	{
	  PORTD = 0x02;
	  PORTC = table_ca[daoshu_gewei];
	  delay_ms(20);
	  
	  PORTD = 0x01;
	  PORTC = table_ca[daoshu_shiwei];
	  delay_ms(20);
	  
	  count++;
	  if(count==25)
	  {
	    daoshu_gewei--;
		count=0;
	  }
	}
	
	if(flag==3)	   	 	    //置零
	{
	  PORTD = 0x02;
	  PORTC = table_ca[0];
	  gewei=0;
	  delay_ms(20);
	  
	  PORTD = 0x01;
	  PORTC = table_ca[0];
	  shiwei=0;
	  delay_ms(20);
	  
	  gewei=0 , shiwei=0 ,daoshu_gewei=9 , daoshu_shiwei=9;  //初始化各值
	  
	  count++;
	  if(count==25)
	  {
	    count=0;
	  }
	}
	
	if(gewei==10)
	{
	  shiwei++;
	  gewei=0;
	}
	shiwei= (shiwei>=10)?0:shiwei;
	
	if(daoshu_gewei==-1)
	{
	  daoshu_shiwei--;
	  daoshu_gewei=0;
	}
	daoshu_shiwei= (daoshu_shiwei<0)?9:daoshu_shiwei;
  }
}