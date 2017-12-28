function extracted_image = extract_inside_region(image,binary_image)
%EXTRACT_INSIDE_REGION Summary of this function goes here
%   Detailed explanation goes here
vertical_sum = sum(binary_image);
column_index=1;
while vertical_sum(column_index)==0
    column_index = column_index+1; 
end
end_column_index=length(vertical_sum);
while vertical_sum(end_column_index)==0
    end_column_index = end_column_index-1; 
end
disp(end_column_index);
extracted_image=image(:,column_index:end_column_index);
end

