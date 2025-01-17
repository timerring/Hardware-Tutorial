;*********************************************************************************************
; NAME: entry.s  
; Author: lihua  
; History: 2014-4-10
;********************************************************************************************

 IMPORT main

  area Init,code,readonly    
  entry
  code32
; ********************** Setup interrupt/exception vectors ********************************
start              b Reset_Handler                      
Undefined_Handler  b Undefined_Handler
SWI_Handler        b SWI_Handler
Prefetch_handler   b Prefetch_handler
Abort_Handler      b Abort_Handler
                   nop   ;Reservedvecto
IRQ_Handler        b IRQ_Handler
FIQ_Handler        b FIQ_Handler

Reset_Handler             
             bl initstack    ;初始化各模式下的堆栈指针 
                             
             ;切换至用户模式堆    
             msr cpsr_c,#0xd0    ;110  10000
                 
             bl main

halt         b halt 

initstack    mov r0,lr        ;r0<--lr,因为各种模式下r0是相同的而各个模式�                             
                                   
             ;设置管理模式堆栈
             msr cpsr_c,#0xd3    ;110  10011  
             ldr sp,stacksvc 
               
             ;设置中断模式堆栈
             msr cpsr_c,#0xd2    ;110  10010
             ldr sp,stackirq  

             
             ;设置快速中断模式堆栈
             msr cpsr_c,#0xd1    ;110  10001
             ldr sp,stackfiq
                                

             ;设置中止模式堆栈      
             msr cpsr_c,#0xd7    ;110  10111
             ldr sp,stackabt
                                    

            ;设置未定义模式堆栈   
             msr cpsr_c,#0xdb    ;110  11011
             ldr sp,stackund
   

             ;设置系统模式堆栈    
             msr cpsr_c,#0xdf    ;110  11111
             ldr sp,stackusr              
             
             mov pc,r0 ;返回
         
  LTORG      

stackusr     dcd  usrstackspace+128
stacksvc     dcd  svcstackspace+128
stackirq     dcd  irqstackspace+128
stackfiq     dcd  fiqstackspace+128
stackabt     dcd  abtstackspace+128
stackund     dcd  undstackspace+128

 
  area Interrupt,data,READWRITE
usrstackspace space 128 
svcstackspace space 128
irqstackspace space 128
fiqstackspace space 128
abtstackspace space 128
undstackspace space 128 
     
       end