function [a,b,c] = find_line_function(line)

x1 = line.point1(2);
y1 = line.point1(1);
x2 = line.point2(2);
y2 = line.point2(1);

a = x2 - x1;
b = y2 - y1;
c = y1*(x2-x1) - x1*(y2-y1);
end






