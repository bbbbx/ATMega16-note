#include <iom16v.h>

void delay_ms(unsigned int x)  //��ʱ����
{
  unsigned int i,j;
  for(i = 0 ; i < x ; i ++)
    for(j = 0 ; j <1141 ; j ++)  ;
}

const unsigned char table_ca[]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90};  //��������ܼ���

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
    if((PINA&(1<<PA0))==0)  //�жϰ���PA0�Ƿ񱻰���
	{
      flag=1;
	}
	
	if((PINA&(1<<PA1))==0)  //�жϰ���PA1�Ƿ񱻰���
	{
	  flag=2;
	}
	
	if((PINA&(1<<PA2))==0)  //�жϰ���PA2�Ƿ񱻰���
	{
	  flag=3;
	}
	
	if(flag==1)				//����
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
	
	if(flag==2)	   			//����
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
	
	if(flag==3)	   	 	    //����
	{
	  PORTD = 0x02;
	  PORTC = table_ca[0];
	  gewei=0;
	  delay_ms(20);
	  
	  PORTD = 0x01;
	  PORTC = table_ca[0];
	  shiwei=0;
	  delay_ms(20);
	  
	  gewei=0 , shiwei=0 ,daoshu_gewei=9 , daoshu_shiwei=9;  //��ʼ����ֵ
	  
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