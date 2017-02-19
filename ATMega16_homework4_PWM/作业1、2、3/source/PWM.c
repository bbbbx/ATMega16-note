#include <iom16v.h>

int MUSIC_F[]={587, 698, 466, 523, 587,
 			   349, 466, 523, 587, 698,
			   523, 587, 698, 466, 523,
			   587, 392, 523, 349, 523,
			   587, 466, 784, 698, 784,
			   466, 587, 392, 587, 698,
			   523, 587, 698, 466, 523,
			   587, 392, 523, 349, 523,
			   587, 466 };  //音符频率
			   
int MUSIC_time[]={800, 800, 1600, 800, 800,
				  1600, 800, 800, 800, 800,
				  3200, 800, 800, 1600, 800,
				  800, 1600, 800, 800, 800,
				  800, 1600, 1600, 1600, 1600,
				  1600, 800, 800, 1200, 400,
				  3200, 800, 800, 1600, 800,
				  800, 1600, 800, 800, 800,
				  800, 3200 };  //音符持续时间

void delay_ms(unsigned int n)
{
  unsigned i , j;
  for(i = 0 ; i < n ; i++)
    for(j = 0 ; j <1141 ; j++) ;
}

void PWM_OC2_init()
{
  DDRD = 0x80;	  //设置OC2为输出；
  PORTD = 0x80;	  //输出高电平
  
  TCCR2 = (1<<WGM21)|(1<<WGM20);   //设置T/C工作模式为快速PWM，TOP值为0xff
  TCCR2 |= (1<<COM21)|(0<<COM20);  //设置比较匹配发生时OC2清零，计数到TOP时OC2置位
  TCCR2 |= (1<<CS22)|(0<<CS21)|(1<<CS20);	//设置分频为128，f=8000000/(128*256)=244，输出频率为244Hz
  
  OCR2 = 0x33;    //占空比初始化为20%，0xff*20%=0x33
}

void PWM_OC0_init()
{
  DDRB = 0x08;	   //设置OC0为输出；
  PORTB = 0x08;	   //输出高电平
  
  TCCR0 = (1<<WGM01)|(1<<WGM00);   //设置T/C工作模式为快速PWM，TOP值为0xff
  TCCR0 |= (1<<COM01)|(0<<COM00);  //设置比较匹配发生时OC0清零，计数到TOP时OC0置位
  TCCR0 |= (1<<CS02)|(0<<CS01)|(0<<CS00);	//设置分频为256，f=8000000/(256*256)=122，输出频率为122Hz
  
  OCR0 = 0x00;    //占空比初始化为0
}

void PWM_OC1A_init()
{
  DDRD |=0x20;	  //设置OC1A为输出；
  PORTD |=0x20;	  //输出高电平

  TCCR1A = (1<<COM1A1)|(0<<COM1A0)|(1<<WGM11)|(0<<WGM10);  //设置T/C工作模式为快速PWM，TOP值为ICR1，设置比较匹配发生时OC0清零，计数到TOP时OC0置位，分频为8
  TCCR1B = (1<<WGM13)|(1<<WGM12)|(1<<CS11);				   //设置T/C工作模式为快速PWM，TOP值为ICR1，设置比较匹配发生时OC0清零，计数到TOP时OC0置位，分频为8
}

void main()
{ 
  char key=0 , music_count=0; //计数音符
  char music_switch=0;  //音乐开关
  DDRC = 0x10;
  PORTC = 0x07;
  
  PWM_OC2_init();     //初始化OC2引脚
  PWM_OC0_init();     //初始化OC0引脚
  PWM_OC1A_init();    //初始化OC1A引脚
 
  while(1)
  { 
	if((PINC&(1<<PC0))==0)  //判断是非按下按键1
	{
	  key=1;
	}
	
	if((PINC&(1<<PC1))==0)  //判断是非按下按键2
	{
	  key=0;
	}
	
	if(key==1)  //key==1时，占空比变化
	{
	  OCR0 += 0x33;    //OCR0比较值每次增加0xff*0.2=0x33，占空比每次增加20%
	}
	
	if(key==0)  //key==0时，占空比固定
	{
	  OCR0 = OCR0;
	}
	
	if((PINC&(1<<PC2))==0)  //判断是非按下按键3
	{
	  music_switch=1;  //音乐开启
	}
	
	if(music_switch==1)
	{
	  ICR1 = 1000000.0/MUSIC_F[music_count]-1;  //TOP值
	  OCR1A = ICR1/2;                       //占空比50%
	  delay_ms(MUSIC_time[music_count]/3);  //音符持续时间
	  music_count++;
	  if(music_count>41)    //42个音符，大于则循环
	  {
	    music_count=0;
	  }
	}
  }
}