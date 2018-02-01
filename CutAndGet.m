% A1A2map = containers.Map;
% for i = 1: length(list)
%     A1A2map(list{i,1}) = i;
%     if (isKey(A1A2map,list{i,2}))
%         A1A2map(list{i,2}) = [A1A2map(list{i,2}),i];
%     else
%         A1A2map(list{i,2}) = i;
%     end
% end

load A1A2map;