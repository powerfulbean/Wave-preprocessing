NoFolder=readfile_mat('../data');%���������ļ�����
for i = 1: length(NoFolder)
    load (NoFolder{i});
    Max(i)=max(max(Output));
    Min(i)=min(min(Output));
end

