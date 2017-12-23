template = imread('sampleBills/sum.png');
imgOriginal = imresize(imread('sampleBills/billthreenice.jpg'),[1328 747]);%This is the size of the template's original image
img = imbinarize(rgb2gray(imgOriginal));
template = imbinarize(rgb2gray(template));
correlationMatrix = normxcorr2(template,img);
surf(correlationMatrix), shading flat

[ypeak, xpeak] = find(correlationMatrix==max(correlationMatrix(:)));

yoffSet = ypeak-size(template,1);
xoffSet = xpeak-size(template,2);

figure
imshow(imgOriginal);
imrect(gca, [xoffSet+1, yoffSet+1, size(imgOriginal,2)-xoffSet, size(template,1)]);