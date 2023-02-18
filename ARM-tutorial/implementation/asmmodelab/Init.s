usr_stack_legth equ 64 ;����������ֵĳ���
svc_stack_legth equ 32
fiq_stack_legth equ 16
irq_stack_legth equ 64
abt_stack_legth equ 16
und_stack_legth equ 16               

  area reset,code,readonly ;����CODE�β�����
  entry ;���ó������αָ��
  code32 ;��������ָ��Ϊ32λ��ARMָ��

;���ø����Ĵ����е�����
start    mov r0,#0
    mov r1,#1
    mov r2,#2
    mov r3,#3
    mov r4,#4
    mov r5,#5
    mov r6,#6
    mov r7,#7
    mov r8,#8
    mov r9,#9
    mov r10,#10
    mov r11,#11
    mov r12,#12
             
    bl initstack  ;��ת��initstack�����ҳ�ʼ����ģʽ�µĶ�ջָ�룬��IRQ�ж�(��cpsr�Ĵ�����iλ��0)
                              
    mrs r0,cpsr        ;r0<--cpsr
    bic r0,r0,#0x80    ;cpsr��Iλ��0����IRQ�ж�
    msr cpsr_cxsf,r0   ;cpsr<--r0
                                    
    ;�л����û�ģʽ
    msr cpsr_c,#0xd0     ;11010000��I��Fλ��1����ֹIRQ��FIQ�жϣ�T=0��ARMִ�У�M[4��0]Ϊ10000���л����û�ģʽ
    mrs r0,cpsr          ;r0<--cpsr
    stmfd sp!,{r1-r12}   ;R1-R12��ջ     
                         ;�۲��û�ģʽ�ܷ��л�������ģʽ
    ;�л�������ģʽ
    msr cpsr_c,#0xdf    ;11011111��I��Fλ��1����ֹIRQ��FIQ�жϣ�T=0��ARMִ�У�M[4��0]Ϊ11111���л���ϵͳģʽ
    mrs r0,cpsr			;r0<--cpsr
    stmfd sp!,{r1-r12}  ;���Ĵ����б��еļĴ��������ջ

halt  b halt ;��halt��ת��halt

initstack  mov r0,lr   ; r0<--lr,��Ϊ����ģʽ��r0����ͬ�Ķ�����ģʽ��ͬ       
                                   
    ;���ù���ģʽ��ջ
    msr cpsr_c,#0xd3   ; 11010011 �л�������ģʽ
    ldr sp,stacksvc    ;���ù���ģʽ��ջ��ַ
    stmfd sp!,{r1-r12} ;R1-R12��ջ�����ݼ�ģʽ

    ;�����ж�ģʽ��ջ
    msr cpsr_c,#0xd2   ;11010010  �л����ж�ģʽ
    ldr sp,stackirq    ;�����ж�ģʽ��ջ��ַ
    stmfd sp!,{r1-r12} ;R1-R12��ջ�����ݼ�ģʽ

    ;���ÿ����ж�ģʽ��ջ
    msr cpsr_c,#0xd1   ;11010001  �л��������ж�ģʽ
    ldr sp,stackfiq    ;���ÿ����ж�ģʽ��ջ��ַ
    stmfd sp!,{r1-r12} ;R1-R12��ջ�����ݼ�ģʽ

    ;������ֹģʽ��ջ   
    msr cpsr_c,#0xd7   ;11010111  �л�����ֹģʽ
    ldr sp,stackabt    ;������ֹģʽ��ջ��ַ
    stmfd sp!,{r1-r12} ;R1-R12��ջ�����ݼ�ģʽ

    ;����δ����ģʽ��ջ   
    msr cpsr_c,#0xdb   ;11011011  �л���δ����ģʽ
    ldr sp,stackund    ;����δ����ģʽ��ջ��ַ
    stmfd sp!,{r1-r12} ;R1-R12��ջ�����ݼ�ģʽ

    ;����ϵͳģʽ��ջ    
    msr cpsr_c,#0xdf   ;11011111  �л���ϵͳģʽ
    ldr sp,stackusr    ;����ϵͳģʽ��ջ��ַ
    stmfd sp!,{r1-r12} ;R1-R12��ջ�����ݼ�ģʽ

    mov pc,r0 ;����
    
    ;Ϊ��ģʽ��ջ����һ���������ִ洢�ռ�
stackusr    dcd  usrstackspace+(usr_stack_legth-1)*4
stacksvc    dcd  svcstackspace+(svc_stack_legth-1)*4
stackirq    dcd  irqstackspace+(irq_stack_legth-1)*4
stackfiq    dcd  fiqstackspace+(fiq_stack_legth-1)*4
stackabt    dcd  abtstackspace+(abt_stack_legth-1)*4
stackund    dcd  undstackspace+(und_stack_legth-1)*4
	;����data�β�����
      area reset,data,noinit,align=2
      ;Ϊ��ģʽ��ջ����洢����
usrstackspace space usr_stack_legth*4
svcstackspace space svc_stack_legth*4
irqstackspace space irq_stack_legth*4
fiqstackspace space fiq_stack_legth*4
abtstackspace space abt_stack_legth*4
undstackspace space und_stack_legth*4
    end