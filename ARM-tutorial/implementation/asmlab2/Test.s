  AREA Init,CODE,READONLY
 ENTRY
 CODE32
main NOP
NUM EQU 8                
start
 MOV SP,#0X800
 LDR R0,=src            ;��src�ĵ�ַ����R0
 MOV R2,#NUM            ;��ѭ����������R2
 MOV R4,#1
 MOV R5,#2
 MOV R6,#3
 MOV R7,#4
 MOV R8,#5
 MOV R9,#6
 MOV R10,#7
 MOV R11,#8              ;���Ĵ�������ֵ    
loop
 ADD R4,R4,#1
 ADD R5,R5,#1
 ADD R6,R6,#1
 ADD R7,R7,#1
 ADD R8,R8,#1
 ADD R9,R9,#1
 ADD R10,R10,#1
 ADD R11,R11,#1          ;ѭ���ۼӣ�ÿ���Ĵ���ֵ��һ
 STMFD SP!,{R4-R11}      ;��Ĵ���Ѱַ����R4~R11�����ݷ���SPջ��
 SUBS R2,R2,#1           ;R2�е�ѭ��������һ
 BNE loop                ;��Ϊ0����ת��loop����ѭ��    
 LDMIA R0!,{R4-R11}      ;����R0��ʼ��ַ��ֵ����R4-R11������R4~R11��ո�ֵΪ0. IAģʽ��ʾ��ÿ�δ��ͺ��ַ+4(After Increase)
Stop
 B Stop
 LTORG                   ;�������ݻ����
src DCD 0,0,0,0,0,0,0,0    
 END