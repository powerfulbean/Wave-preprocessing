% NoFolder=readfile_mat('../data');%���������ļ�����
% for i = 1: length(NoFolder)
%     load (NoFolder{i});
%     Max(i)=max(max(Output));
%     Min(i)=min(min(Output));
% end
% fid = fopen('17105168_������_14_05_03Channel_t5.txt','wb');
% fwrite(fid,a','double');
% fclose(fid);

fid = fopen('d:\\17105203_15_35_56Channel_c4(0).txt','rb');
answer = fread(fid,inf,'double');
answer=answer';
fclose(fid);