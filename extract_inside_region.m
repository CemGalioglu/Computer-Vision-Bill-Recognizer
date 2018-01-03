function extracted_image = extract_inside_region(image,binary_image)
%EXTRACT_INSIDE_REGION Summary of this function goes here
%   Detailed explanation goes here
vertical_sum = sum(binary_image); %We find the row that has the vertical sums
column_index=1;
while vertical_sum(column_index)==0 %We are finding the first column has 1 in it
    column_index = column_index+1; 
end
end_column_index=length(vertical_sum);
while vertical_sum(end_column_index)==0 %We are doing the same from the other side
    end_column_index = end_column_index-1; 
end
extracted_image=image(:,column_index:end_column_index); %We extract the middle part of the image
end

