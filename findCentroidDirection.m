function [result] = findCentroidDirection(image)
%FINDCENTROIDDIRECTION Summary of this function goes here
    stats = regionprops(image);
    stats=sortStats(stats);
    figure;
    imshow(image);
    hold on;
    plot(stats(1).Centroid(1),stats(1).Centroid(2),'r*');
    if stats(1).Centroid(2)<size(image,2)/2
        result='UP';
    else
        result='DOWN';
    end
end

