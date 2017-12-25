I  = imread('sampleBills/billTwo.jpg');
I_org = I;
I = rgb2gray(I);
I = imgaussfilt(I, 10);
BW = edge(I,'canny');

[H,T,R] = hough(BW);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(BW,T,R,P,'FillGap',80,'MinLength',3);
figure, imshow(I_org), hold on
max_len = 0;
max_index = 1;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
      max_index = k;
   end
end
yDifference = xy_long(2,2)-xy_long(1,2);
xDifference = xy_long(1,1)-xy_long(2,1);
maxDegree = radtodeg(atan2(yDifference,xDifference));
secondMax = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   yDifference = xy(2,2)-xy(1,2);
   xDifference = xy(1,1)-xy(2,1);
   degree = radtodeg(atan2(yDifference,xDifference));
   %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   %plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if (abs(degree-maxDegree)==0)
       if(len>secondMax && k~=max_index)
            secondMax = len;
            second_xy_long = xy;
       end
   end
end

plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
plot(second_xy_long(:,1),second_xy_long(:,2),'LineWidth',2,'Color','red');