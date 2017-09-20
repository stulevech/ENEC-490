function [ matrix ] = annual_profile(data)
%function that transforms a column vector into a 12 row matrix where
%each row is one month and each column is one year. Initial data must be in
%months

num_data_points = length(data);

num_years = floor(num_data_points/12);

%create empty matrix that is 12 rows by 'years' # of columns
matrix = zeros(12,years);

for i = 1:num_years
    for j = 1:12
        matrix(j,i) = data((i-1)*12+j);
    end
end

end

%so as long as we're looking for an output that has months in a year, this
%is a useful function. Months are required for the input format. 

%Example%
%say data has length 57 in a column vector
%57/12 is 4, and 9 months are left over. cutoff by the floor function
%years would be 4
%we create a matrix that is 12 rows and 4 columns
%for one to 4 years-- i is columns
%for one to 12 months-- j is rows, this gets iterated first

%applies the first value of data to first row, first column value of
%matrix, and then 2nd value of data to second row, first column value.
