NoFolder=readfile_mat('../data');%加载数据文件名称
for i = 1: length(NoFolder)
    load (NoFolder{i});
    Max(i)=max(max(Output));
    Min(i)=min(min(Output));
end

