function a = find_inside_region(image,border_line_one,border_line_two)
%FÝND_ÝNSÝDE_REGÝON Summary of this function goes here
%   Detailed explanation goes here
[a,b,c] = find_line_function(border_line_one);
[d,e,f] = find_line_function(border_line_two);
result_image= image;

points(1).x = 0;
points(1).y = 0;
figure;
for x = 1: size(image,2)
    for y=1:size(image,1)
        if c>f
            if (a*y - b*x <= c) && (d*y-e*x>=f)
                result_image(y,x,1) = 0;
                result_image(y,x,2) = 255;
                result_image(y,x,3) = 0;
            end
        else
            if  (a*y - b*x >= c) && (d*y-e*x<=f)
                result_image(y,x,1) = 0;
                result_image(y,x,2) = 255;
                result_image(y,x,3) = 0;
            end
        end
    end
end
    imshow(result_image);
    title('Color inside');
    result_image = 1;
