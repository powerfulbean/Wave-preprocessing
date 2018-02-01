function  Y2 = DJfilter( data,Fs,HPlevel,LPlevel )
%DJFILTER 此处显示有关此函数的摘要
%   此处显示详细说明
x = data;
Y1=HighPass(x,0.5,HPlevel,Fs);
Y2=LowPass(Y1,40,LPlevel,Fs);
end

