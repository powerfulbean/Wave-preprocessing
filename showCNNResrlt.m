dir_result='../BinOutput/';
dir_result_normal = [dir_result,'Normal/'];
dir_result_patient=[dir_result,'Unusual/'];
dir_result_interfere=[dir_result,'Interfere/'];
dir_result_normal_plot= [dir_result,'NormalPlot1/'];
dir_result_patient_plot=[dir_result,'UnusualPlot1/'];
dir_result_interfere_plot=[dir_result,'InterferePlot1/'];
NoFolder_normal=readfile_txt([dir_result_normal]);%���������ļ�����
NoFolder_patient=readfile_txt([dir_result_patient]);%���������ļ�����
NoFolder_interfere=readfile_txt([dir_result_interfere]);%���������ļ�����
for i = 1: length(NoFolder_normal)
    fid = fopen([dir_result_normal,NoFolder_normal{i}],'rb');
    answer = fread(fid,inf,'double');
    fclose(fid);
    answer=answer';
    plot(answer,'k-','LineWidth',0.1);
    set(gcf,'position',[50,50,250,250]);  
    %title(['Output_normal_',NoFolder_normal{i}],'fontsize',10,'LineWidth',3);
    axis([0 256 -1 1])%������������ָ��������
    axis off;
    if ~exist([dir_result_normal_plot]) 
        mkdir([dir_result_normal_plot])         % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
    end 
    saveas(gca,[dir_result_normal_plot,'1_',NoFolder_normal{i}(1:length(NoFolder_normal{i})-7),'(1)'],'jpg');    % ����ͼƬ��������������
    
%%
%����תΪĿ�������ֵ
    I=imread([[dir_result_normal_plot,'1_',NoFolder_normal{i}(1:length(NoFolder_normal{i})-7),'(1)'],'.jpg']);
    I2=imresize(I,[150 150],'bicubic');%Ŀ������ֵ
    imwrite(I2,[[dir_result_normal_plot,'1_',NoFolder_normal{i}(1:length(NoFolder_normal{i})-7)],'(1).jpg'],'jpg')
    close;
end
for i = 1: length(NoFolder_patient)
    fid = fopen([dir_result_patient,NoFolder_patient{i}],'rb');
    answer = fread(fid,inf,'double');
    fclose(fid);
    plot(answer','k-','LineWidth',0.1);
    set(gcf,'position',[50,50,250,250]);  
    %title(['Output_patient_',NoFolder_patient{i}],'fontsize',10,'LineWidth',3);
    %axis tight;
    axis([0 256 -1 1])%������������ָ��������
    axis off;
    if ~exist([dir_result_patient_plot]) 
        mkdir([dir_result_patient_plot])         % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
    end 
    saveas(gca,[dir_result_patient_plot,'0_',NoFolder_patient{i}(1:length(NoFolder_patient{i})-7),'(0)'],'jpg');    % ����ͼƬ��������������
    %%
%����תΪĿ�������ֵ
    I=imread([[dir_result_patient_plot,'0_',NoFolder_patient{i}(1:length(NoFolder_patient{i})-7)],'(0).jpg']);
    I2=imresize(I,[150 150],'bicubic');%Ŀ������ֵ
    imwrite(I2,[[dir_result_patient_plot,'0_',NoFolder_patient{i}(1:length(NoFolder_patient{i})-7)],'(0).jpg'],'jpg')
    close;
end
for i = 1: length(NoFolder_interfere)
    fid = fopen([dir_result_interfere,NoFolder_interfere{i}],'rb');
    answer = fread(fid,inf,'double');
    fclose(fid);
    plot(answer','k-','LineWidth',0.1);
    set(gcf,'position',[50,50,250,250]);
    %title(['Output_patient_',NoFolder_patient{i}],'fontsize',10,'LineWidth',3);
    %axis tight;
    axis([0 256 -1 1])%������������ָ��������
    axis off;
    if ~exist([dir_result_interfere_plot]) 
        mkdir([dir_result_interfere_plot])         % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��Figure��
    end 
    saveas(gca,[dir_result_interfere_plot,'2_',NoFolder_interfere{i}(1:length(NoFolder_interfere{i})-4)],'jpg');    % ����ͼƬ��������������
    %%
%����תΪĿ�������ֵ
    I=imread([[dir_result_interfere_plot,'2_',NoFolder_interfere{i}(1:length(NoFolder_interfere{i})-4)],'.jpg']);
    I2=imresize(I,[150 150],'bicubic');%Ŀ������ֵ
    imwrite(I2,[[dir_result_interfere_plot,'2_',NoFolder_interfere{i}(1:length(NoFolder_interfere{i})-4)],'.jpg'],'jpg')
    close;
end