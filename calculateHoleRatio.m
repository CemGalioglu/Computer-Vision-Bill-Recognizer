function result = calculateHoleRatio(image)
filledImg=not(imfill(not(image),'holes'));
holeArea = sum(sum(image - filledImg));
imageArea = sum(sum(not(image)));
result = holeArea / imageArea ;
end

