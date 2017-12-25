function result = classify_numbers(image)
%CLASS�FY_NUMBERS Summary of this function goes here
%   Detailed explanation goes here
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
    result=1;
end

end

