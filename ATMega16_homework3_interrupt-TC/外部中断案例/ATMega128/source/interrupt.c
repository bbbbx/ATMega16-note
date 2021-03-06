#include <iom128v.h>

int COUNT;       //全局变量，计数按键数

#pragma interrupt_handler seriver0:2
void seriver0()  //INT0中断服务程序
{
  COUNT++;
  PORTA = ~COUNT;
}

#pragma interrupt_handler seriver1:3
void seriver1()  //INT1中断服务程序
{
  COUNT--;
  PORTA = ~COUNT;
}

void main()
{
  DDRA = 0xff;	 //PA口设置为输出
  PORTA = 0xff;  //PA口初始化为高电平，灯全灭

  EICRA = 0x0a;  //INT0，INT1设置为下降沿
  EIMSK |= 0x03; //INT0，INT1中断使能
  SREG |= 0x80;  //开放全局中断
  while(1) {  }  //死循环
}