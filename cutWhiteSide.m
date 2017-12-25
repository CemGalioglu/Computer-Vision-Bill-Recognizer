function [trimmedImage] = cutWhiteSide(image)
%CUTWH�TEPARTS Summary of this function goes here
%   Detailed explanation goes here
sums = sum (not(image));
elementx = 0;
counter = 0;
while elementx == 0
    counter = counter + 1;
    elementx =  sums(counter);
end
trimmedImage =  image(:,counter : size(image,2));