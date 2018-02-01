function [ Y ] = LowPass( x,FT,n,Fs )
%HIGHPASS 此处显示有关此函数的摘要
%   此处显示详细说明
Wn = FT/(Fs/2);
[B ,A] = butter(n, Wn, 'low');
%freqz(A,B);
Y = filter (B,A,x);

end


