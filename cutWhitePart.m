function result = cutWhitePart(image)
%CUTWH�TEPART Summary of this function goes here
%   Detailed explanation goes here
result = image;
for i=1:4
    result=cutWhiteSide(result);
    result = imrotate(result,90);
end

