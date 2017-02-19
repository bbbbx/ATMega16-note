#include <iom16v.h>

/*延时函数*/
void delay(unsigned char x)
{
  unsigned int i,j;
  for(i = 0 ; i < x ;i ++)
    for(j = 0 ; j < 1140; j++) ;
}

/*共阴数码管键码*/
const unsigned char table[]={0x3f , 0x06 , 0x5b , 0x4f , 0x66 , 0x6d , 0x7d , 0x07 , 0x7f , 0x6f};

void main()
{
  
  unsigned int seconds_gewei=0,seconds_shiwei=0,
  		   	   minutes_gewei=0,minutes_shiwei=0,
  		   	   count=1;
  
  DDRC = 0xff;
  DDRD = 0x0f;
  PORTC = 0x00;
  PORTD = 0x00;
  
  while(1)
  {
  
	PORTD = 0xfd;
	PORTC = table[seconds_gewei];  //渲染秒的个位数
	delay(10);
	
	PORTD = 0xfe;
	PORTC = table[seconds_shiwei];  //渲染秒的十位数
	delay(10);
	
	PORTD = 0xfb;
	PORTC = table[minutes_gewei];  //渲染分的个位数
	delay(10);
	
	PORTD = 0xf7;
	PORTC = table[minutes_shiwei];  //渲染分的十位数
	delay(10);
	
	
	
	if(count%26==0)	   //当每1000ms时，秒的个位数加一
	{
	  seconds_gewei++;
	  count=1;
	}
	
	if(seconds_gewei==10)  //当秒的个位数达到10时，秒的十位数就进一位
	{
	  seconds_shiwei++;
	  seconds_gewei=0;
	}
	
	if(seconds_shiwei==6)  //当秒的十位数达到6时，分的个位数加一，秒的十位数置零
	{
	  minutes_gewei++;
	  seconds_shiwei=0;
	}
	
	if(minutes_gewei==10)  //当分的个位数达到10时，分的十位数加一，分的个位数置零
	{
	  minutes_shiwei++;
	  minutes_gewei=0;
	}
	count++;  						//40ms计数一次
  }
}