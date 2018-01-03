function area_ratio = calculateHoleRatio(image)
    filledImage = not(imfill(image,'holes'));           %Given image is the binary image and we're filling the holes
    holeExtractedImage = not(xor(image,filledImage));   %We're calculating the difference between filled image and the given image
    area_ratio = sum(holeExtractedImage(:))/sum(sum(ones(size(image,1),size(image,2)))); %Lastly we're returning ratio of hole to whole image
end

