function num = time2num( time,startime, Fs,offset)
%TIME2SEG �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
startsec=time2sec(startime);
targetsec=time2sec(time);
num = (targetsec - startsec) * Fs+offset+8;%�˲��������ƫ��

end

