function [ vector] = mat2vec( data )
%function that converts a matrix (input arg data) to a column vector
%converts matrix ('data' is placeholder) to column vector 'vector'

%size function determines the number of rows and columns
%rows and columns are the output arguments for the size of the matrix;
[rows,columns] = size(data);
%vector begins as a column vector that is as long as the matrix has cells
vector = zeros(rows*columns,1);

for i = 1:rows
    %for each row of data and all the columns, we assign to vector
    %has to do with extracting the value from each column within the row
    vector((i-1)*columns+1:(i-1)*columns+columns) = data(i,:);        
end

