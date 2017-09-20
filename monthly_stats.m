function [ matrix ] = monthly_stats(data)
%function that describes the mean and standard deviation for a monthly dataset over i years

%create empty matrix that is 12 rows by 2 columns, one for mean one for stdev
matrix = zeros(12,2);

for i = 1:12
    matrix(i,1) = mean(data(i,:));
    matrix(i,2) = std(data(i,:));
end 

