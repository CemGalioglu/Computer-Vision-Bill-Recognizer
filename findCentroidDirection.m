function result = findCentroidDirection(image)
    stats = regionprops(image);
    stats=sortStats(stats);
    if size(stats,1) == 0
        result = 'NONE';
    elseif stats(1).Centroid(2)<size(image,2)/2
        result='UP';
    else
        result='DOWN';
    end
end

