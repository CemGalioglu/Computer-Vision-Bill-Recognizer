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
upper_left = sum(sum(image(intervalFirstX,intervalFirstY)));
ratio_two = sum(sum(image(intervalSecondX,intervalFirstY))) / upper_left;
ratio_three = sum(sum(image(intervalFirstX,intervalSecondY))) / upper_left;
ratio_four = sum(sum(image(intervalSecondX,intervalSecondY))) / upper_left;

if abs(ratio_two-1)<0.2 && abs(ratio_three-1)<0.2 && abs(ratio_four-1)<0.2
    result = true;
end
end
