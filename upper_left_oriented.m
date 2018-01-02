function result = upper_left_oriented(image)
%UPPER_LEFT_OR�ENTED Summary of this function goes here
%   Detailed explanation goes here
result = false;
x_size_half = round(size(image,1)/2);
y_size_half = round(size(image,2)/2);

intervalFirstX = 1:x_size_half;
intervalFirstY = 1:y_size_half;
intervalSecondX = x_size_half+1:size(image,1);
intervalSecondY = y_size_half+1:size(image,2);
total = sum(sum(image));
ratio_one = sum(sum(image(intervalFirstX,intervalFirstY))) / 75^2;
ratio_two = sum(sum(image(intervalSecondX,intervalFirstY))) / 75^2;
ratio_three = sum(sum(image(intervalFirstX,intervalSecondY))) / 75^2;
ratio_four = sum(sum(image(intervalSecondX,intervalSecondY))) / 75^2;

if ratio_one>3 && ratio_one/ratio_two>1.5
    result = true;
end
end

