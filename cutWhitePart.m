function result = cutWhitePart(image)
%We need to cut the white parts around the number so that we can analyze it
%better
result = image;
for i=1:4
    result=cutWhiteSide(result); 
    result = imrotate(result,90);
end

