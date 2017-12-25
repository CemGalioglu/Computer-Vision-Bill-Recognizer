function [trimmedImage] = cutWhiteSide(image)
%CUTWHÝTEPARTS Summary of this function goes here
%   Detailed explanation goes here
sums = sum (not(image));
elementx = 0;
counter = 0;
while elementx == 0
    counter = counter + 1;
    elementx =  sums(counter);
end
figure;
trimmedImage =  image(:,counter : size(image,2));
imshow(trimmedImage);
title('Test');