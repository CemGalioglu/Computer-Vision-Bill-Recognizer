function [trimmedImage] = cutWhiteSide(image)
%We are calculating the not of the image
%Then we are cutting the columns left to right until we find a column which
%has at least one 1 in it
sums = sum (not(image));
elementx = 0;
counter = 0;
while elementx == 0
    counter = counter + 1;
    elementx =  sums(counter);
end
trimmedImage =  image(:,counter : size(image,2));