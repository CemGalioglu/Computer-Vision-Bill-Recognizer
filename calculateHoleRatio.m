function area_ratio = calculateHoleRatio(image)
% filledImg=not(imfill(image,'holes'));
% holeArea = sum(sum(image - filledImg));
% figure;
% imshow(holeArea);
% title('hole');
% imageArea = sum(sum(not(image)));
% figure;
% imshow(imageArea);
% title('image');
% result = holeArea / imageArea ;
    filledImage = not(imfill(image,'holes'));
    holeExtractedImage = not(xor(image,filledImage));
    area_ratio = sum(holeExtractedImage(:))/sum(sum(ones(size(image,1),size(image,2))));
end

