% Fs = 256;
% amount=10000;
% t = 0:1/Fs:amount-1/Fs;
% x0 = sin(2*pi*0.2*t)+sin(2*pi*20*t) +sin(2*pi*1*t)  +sin(2*pi*5*t) +sin(2*pi*10*t) + sin(2*pi*30*t) +  sin(2*pi*50*t);
% x1 = sin(2*pi*1*t)+sin(2*pi*20*t)  +sin(2*pi*5*t) +sin(2*pi*10*t) + sin(2*pi*30*t) ;
% x2 = data(1,:);
% x = x2;
%showRe(x0,Fs);
% title('�����ź�Ƶ��')
% showRe(x1,Fs);
% title('������˺��ź�Ƶ��')
% HPlevel = 3;
% LPlevel =10;
% Y1=HighPass(x,0.5,HPlevel,Fs);
 %showRe(Y1,Fs)
% Y2=LowPass(Y1,40,LPlevel,Fs);
% Y2 = Y2(1,7:length(Y2));
%showRe(Y2,Fs);
% HPstr = num2str(HPlevel);
% LPstr = num2str(LPlevel);
% Datasize= num2str(amount);
% title(['������Ϊ ',Datasize,'sʱ ʵ�ʹ��˺��ͨ����Ϊ ',HPstr,' ��ͨ����Ϊ ',LPstr,' ���ź�Ƶ��'])
% Y3=BandPass(x,0.5,40,8,Fs);
% showRe(Y3,Fs);
load list;
Fs = 256;
HPlevel = 10;
LPlevel =25;
level=length(data(:,1));
for i=1:level
y(i,:)=DJfilter(data(i,:),Fs,HPlevel,LPlevel);
end

map = containers.Map;
for i=1:level
    map(channels{i})=i;
end

level_list = length(list);
for i=1:level_list
    Output(i,:)= y(map(list{i,2}),:)-y(map(list{i,1}),:);
end



