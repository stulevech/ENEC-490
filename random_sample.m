function [ selected_sample ] = random_sample(lower_bound,upper_bound, rows, columns)
%rand number formula r = a + (b-a).*rand(N,1) on interval (a,b)
selected_sample = ceil(lower_bound + (upper_bound-lower_bound).*rand(rows, columns));
end

