function result = is_up_oriented(image)
upper_sum = sum(sum(image(1:30,:)));
lower_sum = sum(sum(image(size(image,1)-30:size(image,1),:)));
upper_ratio = upper_sum / (size(image,2)*30);
lower_ratio = lower_sum / (size(image,2)*30);
if upper_ratio>0.6 && lower_ratio < 0.5
    result = true;
else
    result = false;
end
end