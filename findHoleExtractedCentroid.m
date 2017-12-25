function [result] = findHoleExtractedCentroid(image)
    filledImage = not(imfill(not(image),'holes'));
    holeExtractedImage = xor(image,filledImage);
    result = findCentroidDirection(holeExtractedImage);
end

