%% Load the Tag file .xlsx
%NoFolder=readfile_mat('../data');%���������ļ�����
Targetdir = '../Output/';%���������·��
Datadir = '../data/';
[~,~,Tag] = xlsread('���ݱ�ǩ1.1.xlsx'); 
% for i = 1: length(NoFolder)
%     load (NoFolder{i});
%     save([Targetdir,NoFolder{i}],'Output');
% end

%% Calculate the number of the patients
Tag_Row = length(Tag);
Num_Patients = 0;
for i=2:Tag_Row % must start from the second row of the Excel file; 
    if ~isnan(Tag{i,1})
       Num_Patients = Num_Patients+1;
    end
end
%% Start the preprocessing
per_StartRow = 2;
per_EndRow = 3;
for i=1:Num_Patients
    data=load([Datadir 'P_' num2str(Tag{per_StartRow,1}) '.mat']);
    while isnan(Tag{per_EndRow,1})
    per_EndRow=per_EndRow+1;
    end
    per_EndRow=per_EndRow-1;
    for j=per_StartRow : per_EndRow %��ʼ�����и����ݵ�ѡȡ
    end
end
