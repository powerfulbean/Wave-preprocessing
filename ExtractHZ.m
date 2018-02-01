function inf= ExtractHZ(Y,Fs,Hz)
%SHOWRE 此处显示有关此函数的摘要
%   此处显示详细说明
N = length(Y);
xdft_y= fft(Y);
xdft_y= xdft_y(1:N/2+1);
psdx_y= (1/(Fs*N)) * abs(xdft_y).^2;
psdx_y(2:end-1) = 2*psdx_y(2:end-1);
%f_y = 0:Fs/length(Y):Fs/2;
t1= Hz*(length(Y)/Fs);
%inf = max(psdx_y);
inf=t1
find (psdx_y==max(psdx_y))
max(psdx_y)
%inf=0;
% for i=1:length(psdx_y)
%     if psdx_y(i)==18581932.4629791
%         inf = i;
%         break;
%     end
%    % i
% end
end

