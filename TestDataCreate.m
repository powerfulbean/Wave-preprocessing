function  TestDataCreate( dataId )
%TESTDATACREATE 此处显示有关此函数的摘要
%   此处显示详细说明      100

Datadir = '..\data\';
Targetdir_bin='..\BinOutput\';%输出数据保存总路径
Seg_length_s = 1;%以1s为单位切割
Fs = 256; %Sample rate is 256
dataTemp=load([Datadir 'P_' num2str(dataId) '.mat']);%载入病人数据
data=dataTemp.Output;
height = size(data,1);
width = size(data,2);
step=Fs*Seg_length_s/4;
num=0;
temp=[];
for i=1:height
    for j=1:step:width
        if(j+Fs*Seg_length_s-1<=width)
            temp=data(i,j:j+Fs*Seg_length_s-1);
        end
        num=num+1;
        fid=fopen([Targetdir_bin,'Test\','100_',num2str(dataId),'_',num2str(num),'.txt'],'wb');
        temp2=mapminmax(temp,-1,1);
        fwrite(fid,temp2,'double');
        fclose(fid);
    end
end

