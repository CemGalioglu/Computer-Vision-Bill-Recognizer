function result = is_vertically_symmetric(image)
  

imageTrimmed = cutWhitePart(image);
imageTrimmedSymmetry = imrotate(imageTrimmed',90);

ratio = sum(sum(xor(imageTrimmedSymmetry,imageTrimmed)))/numel(imageTrimmed);
if ratio<0.2
    result = true;
else
     result = false;
end
end
    

