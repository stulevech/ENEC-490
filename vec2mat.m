function [ matrix ] = vec2mat( vector, rows, columns )
%function that takes an input a time series vector, and converts it to a 
%2D matrix with a specified number of rows and columns

%this creates a matrix given a vector of some number row(s) and column(s)
%(one of those two values will be 1)
matrix = zeros(rows, columns);

%covers the possibility of it being both a row and column vector
%redundancy strengthens the code in this case

counter = 0;
for i = 1:columns
    for j = 1:rows
        counter = counter + 1;
        matrix(j,i) = vector(counter);
    end 
end 

%counter rotates through the possible indexable values of the vector, and
%assigns them to the matrix. Because vector(counter) indexes the value at a
%certain point this works

