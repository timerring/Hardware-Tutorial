;***************************************************************
; NAME: entry.s  
;***************************************************************

 IMPORT Main  ;�ڻ�������ø�c����ǰҪ�ڻ�����Գ�����ʹ��IMPORTα������������c����

  area Init,code,readonly    
  entry
  code32
; *********** Setup interrupt/exception vectors *************************
start              b Reset_Handler        ;�쳣ʸ���������쳣ʸ������벻ͬģʽ���жϳ���      
Undefined_Handler  b Undefined_Handler
SWI_Handler        b SWI_Handler
Prefetch_handler   b Prefetch_handler
Abort_Handler      b Abort_Handler
                   nop   ;Reserved vector
IRQ_Handler        b IRQ_Handler
FIQ_Handler        b FIQ_Handler

Reset_Handler     ;Reset�жϣ�Ϊ�����жϵ�ʵ����ڵ�        
             bl initstack    ;��ʼ����ģʽ�µĶ�ջָ��
                             
             ;�л����û�ģʽ��    
             msr cpsr_c,#0xd0    ;110  10000
                 
             bl Main

halt         b halt

initstack    mov r0,lr        ;r0<--lr,��Ϊ����ģʽ��r0����ͬ�Ķ�����ģʽ?                            
                                   
             ;���ù���ģʽ��ջ
             msr cpsr_c,#0xd3    ;110  10011  
             ldr sp,stacksvc
               
             ;�����ж�ģʽ��ջ
             msr cpsr_c,#0xd2    ;110  10010
             ldr sp,stackirq  
             
             ;���ÿ����ж�ģʽ��ջ
             msr cpsr_c,#0xd1    ;110  10001
             ldr sp,stackfiq
                                
             ;������ֹģʽ��ջ      
             msr cpsr_c,#0xd7    ;110  10111
             ldr sp,stackabt
                                    
            ;����δ����ģʽ��ջ   
             msr cpsr_c,#0xdb    ;110  11011
             ldr sp,stackund
   
             ;����ϵͳģʽ��ջ    
             msr cpsr_c,#0xdf    ;110  11111
             ldr sp,stackusr
             
             mov pc,r0 ;����
         
  LTORG      

stackusr     dcd  usrstackspace+128
stacksvc     dcd  svcstackspace+128
stackirq     dcd  irqstackspace+128
stackfiq     dcd  fiqstackspace+128
stackabt     dcd  abtstackspace+128
stackund     dcd  undstackspace+128

  area Interrupt,data,READWRITE  ;�����ջ�ռ�
usrstackspace space 128
svcstackspace space 128
irqstackspace space 128
fiqstackspace space 128
abtstackspace space 128
undstackspace space 128
     
       end