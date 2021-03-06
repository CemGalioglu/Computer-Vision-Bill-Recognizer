function [result areaRatio] = findHoleExtractedCentroid(image)
    filledImage = not(imfill(image,'holes'));
    holeExtractedImage = not(xor(image,filledImage));
    result = findCentroidDirection(holeExtractedImage);
    areaRatio = sum(holeExtractedImage(:))/sum(sum(ones(size(image,1),size(image,2))));
end

