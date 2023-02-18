 #define rGPCCON (*(volatile unsigned *)(0x56000020))
 #define rGPCDAT (*(volatile unsigned *)(0x56000024)) 
 #define rGPCUP (*(volatile unsigned *)(0x56000028)) 
 
 #define rGPFCON (*(volatile unsigned *)(0x56000050))
 #define rGPFDAT (*(volatile unsigned *)(0x56000054)) 
 #define rGPFUP (*(volatile unsigned *)(0x56000058)) 

 #define GPC5_ON  ~(1<<5)
 #define GPC5_OFF (1<<5) 
 #define GPC6_ON  ~(1<<6)
 #define GPC6_OFF (1<<6) 
 #define GPC7_ON  ~(1<<7)
 #define GPC7_OFF (1<<7)
 

void delay(int time) //��ʱ����,����ɨ�谴��ʱȥ�������
{  
    int i,j; 
    for(i=0;i<time;i++)    
        for(j=0;j<255;j++);       
} 

void port_init()
{
  rGPCCON= rGPCCON & ~(0x3f<<10)|(0x15<<10); // GPC5��7�˿�����Ϊ���
  rGPCUP= rGPCUP|(7<<5); //��ֹGPC ��5��7�˿���������
  
  rGPFCON= rGPFCON & ~(0x3<<10); //��GPF��5�˿�����Ϊ����
  rGPFUP= rGPCUP & ~(1<<5); // GPF ��5�˿���������
  
 // delay(10);
  
  rGPCDAT= rGPCDAT|(GPC5_OFF|GPC6_OFF|GPC7_OFF);// GPC5-7�˿����  

}

char Key_Scan() //����ɨ����� 
{
  char key=rGPFDAT&(1<<5);
  
 if(!key)  //���GPF5�����£���ȡ���͵�ƽ   
  {
      delay(100); //��ʱȥ����������ֻ��һ����ŵ���ʱֵ 
      if(!key) //�ٴ��ж�
         return 1; //����"1"
      else
         return 0;
  }
  else
   return 0;
}
   
int main()
{
   int count=0;
   char direction=0;
  // char olddir=0;
   port_init();
   while(1)
   {
      if(Key_Scan())
        direction=1;
      else
        direction=0;
                   
      switch(count)
      {
        case 0:
          rGPCDAT=rGPCDAT&GPC5_ON;
          rGPCDAT=rGPCDAT|GPC6_OFF|GPC7_OFF;
          delay(400);
          break; 
        case 1:
          rGPCDAT=rGPCDAT&GPC6_ON;
          rGPCDAT=rGPCDAT|GPC5_OFF|GPC7_OFF;
          delay(400);
          break;
        case 2:
          rGPCDAT=rGPCDAT&GPC7_ON;
          rGPCDAT=rGPCDAT|GPC5_OFF|GPC6_OFF;
          delay(400);
          break;
        default:
          break;
      }   
       
      if(!direction)
       {
         if(count==2)
           count=-1;
         count++;
       }
      else
       {
        if(count==0)
           count=3;
        count--;
       };           
        
    }
}

