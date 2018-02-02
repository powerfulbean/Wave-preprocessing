%% Load the Tag file .xlsx
%NoFolder=readfile_mat('../data');%���������ļ�����
Targetdir = '..\Output\';%���������·��
Datadir = '..\data\';
Seg_length_s = 1;%��1sΪ��λ�и�
Fs = 256; %Sample rate is 256
[~,~,Tag] = xlsread('���ݱ�ǩ1.1.xlsx'); 
% for i = 1: length(NoFolder)
%     load (NoFolder{i});
%     save([Targetdir,NoFolder{i}],'Output');
% end
load A1A2map19.mat
load taglist.mat
load list.mat
%% Calculate the number of the patients
Tag_Row = length(Tag);
Num_Patients = 0;
for i=2:Tag_Row % must start from the second row of the Excel file; 
    if ~isnan(Tag{i,1})
       Num_Patients = Num_Patients+1;
    end
end
%% ȷ����Tag�ļ������е�����
Colmap = containers.Map;%declare a Map object
for col=1:size(Tag,2)
    Colmap(Tag{1,col})=col;
end
%% Start the preprocessing
per_StartRow = 2;
per_EndRow = 3;
Output = cell(Num_Patients,1);
for i=1:1%Num_Patients
    %% �ҵ�����������һ�α�ע����λ��
    while isnan(Tag{per_EndRow,1})
    per_EndRow=per_EndRow+1;
    end
    per_EndRow=per_EndRow-1;
    %% Load data and information
    Startime = Tag{per_StartRow,Colmap('ʱ��')};%load��ʼʱ��
    data=load([Datadir 'P_' num2str(Tag{per_StartRow,1}) '.mat']);%���벡������
    current_patientID = Tag{per_StartRow,1};%load���˲�����
    current_patientName = Tag{per_StartRow,3};
    Output{i,1}=current_patientID;
    Output{i,2}=Startime;
    Seg_Cell = {};%�������һ����������Ƭ�ε�Ԫ��
    Seg_num=0;
    %% ��ʼ���е�������Ƭ�����ݵ�ѡȡ
    for k=1:length(taglist)
        tempCol = Colmap(taglist{k});%��ȡҪȡ�ı�ǩ���ڵ���
        for j=per_StartRow : per_EndRow
            if isnan(Tag{j,tempCol})
                break;
            end;
            Seg_num=Seg_num+1;
            Seg_startime = Tag{j,tempCol};
            Seg_offset = Tag{j,tempCol+1};
            Seg_Channel = Str2Cell(Tag{j,tempCol+2});%
			if strcat(Seg_Channel,'???')
                break;
            end;
            Seg_num_Start = time2num(Seg_startime,Startime,Fs,Seg_offset);
            Seg_num_End = time2num(Seg_startime+Seg_length_s,Startime,Fs,Seg_offset);
            Seg_Cell{Seg_num,1} = strcat('startime: ',num2str(Seg_startime),' offset: ',num2str(Seg_offset),' length/s: ',num2str(Seg_length_s),' channel: ',Tag{j,tempCol+2}); 
           %% Cut the data and get the channel-specified segment
            Output_temp=[];
            for p = 1:length(Seg_Channel)
                tempChannel = Seg_Channel{p};
                tempChannel_list = A1A2map(tempChannel);
                %Output = zeros(length(tempChannel_list),Seg_num_End-Seg_num_Start+1);%Ԥ����������
                for q=1:length(tempChannel_list)
                    Output_temp=[Output_temp;data.Output(tempChannel_list(q),Seg_num_Start:Seg_num_End)];
                  %% ��ʼ�������ݺʹ�ӡͼ��
                    plot(data.Output(tempChannel_list(q),Seg_num_Start:Seg_num_End),'k-','LineWidth',3);
                    set(gcf,'position',[10,10,3000,1000]);  
                    str10='�����ţ�';
                    str11=num2str(current_patientID);
                    str20='  ������';
                    str21=current_patientName;
                    str30='  �쳣����ʱ�䣺';
                    temp_str=num2str(Seg_startime);
                    str311=temp_str(1:2);
                    str312=temp_str(3:4);
                    str313=temp_str(5:6);
                    str31=[str311,':',str312,':',str313];
                    str40='  ������';
                    str41=list{tempChannel_list(q),1};
                    str=[str10,str11,str20,str21,str30,str31,str40,str41];
                    title(str,'fontsize',10,'LineWidth',3);
                    axis tight;xlabel('time');ylabel(list{tempChannel_list(q),1});
                    file_str= [str11,'_',str21,'\'];
                    if ~exist([Targetdir,file_str]) 
                        mkdir([Targetdir,file_str])         % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
                    end 
                    saveas(gca,[Targetdir,file_str,[str311,'_',str312,'_',str313],'_����_',str41],'jpg');    % ����ͼƬ��������������
                    close;
                end
            Seg_Cell{Seg_num,2}= Output_temp;  
            end
        end
    end
    Output{i,3} = Seg_Cell;
    %% ������һ�����˵���ʼ��
    per_StartRow = per_EndRow+1;
    per_EndRow = per_StartRow+1;
end
