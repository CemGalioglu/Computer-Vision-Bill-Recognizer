function [result] = sortStats(stats)
%SORTSTATS Summary of this function goes here
%   Detailed explanation goes here
for i = 1:length(stats)
    for j = i:-1:2
        if stats(j).Area>stats(j-1).Area
            temp = stats(j);
            stats(j) = stats(j-1);
            stats(j-1) = temp;
        end
    end
end
result=stats;
end

