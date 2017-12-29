% BW = edge(extracted_image,'canny');
% [H,T,R] = hough(BW);
% P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% x = T(P(:,2)); y = R(P(:,1));
% lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
% max_len = 0;
% for k = 1:length(lines)
%     xy = [lines(k).point1; lines(k).point2];
%     % Determine the endpoints of the longest line segment
%     len = norm(lines(k).point1 - lines(k).point2);
%     if ( len > max_len)
%         max_len = len;
%         xy_long = xy;
%     end
% end
% yDifference = xy_long(2,2)-xy_long(1,2);
% xDifference = xy_long(1,1)-xy_long(2,1);
% degree = radtodeg(atan2(yDifference,xDifference));
% degree = 90;
% imRotated = imrotate(img,90-degree,'crop');







% classify_numbers(v);
% %imshow(imageContainer(length(imageContainer)).image);
% % n=bwconncomp(imageContainer(length(imageContainer)).image);
% % 
% % h=regionprops(n,'Eulernumber');
% holeNumber = bweuler(not(imageContainer(length(imageContainer)-1).image));
% % figure;
% % BURN = zeros(size(v,1),size(v,2));
% % 
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
%result = check_horizontal_symmetry(trimmedImage);