%plot_rect_function
function [y] = prf(x,duty,n)
%����Ϊ�Ա���x��ռ�ձ�duty������n
%���Ϊy��������ͼ�����ھ������壩
y=(square(2*pi*x/n,duty)+1)/2;
plot(x,y);
ylim([0,2]);
end

