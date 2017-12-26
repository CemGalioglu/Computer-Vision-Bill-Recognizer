function result = is_up_oriented(image)
%İSUPORİENTED Summary of this function goes here
%   Detailed explanation goes here
half_length = floor(size(image,1)/2);
up_sum = sum(sum(not(image(1:half_length,:))));
down_sum = sum(sum(not(image))) - up_sum;
ratio = up_sum / down_sum;
if ratio > 1
    result = true;
else 
    result = false;

end

