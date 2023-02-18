  AREA Init,CODE,READONLY
 ENTRY
 CODE32
start
  MOV SP, #0x400      ;���ö�ջ��ַ(�������û�õ�)
  LDR R0, =Src        ;��ԭ�ַ�����ַ��R0
  LDR R1, =Dst        ;��Ŀ���ַ�����ַ��R1
  MOV R3,#0           ;R3��ֵΪ0
strcopy
  LDRB R2,[R0],#1     ;�洢����ַΪR0���ֽ����ݶ���Ĵ���R2�������µ�ַR0+1��ֵ����R0
  CMP R2,#0           ;�Ƚ�R2��0������ַ����Ƿ����
  BEQ endcopy         ;����0����ת��endcopy
  STRB R2,[R1],#1     ;��R2�е��ֽ�����д����R1Ϊ��ַ�Ĵ洢���У������µ�ַR1+1��ֵ����R1
  ADD R3,R3,#1        ;R3�Լ�һ����¼�ַ�����
  B strcopy           ;ѭ��
endcopy
  LDR R0, =ByteNum    ;���ַ����ĵ�ַ��R0
  STR R3,[R0]         ;��R3��ֵ�ŵ�R0��
  B .
  AREA Datapool,DATA,READWRITE  
Src  DCB  "string",0  ;��ʼ�ַ����洢�ռ�
Dst DCB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0      ;Ŀ���ַ����洢�ռ�
ByteNum DCD 0
 END
