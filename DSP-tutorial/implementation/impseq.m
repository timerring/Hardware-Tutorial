function [x,n]=impseq(s0,s1,s2);
%s0����ʼʱ��
%s2����ֹʱ��
%s1�ǳ弤ʱ��

n=s0:0.01:s2;
x=[(n-s1)==0];
