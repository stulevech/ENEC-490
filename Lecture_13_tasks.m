%%Lecture 13%%

%Read electricity demand data
data = csvread('hourly-day-ahead-bid-data-2015.csv',5,1);
v = mat2vec(data);

%winter
figure;
autocorr(v(1:1200));

%summer
figure;
autocorr(v(4000:5199));

%fall
figure;
autocorr(v(6000:7200));


peak_demand = zeros(365,1);
for i = 1:365
    peak_demand(i,1) = max(data(i,:));
end 

%not sure what is being specified in the additional conditions section
%can't do more until we install the autocorr toolbox
%autocorr(peak_demand);

%Question 5: Differencing%

%we'll have a 364 period vector here; we'll have one less value in our
%final timeseries
difference = zeros(364,1);
for i = 1:364
    difference(i,1) = peak_demand(i+1,1)- peak_demand(i,1);
end 

figure;
plot(difference)

%there doesn't really appear to be a time of year with greater volatility
%than the others.

%Question 6: Data smoother%
smoothed = zeros(335,1);
for i = 16:350
    smoothed(i-15,1)= mean(peak_demand(i-15:i+15));
end

figure;
hold on
plot(peak_demand(16:350,1));
plot(smoothed);
hold off

%Question 7%

residual = (peak_demand(16:350) - smoothed(:,1));

figure;
plot(residual);

autocorr(residual)



