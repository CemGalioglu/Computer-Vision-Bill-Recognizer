function result = classify_numbers(image)
filled = imfill(image , 'holes');
holes = filled & ~image;
bigHoles = bwareaopen(holes,75);
smallHoles = holes & ~bigHoles ;
image = image | smallHoles ;
% figure;
% subplot(1,4,1);
% imshow(image);
% subplot(1,4,2);
% imshow(bigHoles);
% subplot(1,4,3);
% imshow(smallHoles);
% subplot(1,4,4);
% imshow(image);
num_holes = abs(bweuler(image)-1);

if upper_left_oriented(image)
    result = 5;
elseif num_holes>1
    result=8;
elseif num_holes==1
    hole_ratio = calculateHoleRatio(image);
    if hole_ratio>0.18
        result=0;
        %  elseif hole_ratio<0.03
        %  result=classify_numbers(imfill(image,'holes'));
        %     result = 5;
    else
        direction=findHoleExtractedCentroid(image);
        if strcmp(direction,'NONE')
            result = 2;
        elseif strcmp(direction,'DOWN')
            result=6;
        else
            if has_vertical_line(image)
                result=4;
            else
                result =9;
            end
        end
    end
    
else
    if is_vertically_symmetric(image)
        result=3;
    else       
        if has_vertical_line(image)
            result = 1;
        else
            if is_up_oriented(image)
                result=7;
            else
                result = 2;
            end
        end
    end
end



