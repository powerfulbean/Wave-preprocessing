function [ Y ] = LowPass( x,FT,n,Fs )
%HIGHPASS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Wn = FT/(Fs/2);
[B ,A] = butter(n, Wn, 'low');
%freqz(A,B);
Y = filter (B,A,x);

end


