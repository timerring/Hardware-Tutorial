  AREA comp,CODE,READONLY ;�������Ƭ��comp ֻ��
 	ENTRY           ;�������
 CODE32          ;����ΪARM����
START         
  LDR R0, = DAT      ;�������ݶ���DAT�����ݵĵ�ַ��R0
  LDR R1, [R0]       ;����R0�����ݵ�R1
  LDR R2, [R0]       ;����R0�����ݵ�R1
  MOV R3,#1        ;ѭ������R3��ʼ��1
LOOP
  ADD R0,R0,#4       ;ÿ��ѭ��R0+4
  LDR R4,[R0]      ;R4����R0������
  CMP R1,R4        ;�Ƚ�R1,R4
  MOVLT R1,R4      ;���R1<R4 �Ͱ�R4����R1
  CMP R2,R4        ;�Ƚ�R2��R4
  MOVGT R2,R4      ;���R2>R4 �Ͱ�R4����R2
  ADD R3,R3,#1       ;ÿ��ѭ��R3ֵ��һ
  CMP R3,#8        ;�ж�R3��8
  BLT LOOP         ;���R3 < 8����ת��LOOPִ��
 B .           ;�˳�
 AREA D,DATA,READONLY  ;����һ�����ݶ�D����д
DAT DCD 11,-2,35,47,96,63,128,-23
 END