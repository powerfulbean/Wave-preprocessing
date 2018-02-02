function Output = Str2Cell( str )
%STR2CELL 此处显示有关此函数的摘要
%   此处显示详细说明
num_Cell = 1;
temp_str='';
Output={''};
for i=1:length(str)
    if str(i)~=','
        temp_str = [temp_str,str(i)];
    else
        Output{1,num_Cell} = temp_str;
        temp_str='';
        num_Cell = num_Cell+1;
    end        
end
Output{1,num_Cell} = temp_str;

