template = imread('sampleBills/sum.png');
imgOriginal = imresize(imread('sampleBills/billtwonice.jpg'),[1328 747]);%This is the size of the template's original image
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
imrect(gca, [xoffSet+1, yoffSet+1, meanX-xoffSet, size(template,1)]);

