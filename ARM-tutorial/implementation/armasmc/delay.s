;***************************************************************
; NAME: delay.s  
;***************************************************************

  EXPORT delayxms

  area delay,code,readonly    
  code32
  
;��������ʱ����ms���ӳ���      
delayxms
     sub r0,r0,#1 ;r0=r0-1
     ldr r11,=1000
loop2
     sub r4,r4,#1
     cmp r4,#0x0
     bne loop2
     cmp r0,#0x0    ;��r0��0�Ƚ�
     bne delayxms   ;�ȽϵĽ����Ϊ0�����������delayxms

     mov pc,lr;����
     
     end