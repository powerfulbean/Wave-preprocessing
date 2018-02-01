function num = time2num( time,startime, Fs,offset)
%TIME2SEG 此处显示有关此函数的摘要
%   此处显示详细说明
startsec=time2sec(startime);
targetsec=time2sec(time);
num = (targetsec - startsec) * Fs+offset+8;%滤波器引起的偏移

end

