function  Y2 = DJfilter( data,Fs,HPlevel,LPlevel )
%DJFILTER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
x = data;
Y1=HighPass(x,0.5,HPlevel,Fs);
Y2=LowPass(Y1,40,LPlevel,Fs);
end

