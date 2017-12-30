function result = is_up_oriented(image)
%İSUPORİENTED Summary of this function goes here
%   Detailed explanation goes here
% half_length = floor(size(image,1)/2);
% up_sum = sum(sum(not(image(1:half_length,:))));
% down_sum = sum(sum(not(image))) - up_sum;
% ratio = up_sum / down_sum;
% if ratio > 1
%     result = true;
% else 
%     result = false;
sum = 0;
for i=1:30
    for j=2:size(image,2)
        if image(i,j)==1
            sum = sum + 1;
        end
    end
end
ratio = sum / (size(image,2)*30)
if ratio>0.8
    result = true;
else
    result = false;
end

