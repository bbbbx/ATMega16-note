#include <iom16v.h>

int COUNT;       //ȫ�ֱ���������������

#pragma interrupt_handler seriver0:2
void seriver0()  //INT0�жϷ������
{
  COUNT++;
  PORTA = ~COUNT;
}

#pragma interrupt_handler seriver1:3
void seriver1()  //INT1�жϷ������
{
  COUNT--;
  PORTA = ~COUNT;
}

void main()
{
  DDRA = 0xff;	 //PA������Ϊ���
  PORTA = 0xff;  //PA�ڳ�ʼ��Ϊ�ߵ�ƽ����ȫ��

  MCUCR = 0x0a;  //INT0��INT1����Ϊ�½���
  GICR |= 0xC0; //INT0��INT1�ж�ʹ��
  SREG |= 0x80;  //����ȫ���ж�
  while(1) {  }  //��ѭ��
}