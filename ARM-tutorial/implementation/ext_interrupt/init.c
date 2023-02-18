/*
 * init.c: ����һЩ��ʼ��
 */ 
#include "s3c2440.h"
/*
 * LED1-4��ӦGPB5��GPB6��GPB7��GPB8
 */
#define GPB5_out        (1<<(5*2))      // LED1
#define GPB6_out        (1<<(6*2))      // LED2
#define GPB7_out        (1<<(7*2))      // LED3
#define GPB8_out        (1<<(8*2))      // LED4
/*
 * K1-K4��ӦGPG0��GPG3��GPG5��GPG6
 */
#define GPG0_eint      (2<<0)           // K1,EINT8
#define GPG3_eint       (2<<(3*2))      // K2,EINT11
#define GPG5_eint       (2<<(5*2))      // K3,EINT13
#define GPG6_eint       (2<<(6*2))      // K4,EINT14

/*
 * �ر�WATCHDOG������CPU�᲻������
 */
void disable_watch_dog(void)
{
    WTCON = 0;  // �ر�WATCHDOG�ܼ򵥣�������Ĵ���д0����
}
void init_led(void)
{
    GPBCON = GPB5_out | GPB6_out | GPB7_out | GPB8_out ;  //����Ϊ�������
}
/*
 * ��ʼ��GPIO����Ϊ�ⲿ�ж�
 * GPIO���������ⲿ�ж�ʱ��Ĭ��Ϊ�͵�ƽ������IRQ��ʽ(��������INTMOD)
 */ 
void init_irq( )
{
    GPGCON  = GPG0_eint | GPG3_eint |GPG5_eint | GPG6_eint;
 
   //ʹ��EINT8 EINT11 EINT13 EINT14
    EINTMASK&=(~(1<<8)) & (~(1<<11)) & (~(1<<13)) & (~(1<<14));
   
   //EINT8 EINT11 EINT13 EINT14�ж����ȼ�һ��,��������
     INTMSK   &=(~(1<<5));           //ʹ��IRQ5
}
 