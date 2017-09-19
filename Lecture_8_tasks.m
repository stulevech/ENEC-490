%Lecture8%

%import relevant data 
[data,text,combined] = xlsread('N3045US3m','Data 1','A4:B183');

%histogram of 2002-2016 gas price data
histogram(data); 

%log transformation
transformed_data = log(data);

%histogram of log transformed data
histogram(transformed_data); 
%xlabel('Log Natural Gas Price ($/MMBtu)','FontSize',14);
%ylabel('Frequency','FontSize',14);

%number of years in dataset
years = length(data)/12;

%convert to 12 x N matrix
monthly_matrix = vec2mat(transformed_data,12,years);

% mean and standard deviation of log-transformed data by month
stats = zeros(12,2);
for i = 1:12
    stats(i,1) = mean(monthly_matrix(i,:));
    stats(i,2) = std(monthly_matrix(i,:));
end

%identify months
months = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

figure; 
hold on;
%bin 'edges'
edges = 0:0.5:30;

%for each of these, changes either the "max" or "min," or the column that
%is searched (changes whether we're looking at mean or standard deviation)
%highest mean
idx = find(stats(:,1) == max(stats(:,1)));
sample = stats(idx,1) + stats(idx,2)*randn(1000,1);
back_transformed = exp(sample);
histogram(back_transformed,edges);
label_1 = strcat(months{idx},' - Highest Mean');

%lowest mean(with same variable names)
idx = find(stats(:,1) == min(stats(:,1)));
sample = stats(idx,1) + stats(idx,2)*randn(1000,1);
back_transformed = exp(sample);
histogram(back_transformed,edges);
label_2 = strcat(months{idx},' - Lowest Mean');

%largest standard deviation
idx = find(stats(:,2) == max(stats(:,2)));
sample = stats(idx,1) + stats(idx,2)*randn(1000,1);
back_transformed = exp(sample);
histogram(back_transformed,edges);
label_3 = strcat(months{idx},' - Highest Standard Deviation');

%smallest standard deviation
idx = find(stats(:,2) == min(stats(:,2)));
sample = stats(idx,1) + stats(idx,2)*randn(1000,1);
back_transformed = exp(sample);
histogram(back_transformed,edges);
label_4 = strcat(months{idx},' - Lowest Standard Deviation');

%label our figures, create a legend, and create labels for legend
title('Frequency of Natural Gas Prices (2002-16)')
xlabel('Natural Gas Price ($/MMBtu)')
ylabel('Frequency')
legend(label_1, label_2, label_3, label_4)

hold off

%creates a boxplot diagram. We apply an apostrophe at the end of
%monthly_matrix to rotate the diagram because the boxplot function defaults
%to zipping down columns. We'll apply a label to each month and then label
%a graph as well.
figure; 
boxplot(monthly_matrix','Labels',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
xlabel('Months','FontSize',14)
ylabel('Monthly Natural Gas Prices ($/ft^3)','FontSize',14)

%make sure to clear matlab workspace periodically! We can end up with weird
%bugs with old labels we have defined and that sort of thing

%help feature is pretty useful for understanding what to do in matlab 