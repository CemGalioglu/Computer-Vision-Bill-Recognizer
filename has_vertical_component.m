function result = has_vertical_component(image)
counter = 0;
result = false;
for column = 1 : size(image,2)
    for row = 1:size(image,1)
        if image(column,row) == 1
            counter = counter + 1
        else
            counter = 0;
        end
        if counter>50
            result = true;
        end
    end
end
