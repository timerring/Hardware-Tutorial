
 #include "s2440addr.h"

 #define GPC5_ON  ~(1<<5)
 #define GPC5_OFF (1<<5) 
 #define GPC6_ON  ~(1<<6)
 #define GPC6_OFF (1<<6) 
 #define GPC7_ON  ~(1<<7)
 #define GPC7_OFF (1<<7)
 
 
 /*
 * KEY��ӦGPF5
 */
 
 #define GPF5_eint    (0x2<<(5*2))
 #define GPF5_mask    (3<<(5*2))

/***********************�˿ڳ�ʼ��******************************/ 
void port_init()
  {
    rGPCCON= rGPCCON & ~(0x3f<<10)|(0x15<<10); // GPC5��7�˿�����Ϊ���
    rGPCUP= rGPCUP|(7<<5); //��ֹGPC ��5��7�˿���������   
    rGPCDAT= rGPCDAT|(GPC5_OFF|GPC6_OFF|GPC7_OFF);// GPC5-7�˿����  

    rGPCDAT=rGPCDAT&GPC5_ON;  
  }  

/*
 * �ر�WATCHDOG������CPU�᲻������
 */
void disable_watch_dog()
{
    rWTCON = 0;  // �ر�WATCHDOG�ܼ򵥣�������Ĵ���д0����
}


/***********************�жϳ�ʼ��******************************/
void eint_init()
{

 // key0��Ӧ��������Ϊ�ж����� EINT5
    rGPFCON &= ~GPF5_mask;
    rGPFCON |= GPF5_eint;  
    
 // ����EINT5����Ҫ��EINTMASK�Ĵ�����ʹ����
    rEINTMASK &= ~(1<<5);
    rINTMSK &=~(1<<4); //Enable EINT4_7 interrupt 

}



void EINT_Handle()  //�жϴ�����
{
   
    //���ж�
     rEINTPEND |= (1<<5);   // EINT4_7����IRQ4
    rSRCPND |= 1<<4;
    rINTPND |= 1<<4;
      
    //����LED6
        rGPCDAT=rGPCDAT|GPC5_OFF|GPC7_OFF;
        rGPCDAT=rGPCDAT&GPC6_ON;
}

//********************main.c ************
 
int Main()
{
   while(1)
   {
      rGPCDAT=rGPCDAT|GPC6_OFF|GPC7_OFF;
      rGPCDAT=rGPCDAT&GPC5_ON;
    
   };
   return(0);
}

