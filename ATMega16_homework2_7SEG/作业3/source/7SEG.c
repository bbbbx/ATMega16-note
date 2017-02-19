#include <iom16v.h>

void delay_ms(unsigned int n)	//延时函数
{
  unsigned int i,j;
  for(i = 0 ; i < n ; i ++)
    for(j = 0 ; j <1141; j ++) ;
}

const unsigned char table_ca[]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0xff};  //共阳数码管键码

void main()
{
  unsigned char key_2=10 , key_1=10;
  DDRA = 0x0f;
  DDRC = 0xff;
  DDRD = 0x03;
  
  PORTA = 0xf0;
  PORTC = 0x00;
  PORTD = 0x00;
  while(1)
  {
    PORTA = 0xfe;	//扫描第一列
	switch(PINA&(0xf0))
	{
	  case 0xe0: key_2=0 ; 
	  	   		 key_1=0 ;
	  	   		 break;
	  case 0xd0: key_2=4 ; 
	  	   		 key_1=0 ;
	  	   		 break;
	  case 0xb0: key_2=8 ; 
	  	   		 key_1=0 ;
	  	   		 break;
	  case 0x70: key_2=2 ; 
	  	   		 key_1=1 ;
	  	   		 break;
	}
	
	PORTD = 0x02;
	PORTC = table_ca[key_2];
	delay_ms(25);
	
	PORTD = 0x01;
	PORTC = table_ca[key_1];
	delay_ms(25);
	
	PORTA = 0xfd;	//扫描第二列
	switch(PINA&(0xf0))
	{
	  case 0xe0: key_2=1 ; 
	  	   		 key_1=0 ;
	  	   		 break;
	  case 0xd0: key_2=5 ; 
	  	   		 key_1=0 ;
	  	   		 break;
	  case 0xb0: key_2=9 ; 
	  	   		 key_1=0 ;
	  	   		 break;
	  case 0x70: key_2=3 ; 
	  	   		 key_1=1 ;
	  	   		 break;
	}
	
	PORTD = 0x02;
	PORTC = table_ca[key_2];
	delay_ms(25);
	
	PORTD = 0x01;
	PORTC = table_ca[key_1];
	delay_ms(25);
	
	PORTA = 0xfb;	//扫描第三列
	switch(PINA&(0xf0))
	{
	  case 0xe0: key_2=2 ; 
	  	   		 key_1=0 ;
	  	   		 break;
	  case 0xd0: key_2=6 ; 
	  	   		 key_1=0 ;
	  	   		 break;
	  case 0xb0: key_2=0 ; 
	  	   		 key_1=1 ;
	  	   		 break;
	  case 0x70: key_2=4 ; 
	  	   		 key_1=1 ;
	  	   		 break;
	}
	
	PORTD = 0x02;
	PORTC = table_ca[key_2];
	delay_ms(25);
	
	PORTD = 0x01;
	PORTC = table_ca[key_1];
	delay_ms(25);
	
	PORTA = 0xf7;	//扫描第四列
	switch(PINA&(0xf0))
	{
	  case 0xe0: key_2=3 ; 
	  	   		 key_1=0 ;
	  	   		 break;
	  case 0xd0: key_2=7 ; 
	  	   		 key_1=0 ;
	  	   		 break;
	  case 0xb0: key_2=1 ; 
	  	   		 key_1=1 ;
	  	   		 break;
	  case 0x70: key_2=5 ; 
	  	   		 key_1=1 ;
	  	   		 break;
	}
	
	PORTD = 0x02;
	PORTC = table_ca[key_2];
	delay_ms(25);
	
	PORTD = 0x01;
	PORTC = table_ca[key_1];
	delay_ms(25);
	
  }
}