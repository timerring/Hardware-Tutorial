h1=[1,-2,3,5,3,-2,1];
h2=[1,-2,3,3,-2,1];
h3=[1,-2,3,5,-3,2,-1];
h4=[1,-2,3,-3,2,-1];
figure;
[a1,w1,type1,tao1]=amp(h1);type1
subplot(221),plot(w1/pi,abs(a1));
xlabel('*pi');
title('h1 ��Ƶ����');
[a2,w2,type2,tao2]=amp(h2);type2
subplot(222),plot(w2/pi,abs(a2));
title('h2 ��Ƶ����');
xlabel('*pi');
[a3,w3,type3,tao3]=amp(h3);type3
subplot(223),plot(w3/pi,abs(a3));

title('h3 ��Ƶ����');
xlabel('*pi');
[a4,w4,type4,tao4]=amp(h4);type4
subplot(224),plot(w4/pi,abs(a4));
title('h4 ��Ƶ����');
xlabel('*pi');
figure;
subplot(221),zplane(h1,1);title('h1 ���');
subplot(222),zplane(h2,1);title('h2 ���');
subplot(223),zplane(h3,1);title('h3 ���');
subplot(224),zplane(h4,1);title('h4 ���');