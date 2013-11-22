clear;

fid = fopen('iris.data', 'r');
A = textscan(fid, '%f,%f,%f,%f,%s');
fclose(fid);
temp = zeros(1, 150);
for i=1:150
    if strcmp(A{5}(i),'Iris-setosa')
        temp(i) = 1;
    elseif strcmp(A{5}(i),'Iris-versicolor')
        temp(i) = 2;
    else
        temp(i) = 3;
    end
end
LABELIRIS = temp;
DATAIRIS = zeros(4,150);
for i=1:150
    DATAIRIS(1,i) = A{1}(i);
    DATAIRIS(2,i) = A{2}(i);
    DATAIRIS(3,i) = A{3}(i);
    DATAIRIS(4,i) = A{4}(i);
end
save('irisdata', 'DATAIRIS');
save('irislabel', 'LABELIRIS');