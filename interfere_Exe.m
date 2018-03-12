%% Load the Tag file .xlsx
%NoFolder=readfile_mat('../data');%加载数据文件名称
Flag_OUTPUTbin = 1;
Flag_OUTPUTpic = 0;
Offset_num=0;
Targetdir = '..\Output\';%输出图像保存总路径
Targetdir_bin='..\BinOutput\';%输出数据保存总路径
if ~exist([Targetdir_bin,'interfere\']) 
    mkdir([Targetdir_bin,'interfere\'])         % 若不存在，在当前目录中产生一个子目录‘Figure’
end 
Datadir = '..\data\';
Seg_length_s = 1;%以1s为单位切割
Fs = 256; %Sample rate is 256
[~,~,Tag] = xlsread('数据标签1.12.xlsx'); 
% for i = 1: length(NoFolder)
%     load (NoFolder{i});
%     save([Targetdir,NoFolder{i}],'Output');
% end
load A1A2map19.mat
load taglist.mat
taglist = {'MOVE'};
load list.mat
%% Calculate the number of the patients
Tag_Row = length(Tag);
Num_Patients = 0;
for i=2:Tag_Row % must start from the second row of the Excel file; 
    if ~isnan(Tag{i,1})
       Num_Patients = Num_Patients+1;
    end
end
%% 确定本Tag文件各个列的名称
Colmap = containers.Map;%declare a Map object
for col=1:size(Tag,2)
    Colmap(Tag{1,col})=col;
end
%% Start the preprocessing
per_StartRow = 2;%%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! was changed for purpose
per_EndRow = 3;
% per_StartRow = 332;
% per_EndRow = 333;
Output = cell(Num_Patients,1);
for i=1:Num_Patients
    %% 找到这个病人最后一段标注的行位置
    while isnan(Tag{per_EndRow,1})
    per_EndRow=per_EndRow+1;
        if per_EndRow>length(Tag)
            break;
        end
    end
    per_EndRow=per_EndRow-1;
    %% Load data and information
    Startime = Tag{per_StartRow,Colmap('时间')};%load起始时间
    data=load([Datadir 'P_' num2str(Tag{per_StartRow,1}) '.mat']);%载入病人数据
    current_patientID = Tag{per_StartRow,1};%load病人病历号
    current_patientName = Tag{per_StartRow,3};
    Output{i,1}=current_patientID;
    Output{i,2}=Startime;
    Seg_Cell = {};%创建存放一个病人所有片段的元组
    Seg_num=0;
    %% 开始进行单个病人片段数据点选取
    for k=1:length(taglist)
        tempCol = Colmap(taglist{k});%获取要取的标签所在的列
        for j=per_StartRow : per_EndRow
            if isnan(Tag{j,tempCol})
                continue;
            end;
            Seg_num=Seg_num+1;
            Seg_startime = Tag{j,tempCol};
            if strcmp(Tag{j,tempCol+1},'???')
                continue;
            end;
            Seg_offset = Tag{j,tempCol+1};
            if strcmp(Tag{j,tempCol+2},'???')
                continue;
            end;
            Seg_Channel = Str2Cell(Tag{j,tempCol+2});%
            Seg_num_Start = time2num(Seg_startime,Startime,Fs,Seg_offset);
            Seg_num_End = time2num(Seg_startime+Seg_length_s,Startime,Fs,Seg_offset);
            Seg_Cell{Seg_num,1} = strcat('startime: ',num2str(Seg_startime),' offset: ',num2str(Seg_offset),' length/s: ',num2str(Seg_length_s),' channel: ',Tag{j,tempCol+2}); 
           %% Cut the data and get the channel-specified segment
            Output_temp=[];
            for p = 1:length(Seg_Channel)
                tempChannel = Seg_Channel{p};
                tempChannel_list = A1A2map(tempChannel);
                %Output = zeros(length(tempChannel_list),Seg_num_End-Seg_num_Start+1);%预分配以提速
                for q=1:length(tempChannel_list)
                    Output_temp=[Output_temp;data.Output(tempChannel_list(q),Seg_num_Start:Seg_num_End)];
                  %% 开始保存数据和打印图像
                  if Flag_OUTPUTpic==1
                    plot(data.Output(tempChannel_list(q),Seg_num_Start:Seg_num_End-1),'k-','LineWidth',3);
                    set(gcf,'position',[10,10,3000,1000]);  
                    str10='病历号：';
                    str11=num2str(current_patientID);
                    str20='  姓名：';
                    str21=current_patientName;
                    str30='  异常发生时间：';
                    temp_str=num2str(Seg_startime);
                    if length(temp_str)==6
                        str311=temp_str(1:2);
                        str312=temp_str(3:4);
                        str313=temp_str(5:6);
                    else
                        str311=temp_str(1);
                        str312=temp_str(2:3);
                        str313=temp_str(4:5);
                    end
                    str31=[str311,':',str312,':',str313];
                    str40='  导联：';
                    str41=list{tempChannel_list(q),1};
                    str=[str10,str11,str20,str21,str30,str31,str40,str41];
                    title(str,'fontsize',10,'LineWidth',3);
                    axis tight;xlabel('time');ylabel(list{tempChannel_list(q),1});
                    file_str= [str11,'_',str21,'\'];
                    if ~exist([Targetdir,file_str]) 
                        mkdir([Targetdir,file_str])         % 若不存在，在当前目录中产生一个子目录‘Figure’
                    end 
                    saveas(gca,[Targetdir,file_str,[str311,'_',str312,'_',str313],'导联_',str41],'jpg');    % 保存图片（以数字命名）
                    close;
                  end
                  if Flag_OUTPUTbin == 1
                        str10='病历号：';
                        str11=num2str(current_patientID);
                        str20='  姓名：';
                        str21=current_patientName;
                        str30='  异常发生时间：';
                        temp_str=num2str(Seg_startime);
                        if length(temp_str)==6
                            str311=temp_str(1:2);
                            str312=temp_str(3:4);
                            str313=temp_str(5:6);
                        else
                            str311=temp_str(1);
                            str312=temp_str(2:3);
                            str313=temp_str(4:5);
                        end
                        str41=list{tempChannel_list(q),1};
                        fid=fopen([Targetdir_bin,'interfere/',str11,'_',[str311,'_',str312,'_',str313,],'Channel_',str41,'(2).txt'],'wb');
                        temp=mapminmax(data.Output(tempChannel_list(q),Seg_num_Start:Seg_num_End-1),-1,1);
                        fwrite(fid,temp,'double');
                        fclose(fid);
                  end
                end
            Seg_Cell{Seg_num,2}= Output_temp;  
            end
        end
    end
    Output{i,3} = Seg_Cell;
    %% 更新下一个病人的起始行
    per_StartRow = per_EndRow+1;
    per_EndRow = per_StartRow+1;
end
