imread('sampleBills/billEleven.jpg');
result=[];
for i=0:9
    name = ['sampleBills/' num2str(i) '.jpg'];
    image = imread(name);
    result=[result image];
end
imwrite(result,'sonuc.jpg');