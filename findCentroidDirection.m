function result = findCentroidDirection(image)
    stats = regionprops(image);
    stats=sortStats(stats);
    halfway = size(image,2)/2;
    %figure; imshow(image); hold on; plot(stats(1).Centroid(1),stats(1).Centroid(2),'r*');
    if size(stats,1) == 0
        result = 'NONE';
    elseif ((stats(1).Centroid(2)-halfway)/halfway)<-0.11
        result='UP';
    elseif ((stats(1).Centroid(2)-halfway)/halfway)>0.11
        result='DOWN';
    else 
        direction = (stats(1).Centroid(2)-halfway)/halfway;
        result='MID';
    end
end

