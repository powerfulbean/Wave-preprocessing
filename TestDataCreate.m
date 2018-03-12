function  TestDataCreate( dataId )
%TESTDATACREATE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��      100

Datadir = '..\data\';
Targetdir_bin='..\BinOutput\';%������ݱ�����·��
Seg_length_s = 1;%��1sΪ��λ�и�
Fs = 256; %Sample rate is 256
dataTemp=load([Datadir 'P_' num2str(dataId) '.mat']);%���벡������
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

