#include <iom16v.h> 
const unsigned char dis[]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
void delay (unsigned int x)
{
  int i , j;
  for (i = 0 ; i < x ; i ++)  
    for(j = 0 ; j < 1141 ; j++)  ;
}

void main()
{
  unsigned char n;
  DDRA = 0xff;
  PORTA = 0x00;
  
  while (1)
  {
    for(n = 0 ; n < 8 ; n ++)
	{
	  PORTA = dis[n];
	  delay(100);
	}
  }
}