function total_sec = time2sec( time )
%TIME2SEG �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
hour=floor(time/10000);
min= floor((time - hour*10000)/100);
sec = time - hour*10000-min*100;
total_sec = hour*3600+ min*60 + sec;

end

