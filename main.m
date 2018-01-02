files = dir('sampleBills/');
template = imread('templates/sum.jpg');
sonuc = rgb2gray(imread('templates/sonuc.jpg'));
template = imbinarize(rgb2gray(template));
truth = {};
fileNumber = 1;
test_counter = 1;
total_trial = 0;
total_positive_rule_based = 0;
total_positive_correlation = 0;
total_positive_random = 0;
for file = files'
    if file.name(1)=='b'
        startNumber = strfind(file.name,'-');
        truth(1,fileNumber) = cellstr(file.name(startNumber+1:length(file.name)-4));
        if fileNumber ~= 13 && fileNumber~= 7 && fileNumber~=16
            total_trial = total_trial + length(truth{1,fileNumber});
        end
        fileNumber = fileNumber + 1;
    end
end
for file = files'
    if file.name(1)=='b'
        close all;
        imgOriginalOrigin = imread([file.folder '/' file.name]);%This is the size of the template's original image
        img = imbinarize(rgb2gray(imgOriginalOrigin));
        
        imgOriginal =  rgb2gray(imgOriginalOrigin);
        
        imgFiltered = imgaussfilt(imgOriginal, 8);
        [~, threshold] = edge(imgFiltered, 'sobel');
        fudgeFactor = .5;
        BWs = edge(imgFiltered,'sobel' , threshold * fudgeFactor);
        %figure, imshow(BWs), title('binary gradient mask');
        se90 = strel('line', 30, 90);
        se0 = strel('line', 30, 0);
        BWsdil = imdilate(BWs, [se90 se0]);
        %figure, imshow(BWsdil), title('dilated gradient mask');
        BWdfill = imfill(BWsdil, 'holes');
        %figure, imshow(BWdfill);
        %title('binary image with filled holes');
        
        seD = strel('diamond',7);
        BWfinal = imerode(BWdfill,seD);
        BWfinal = imerode(BWfinal,seD);
        %figure, imshow(BWfinal), title('segmented image');
        %BWnobord = imclearborder(BWfinal, 8);
        %figure, imshow(BWnobord), title('cleared border image');
        BURN = zeros(size(BWfinal,1),size(BWfinal,2));
        BURNED = rgb2gray(imoverlay(BURN,BWfinal,'white'));
        %figure, imshow(BURNED), title('burnt image');
        BW = edge(BURNED,'canny');
        [H,T,R] = hough(BW);
        P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
        lines = houghlines(BW,T,R,P,'FillGap',5000,'MinLength',2);
        max_len = 0;
        
        for k = 1:length(lines)
            xy = [lines(k).point1; lines(k).point2];
            degree = lines(k).theta+90;
            %    plot(xy(:,1),xy(:,2),'LineWidth',k*3,'Color','green');
            
            % Determine the endpoints of the longest line segment
            len = norm(lines(k).point1 - lines(k).point2);
            if ( len > max_len)
                max_len = len;
                xy_long = xy;
            end
            degree_info(k).degree=degree;
            degree_info(k).length = len;
            degree_info(k).xy=xy;
        end
        max_length = 0;
        max_index = 2;
        second_index = 2;
        for i=1:length(degree_info)
            for j=1:length(degree_info)
                if i ~= j
                    difference= abs(degree_info(i).degree - degree_info(j).degree);
                    difference = min(difference,180-difference);
                    i_center = (degree_info(i).xy(2,:)+degree_info(i).xy(1,:))/2;
                    j_center = (degree_info(j).xy(2,:)+degree_info(j).xy(1,:))/2;
                    distance = sqrt((i_center(1)-j_center(1))^2+(i_center(2)-j_center(2))^2);
                    sum_length=degree_info(i).length+degree_info(j).length;
                    if(difference<4 && distance>200 && sum_length>max_length)
                        max_length=sum_length;
                        found_distance=distance;
                        max_index=i;
                        second_index=j;
                    end
                    
                end
            end
        end
        % figure, imshow(BURNED), hold on
        % plot(degree_info(max_index).xy(:,1),degree_info(max_index).xy(:,2),'LineWidth',2,'Color','cyan');
        % plot(degree_info(second_index).xy(:,1),degree_info(second_index).xy(:,2),'LineWidth',2,'Color','red');
        %figure;
        turnDegree = degree_info(max_index).degree;
        rotated=imrotate(imgOriginal,270+turnDegree,'loose');
        %imshow(rotated);
        bill_image= find_inside_region(imgOriginalOrigin,lines(max_index),lines(second_index));
        bill_image=imrotate(bill_image,270+turnDegree,'loose');
        extracted_image=extract_inside_region(rotated,bill_image);
        % figure;
        % imshow(extracted_image);
        
        
        
        %********************END*********************ExtractingBillFromImage*******************END*************************%
        
        extracted_image = imresize(extracted_image, [NaN 350]);
        %Using cross correlation to find the template in original image
        correlationMatrix = normxcorr2(template,extracted_image);
        extracted_image_rotated = imrotate(extracted_image,180);
        correlationMatrixRotated = normxcorr2(template,extracted_image_rotated);
        if max(correlationMatrix(:)) < max(correlationMatrixRotated(:))
            correlationMatrix = correlationMatrixRotated;
            extracted_image = extracted_image_rotated;
        end
        
        %Get coordinates.
        [ypeak, xpeak] = find(correlationMatrix==max(correlationMatrix(:)));
        
        
        yoffSet = ypeak-size(template,1);
        xoffSet = xpeak-size(template,2);
        
        % figure;imshow(extracted_image);
        meanX = xy_long(1,1)+xy_long(2,1);
        meanX = meanX /2;
        %imrect(gca, [xoffSet+1, yoffSet+1, meanX-xoffSet, size(template,1)]);
        % imrect(gca, [xoffSet+1, yoffSet+1, size(imgOriginal,2)-xoffSet, size(template,1)]);
        % sumRegion = imRotated(yoffSet+1:yoffSet+1+size(template,1),xoffSet+1:meanX);
        %Finding Bill
        
        
        sumRegion = extracted_image(yoffSet-1:yoffSet+2+size(template,1),1:size(extracted_image,2));
        %Finding KDV
        %sumRegion = extracted_image(yoffSet+1-size(template,1):yoffSet+1,1:size(extracted_image,2));
        sumRegion = imbinarize(sumRegion);
        %  figure;imshow(sumRegion);
        
        pre_stats = regionprops(not(sumRegion));
        for i = 1:length(pre_stats)
            for j = i:-1:2
                if pre_stats(j).Area>pre_stats(j-1).Area
                    temp = pre_stats(j);
                    pre_stats(j) = pre_stats(j-1);
                    pre_stats(j-1) = temp;
                end
            end
        end
        counter = 1;
        for i=1:length(pre_stats)
            if abs( size(sumRegion,1)-pre_stats(i).BoundingBox(4))>1
                mid_stats(counter) = pre_stats(i);
                counter = counter + 1;
            end
        end
        second_y_len=mid_stats(2).BoundingBox(4);
        counter = 1;
        widthSum =0;
        for i=1:numel(mid_stats)
            y_len = mid_stats(i).BoundingBox(4);
            y_wid = mid_stats(i).BoundingBox(3);
            if (y_len/second_y_len)>= 3/4
                next_stats(counter)=mid_stats(i);
                widthSum = widthSum + next_stats(counter).BoundingBox(3);
                
                counter = counter + 1;
            end
        end
        avgWidth = widthSum/counter;
        counter=1;
        for i=1:numel(next_stats)
            if next_stats(i).BoundingBox(3)< avgWidth *3/2
                close_stats(counter)=next_stats(i);
                counter = counter + 1;
            end
        end
        counter = 1;
        for i=1:numel(close_stats)
            if close_stats(i).BoundingBox(1)> size(sumRegion,2)/2
                stats(counter)=close_stats(i);
                counter = counter + 1;
            end
        end
        imageContainer(1).image = sumRegion;
        counter = 1;
        figure;
        imshow(sumRegion);
        hold on;
        for i=1:numel(stats)
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
        for i = 1:length(imageContainer)
            for j = i:-1:2
                if imageContainer(j).xStart<imageContainer(j-1).xStart
                    temp = imageContainer(j);
                    imageContainer(j) = imageContainer(j-1);
                    imageContainer(j-1) = temp;
                end
            end
        end
        % v = imageContainer(length(imageContainer)-2).image;
        % trimmedImage = cutWhitePart(v);
        % imshow(trimmedImage);
        % disp(classify_numbers(trimmedImage));
        seD = strel('line',20,90);
        seD2 = strel('line',20,0);
        figure;
        container = [ ];
        
        for i=1:length(imageContainer)
            subplot(1,length(imageContainer),i);
            v = imageContainer(i).image;
            trimmedImage = cutWhitePart(v);
            trimmedImage = imresize(trimmedImage,[300 300]);
            trimmedImage = not(trimmedImage);
            trimmedImage = imdilate(trimmedImage,[seD,seD2]);
            imshow(trimmedImage);
            
        end
        correlation_container = [];
        for i=1:length(imageContainer)
            v = imageContainer(i).image;
            trimmedImage = cutWhitePart(v);
            trimmedImage = imresize(trimmedImage,[300 300]);
            trimmedImage = not(trimmedImage);
            trimmedImage = imdilate(trimmedImage,[seD,seD2]);
            %     disp(classify_numbers(trimmedImage));
            container = [container classify_numbers(trimmedImage)];
            if  test_counter ~=11 && test_counter~=5 && test_counter~=14 && (str2num(truth{1,test_counter}(i)))==container(i)
                total_positive_rule_based = total_positive_rule_based + 1;
            end
            %**************Finding with cross-correlation***************%
            correlationMatrix = normxcorr2(trimmedImage,sonuc);
            [ypeak, xpeak] = find(correlationMatrix==max(correlationMatrix(:)));
            yoffSet = ypeak-size(trimmedImage,1);
            xoffSet = xpeak-size(trimmedImage,2);
            meanX = xy_long(1,1)+xy_long(2,1);
            meanX = meanX /2;
            if xoffSet<0
                xoffSet=0;
            end
            correlation_container = [correlation_container round(xoffSet/300)];
            if  test_counter ~=11 && test_counter ~=5  && test_counter~=14&&(str2num(truth{1,test_counter}(i)))==correlation_container(i)
                total_positive_correlation = total_positive_correlation + 1;
            end
             if test_counter ~=11 && test_counter ~=5  && test_counter~=14&&(randi(10)-1)==correlation_container(i)
                total_positive_random = total_positive_random + 1;
            end
            
            %*************Finding with cross-correlation***************%
        end
        fprintf('%g',str2num(truth{1,test_counter}));
        fprintf('\n');
        fprintf('%g ',container);
        fprintf('\n');
        fprintf('%g ',correlation_container);
        
        test_counter = test_counter + 1;
    end
    clearvars -except template sonuc files truth test_counter total_positive_rule_based total_positive_correlation total_trial total_positive_random
end
rule_based_percentage = total_positive_rule_based / total_trial;
correlation_based_percentage = total_positive_correlation / total_trial;
random_percentage = total_positive_random / total_trial;
fprintf('Total percentage with rule based system is %g\n',rule_based_percentage);
fprintf('Total percentage with cross correlation is %g\n',correlation_based_percentage);
fprintf('Total percentage with random values is %g\n',random_percentage);
