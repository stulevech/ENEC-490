%Lecture 5 tasks%

%Read electricity demand data
data = csvread('hourly-day-ahead-bid-data-2015.csv',5,1);
data2 = csvread('bizarre_data.csv');

monthly_demand = mat2vec(data);

%figure;
plot(data2);
%it looks like there are some values that are very large, some values that
%are zero, and maybe some discontinuities?

data3 = pre_processor(data2, length(data2), 1);

%figure;
plot(data3);

%the unusual data point is simply a consequence of having a relatively very
%large value that is far away from the mean of its particular nearby values
%by not that far off of the mean or devitation for the entire set. We can
%account for these by at least theoretically comparing it to its nearby
%values but that also doesn't always work.

%Identifying Outlier Values
%identifies sets of values above 130000
high_values = find(data3 > 130000);
%idenitifies those values which are also above 7000; not sure how that's
%being indexed
indices = high_values(find(high_values > 7000));
day = floor(indices/24);
hour = indices - day*24;
answer = [hour day];
%it looks like our data point of interest happened at 2 am on the 305th day
%of the year (Late Oct/Early Nov?) Halloween?

%histogram
figure;
histogram(data3)

%qqplot
figure;
qqplot(data3)
xlabel('Theoretical Normal Quantiles');
ylabel('Empirical Data Normal Quantiles');

%it looks like the data has a bit of a tail-- which might also explain why
%the qqplot data is sligthly off-center.

%log transformation%
%take the log() of each line of data in data3. This is the natural log
%function in matlab
log_data = log(data3);
figure;
histogram(log_data);
xlabel('log_demand (MWH)');
ylabel('Frequency');

%retest using qqplot
figure;
qqplot(log_data);
xlabel('Theoretical Normal Quantiles');
ylabel('Empirical Data Normal Quantiles');
%this data looks both pretty normal and pretty centered on the qqplot test

%classifying weird point
%z score
mu = mean(log_data);
sigma = std(log_data);
z_score = (log_data(indices) - mu)/sigma

%the z-score or number of std deviations from the mean for the weird point
%is 2.63. That is a pretty unlikely occurence.

%outlier test
%it does not seem reasonable, however, that this point could not have
%occurred at this time, although it is locally unlikely to have occurred.
%It's not really that much different given the value of the mean and the
%high demand during the summer months of the year

%a moving window assessment would be a better way. The way we've defined a
%statistical outlier is the moving window test, where the value must be
%greater than 3 standard deviations above the mean
days = length(log_data)/24;
for i = 16:days-15
    moving_mean = mean(log_data(i-15:i+15));
    moving_std = std(log_data(i-15:i+15));
    outliers(i) = log_data(i) >= moving_mean + 3*moving_std | log_data(i) <= moving_mean - 3*moving_std;
end 
%creates a moving calculator window which looks 15 days into the past and
%future for each data point, compares the value of each to the mean and
%standard deviation, and returns values 0 or 1 into the outliers() matrix
%depending on if they are statistical outliers with values >= +/- 3
%standard deviations

%interesting code in that it creates the outliers matrix as it goes,
%expanding it at each iteration of the moving window. Another approach
%might be to define a window size in the future beforehand

find(outliers > 0)
%we did not locate any statistical outliers. This makes sense given that
%our z-score previously was 2.63 std deviations for the weird point, which
%is  not greater than 3 stdev's.

peak_demand = zeros(365,1);
for i = 1:365
    peak_demand(i) = max(log_data(i,:));
end 
peak_demand;

temps = csvread('tempdata.csv');
temps = temps(:,2);
figure;
scatter(temps, peak_demand);






    
    
    
    












