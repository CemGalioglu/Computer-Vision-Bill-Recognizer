function result = classify_numbers(image)

num_holes = abs(bweuler(not(image))-1);

if num_holes==2
    result=8;
elseif num_holes==1
    if calculateHoleRatio(image)>1
        result=0;
    else
        if strcmp(findCentroidDirection(image),'DOWN')
            result=9;
        else
            if strcmp(findHoleExtractedCentroid(image),'UP')
                result=4;
            else
                result=6;
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
        result=7;
    end
end

end

