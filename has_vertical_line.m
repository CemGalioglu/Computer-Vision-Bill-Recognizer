function result = has_vertical_line(image)
%HAS_VERT�CAL_L�NE Summary of this function goes here
%   Detailed explanation goes here
result = false;
all_sums = sum(sum(image)==length(image));
        ratio = all_sums/size(image,2);
        if ratio >0.15
            result = true;
        end
end

