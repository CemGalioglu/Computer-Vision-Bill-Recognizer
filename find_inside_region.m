function result_binary = find_inside_region(image,border_line_one,border_line_two)

[a,b,c] = find_line_function(border_line_one); %We are finding the line function of the hough lines
[d,e,f] = find_line_function(border_line_two); 
result_binary=zeros(size(image,1),size(image,2)); %We are creating an image that has 1s between two lines
for x = 1: size(image,2)
    for y=1:size(image,1)
        if c>f
            if (a*x - b*y <= c) && (d*x-e*y>=f)
                result_binary(y,x) = 1;
            end
        else
            if  (a*x - b*y >= c) && (d*x-e*y<=f)
                result_binary(y,x) = 1;
            end
        end
    end
end


