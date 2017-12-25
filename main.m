close all;
clear;
template = imread('sampleBills/sum.png');
imgOriginal = imread('sampleBills/billsixnice.jpg');%This is the size of the template's original image
img = imbinarize(rgb2gray(imgOriginal));
template = imbinarize(rgb2gray(template));

imgOriginal =  rgb2gray(imgOriginal);
BW = edge(imgOriginal,'canny');
[H,T,R] = hough(BW);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    % Determine the endpoints of the longest line segment
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
yDifference = xy_long(2,2)-xy_long(1,2);
xDifference = xy_long(1,1)-xy_long(2,1);
degree = radtodeg(atan2(yDifference,xDifference));
degree = 90;
imRotated = imrotate(img,90-degree,'crop');

%Using cross correlation to find the template in original image
correlationMatrix = normxcorr2(template,imRotated);

%Get coordinates.
[ypeak, xpeak] = find(correlationMatrix==max(correlationMatrix(:)));

yoffSet = ypeak-size(template,1);
xoffSet = xpeak-size(template,2);

figure
imshow(imRotated);
meanX = xy_long(1,1)+xy_long(2,1);
meanX = meanX /2;
%imrect(gca, [xoffSet+1, yoffSet+1, meanX-xoffSet, size(template,1)]);
imrect(gca, [xoffSet+1, yoffSet+1, size(imgOriginal,2)-xoffSet, size(template,1)]);
% sumRegion = imRotated(yoffSet+1:yoffSet+1+size(template,1),xoffSet+1:meanX);

sumRegion = imRotated(yoffSet+1:yoffSet+1+size(template,1),1:size(imgOriginal,2));

stats = [regionprops(sumRegion);regionprops(not(sumRegion))];
for i = 1:length(stats)
    for j = i:-1:2
        if stats(j).Area>stats(j-1).Area
            temp = stats(j);
            stats(j) = stats(j-1);
            stats(j-1) = temp;
        end
    end
end
second_y_len=stats(2).BoundingBox(4);
figure
imshow(sumRegion);
hold on;
imageContainer(1).image = sumRegion;
counter = 1;
for i=1:numel(stats)
    y_len = stats(i).BoundingBox(4);
    if abs(y_len-second_y_len)<=(second_y_len/1.5)
        rectangle('Position', stats(i).BoundingBox, 'EdgeColor','r');
        xStart = floor(stats(i).BoundingBox(1));
        yStart = floor(stats(i).BoundingBox(2));
        xEnd = xStart+floor(stats(i).BoundingBox(3));
        yEnd = yStart+floor(stats(i).BoundingBox(4));
        if xStart==0
            xStart = 1;
        end
        if yStart==0
            yStart = 1;
        end
        imageContainer(counter).image = sumRegion(yStart:yEnd,xStart:xEnd);
        imageContainer(counter).xStart = xStart;
        counter = counter + 1;
    end
end
for i = 1:length(imageContainer)
    for j = i:-1:2
        if imageContainer(j).xStart<imageContainer(j-1).xStart
            temp = imageContainer(j);
            imageContainer(j) = imageContainer(j-1);
            imageContainer(j-1) = temp;
        end
    end
end
v = imageContainer(length(imageContainer)-3).image;
trimmedImage = cutWhitePart(v);
imshow(trimmedImage);
disp(classify_numbers(trimmedImage));
% classify_numbers(v);
% %imshow(imageContainer(length(imageContainer)).image);
% % n=bwconncomp(imageContainer(length(imageContainer)).image);
% % 
% % h=regionprops(n,'Eulernumber');
% holeNumber = bweuler(not(imageContainer(length(imageContainer)-1).image));
% % figure;
% % BURN = zeros(size(v,1),size(v,2));
% % BURNED = imoverlay(BURN,v,'white');
% figure;
% trimmedImage = cutWhitePart(v);
% filledImage = not(imfill(not(trimmedImage),'holes'));
% holeExtractedImage = xor(trimmedImage,filledImage);
% stats = regionprops(holeExtractedImage);
% stats=sortStats(stats);
% %imshow(holeExtractedImage); 
% %hold on;
% %plot(stats(1).Centroid(1),stats(1).Centroid(2),'r*');
% 
% 
% 
% 
% 
% result = check_horizontal_symmetry(v);