%Lecture 12%

%This is a problem about estimating peak demand on the utility's grid in
%2020. We are determining coefficients using 2000-2008 data, validating it
%using 2008-2015 data, and extrapolating that out to 2020 max demand;

%computationally the decision is made about a new plant given statistical
%outcomes related to the utility's reserve margin, which we can calculate
%knowing total capacity and peak demand.

data=xlsread('peak_forecasting.xlsx','RegressionData');
training = data(1:9,:);
validation = data(10:length(data),:);

%defines our covariates and our output data; by knowing independent
%variables and respective Y outcomes, we can identify the coefficients
Y = training(:,2);
X = [ ones(length(training),1) training(:,3:end) ];
%can apparently issue the command 'end'; this would be ommitted in python

[BETA] = mvregress(X,Y); %unlike Lecture 11, in this case we just want 
%to take the coefficient outputs and put them back in in the predicted
%function

BETA;
%this time we end up with 5 output values; one is the y-intercept and the
%others are the coefficients for economic index, population, per capita
%consumption and the max average daily temperature (F)

%writing the predictive model using our newly determined coefficients
%returns predicted values for the years 2009-2015 (7 years)
predicted = BETA(1) + BETA(2)*validation(:,3) + BETA(3)*validation(:,4) + BETA(4)*validation(:,5) + BETA(5)*validation(:,6);

%RMSE test to assess the model's viability
observed = validation(:,2);

residuals = observed - predicted;

RMSE = sqrt(mean((residuals).^2)); %could also be written as sqrt((sum((residuals).^2)/length(residuals))
RMSE; %~157, which is apparently correct

%check a scatterplot to visualize accuracy as well
scatter(predicted,observed);
%appears to be a plausible trend for our fit

%we can't do the 2020 predictions just yet because we need 2020 parameters
%economic index, population, and consumption metric can come from estimates

predictions = xlsread('peak_forecasting.xlsx','Predictions');
hist_temps = xlsread('peak_forecasting.xlsx','HistoricalTemps');

%max daily temperature we'll calculate and simulate from a monte carlo probability distribution
%for the last 66 years (total of 24090 daily high temps). 

%reshape our data into a yearly matrix
years = floor(length(hist_temps)/365);
yearly_matrix = vec2mat(hist_temps(:,2), 365, years);
%think we need to do it this way because it will fill in values by column
%and then by row. 
%update: this is how it should be done. In the future, can test these
%things

%determine peak daily values by year

%max(yearly_matrix(1

for i = 1:years 
    hist_peak(i) = max(yearly_matrix(:,i));
end    

%determine parameters of our historical temp values
para_mean = mean(hist_peak);
para_std = std(hist_peak);

%monte carlo simulations; generates 1000 possible probabilities for summer
%2020 maximums based on historical precedents. Made a compromise here with
%exclusion of system memory
peak_temp_2020 = para_mean + para_std.*randn(1000,1);

histogram(peak_temp_2020);
title('Historical Peak Summer Daily Temperatures, 1947-2012','FontSize',14);
xlabel('Highest Average Daily Temperature (F)','FontSize',14);
ylabel('Frequency','FontSize',14);
%the distribution does look normalized; does not need transformation

%creates a distribution of 1000 possibilities for the peak load in 2020;
%distribution is sum of probabilities of all other variables and the max
%temp approximation; a 1000 row, 1column vector
peak_load_2020 = BETA(1) + BETA(2)*predictions(5,2) + BETA(3)*predictions(5,3) + BETA(4)*predictions(5,4) + BETA(5)*peak_temp_2020;

figure;
histogram(peak_load_2020);
title('2020 Peak Summer Load Possible Outcomes','FontSize',14);
xlabel('Maximum Demand (MW)','FontSize',14);
ylabel('Frequency','FontSize',14);

%now convert these peak load values into a reserve margin distribution as
%well
%current capacity
current_capacity = 25000; %MW

%reserve margin dist
reserve_margin = ((current_capacity - peak_load_2020)./current_capacity)*100;

%reserve margin operation determines the percentage of capacity that is not
%actively in-use at a given time; if the percentage of capacity allocated
%to reserve margin falls below a given point, it will be necessary to build
%another power plant to supply that need.

%histogram of % capacity going to reserve margin
figure;
histogram(reserve_margin);
title('Probable Reserve Margin in 2020','FontSize',14);
xlabel('Reserve Percentage of Capacity','FontSize',14);
ylabel('Frequency','FontSize',14);
%visually we can clearly see that most of the probable outcomes (as much as
%80%) fall below the 15% minimum reserve threshold.

%determine numerically if the new power plant is needed
(sum(reserve_margin < 15)) >= .25

%a new plant will be needed by 2020. Hooray for peak load forecasting!













