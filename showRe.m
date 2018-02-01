function  showRe(Y,Fs)
%SHOWRE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
figure;
subplot(2,1,1);
%plot(1:200,Y(:,1:200));
plot(Y);
N = length(Y);
xdft_y= fft(Y);
xdft_y= xdft_y(1:N/2+1);
psdx_y= (1/(Fs*N)) * abs(xdft_y).^2;
psdx_y(2:end-1) = 2*psdx_y(2:end-1);
freq_y = 0:Fs/length(Y):Fs/2;

subplot(2,1,2);
plot(freq_y,psdx_y)
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
end

