function result = is_vertically_symmetric(image)
  

imageTrimmed = cutWhitePart(image);
imageTrimmedSymmetry = imrotate(imageTrimmed',90);
if sum(sum(xor(imageTrimmedSymmetry,imageTrimmed)))/numel(imageTrimmed)<0.33
    result = true;
else
     result = false;
end
end
    

