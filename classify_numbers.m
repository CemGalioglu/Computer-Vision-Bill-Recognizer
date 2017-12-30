function result = classify_numbers(image)

num_holes = abs(bweuler(image)-1);

if num_holes==2
    result=8;
elseif num_holes==1
    hole_ratio = calculateHoleRatio(image);
    if hole_ratio>1
        result=0;
    elseif hole_ratio<0.03
        %result=classify_numbers(imfill(image,'holes'));
        result=5;
    else
        if strcmp(findCentroidDirection(image),'DOWN')
            result=6;
        else
            if strcmp(findHoleExtractedCentroid(image),'UP')
                result=9;
            else
                result=4;
            end
        end
    end
else
    if is_vertically_symmetric(image)
        if size(image,1)/size(image,2)>1.1
            result=1;
        else
            result=3;
        end
    else
        if is_up_oriented(image)
            result=7;
        else
            result = 2;
        end
    end
end

end

