function result = is_up_oriented(image)
%�SUPOR�ENTED Summary of this function goes here
%   Detailed explanation goes here
% half_length = floor(size(image,1)/2);
% up_sum = sum(sum(not(image(1:half_length,:))));
% down_sum = sum(sum(not(image))) - up_sum;
% ratio = up_sum / down_sum;
% if ratio > 1
%     result = true;
% else 
%     result = false;
upper_sum = sum(sum(image(1:30,:)));
lower_sum = sum(sum(image(size(image,1)-30:size(image,1),:)));
upper_ratio = upper_sum / (size(image,2)*30);
lower_ratio = lower_sum / (size(image,2)*30);
if upper_ratio>0.6 && lower_ratio < 0.5
    result = true;
else
    result = false;
end

