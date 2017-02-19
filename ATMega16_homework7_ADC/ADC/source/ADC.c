#include <iom16v.h>

unsigned int SEG7_table_ca[] = { 0xC0 ,0xF9 ,0xA4 ,0xB0 ,0x99 ,0x92 ,0x82 ,0xF8 ,0x80 ,0x90 };  //������������0-9

void delay_ms(unsigned int ms)  //��ʱ����
{
  unsigned int i , j ;
  for( i = 0 ; i < ms ; i++)
  {
    for( j = 0 ; j < 1141 ; j++)
	{
	   ;
	}
  }
}

void ADC_init()
{
  ADMUX = (1<<REFS0)|(1<<MUX2);  		  		  			 //��׼AVCC��ͨ��4
  ADCSRA = (1<<ADEN)|(1<<ADSC)|(1<<ADPS1)|(1<<ADPS0);		 //ADCʹ�ܡ�ADC��ʼת����8��Ƶ
}

unsigned int get_AD()
{
  unsigned int ad;
  ADCSRA |= 1<<ADSC;  //ADC��ʼת��
  while(!(ADCSRA & (1<<ADIF))) ;  //�ȴ���������
  ad = ADC;		   	  //��ȡAD���
  ADCSRA &= ~(1<<ADIF);  //��ADC�жϱ�־
  return ad;         //���ؽ��
}

void main()
{
  unsigned long volts;
  //��ʼ��io
  DDRC = 0xff;
  DDRD = 0x0f;
  PORTC = 0x00;
  PORTD = 0x00;
  
  ADC_init();  //��ʼ��ADC
  
  while(1)
  {
    volts = 1.0*get_AD()/1024*5000;  //��ȡ��ѹֵ����λmV
	
	PORTD = 0x08;
	PORTC = SEG7_table_ca[volts % 10];  //��Ⱦ��4����
	delay_ms(10);
	
	volts = volts/10;
	PORTD = 0x04;
	PORTC = SEG7_table_ca[volts % 10];  //��Ⱦ��3����
	delay_ms(10);
	
	volts = volts/10;
	PORTD = 0x02;
	PORTC = SEG7_table_ca[volts % 10];  //��Ⱦ��2����
	delay_ms(10);
	
	PORTD = 0x01;
	PORTC = SEG7_table_ca[volts / 10];  //��Ⱦ��1����
	PORTC &= ~0x80; 			 //����С����
	delay_ms(10);
  }
}