function result = classify_numbers(image)

filled = imfill(image , 'holes'); %We are filling the holes in binary image
holes = filled & ~image;          %We are finding the holes in the image by doing an and operation to filled image and our image's not
bigHoles = bwareaopen(holes,75);  %We are finding the holes that are bigger than a certaing size
smallHoles = holes & ~bigHoles ;  %Then we find small holes with an and operation
image = image | smallHoles ;      %Final image is the image that the small holes are filled
%Above part of the code is taken from https://blogs.mathworks.com/steve/2008/08/05/filling-small-holes/
%We used it to erase small holes in our numbers

num_holes = abs(bweuler(image)-1); %We are finding the number of holes on the binary image

if upper_left_oriented(image) %5 is concentrated on the upper left so we are calculating first if it is such an image
    result = 5;
elseif num_holes>1 %If it has more than two holes it is 8
    result=8;
elseif num_holes==1 %If it has on hole it can be 4,6 or 9 but it can sometimes be 2 due to some noise on the image
    hole_ratio = calculateHoleRatio(image); 
    if hole_ratio>0.18 %If the hole on the image is bigger than a certain size it is 0
        result=0;
    else
        direction=findHoleExtractedCentroid(image); %We are finding where is the hole on the image
        if strcmp(direction,'NONE') %If it is close to middle it is 2
            result = 2;
        elseif strcmp(direction,'DOWN') %If it is lower side of the image it 6
            result=6;
        else
            if has_vertical_line(image) %Now we are calculating if the image has a vertical line that is go from the top to bottom
                result=4; %If it has it is 4
            else
                result =9; %Otherwise 9
            end
        end
    end
    
else
    if is_vertically_symmetric(image) %We are calculating if the xor operation of upper and lower sides are small 
        result=3;
    else       
        if has_vertical_line(image) %We are again calculating if the image has a vertical line
            result = 1;
        else
            if is_up_oriented(image) %We are checking if the image has more 1s on the upper side and comparing it to lower side
                result=7;
            else
                result = 2;
            end
        end
    end
end



