%Lecture11%

%what we can gather from plotting the residuals is that relationship
%between heating and cooling demand and day of the year is a little bit
%different depending on the kind of season we're working with.

%another approach might be to plot the monthly situation; this model will
%be for us to predict demand on cooling degree days or heating degree days.
%useful for a utility, for instance

%Beta values are our coefficients; proceed in order columns of X. 
%first beta value is what we map into column of ones; that will be our
%baseload demand. Cooling degree days follow that, and heating degree days
%are our third beta value. 

% temp_demand contains an average daily temperature (F), day of week, and
% that day's demand in MWH, presumably state-wide.
t_data = xlsread('temp_demand.xlsx','training');
v_data = xlsread('temp_demand.xlsx','validation','A2:C1279');
t_temps = t_data(:,1);
t_demand = t_data(:,3);
v_temps = v_data(:,1);
v_demand = v_data(:,3);

%defines the conditions by which heating and cooling degree day functions
%are defined
t_CDD = max(t_temps - 65,0);
t_HDD = max(65 - t_temps,0);
v_CDD = max(v_temps - 65,0);
v_HDD = max(65 - v_temps,0);

%creates a column vector that is the same length as other columns and
%concatenates them together as a matrix X. The ones column will become the
%intercept at a later point

X = [ones(length(t_CDD),1) t_CDD t_HDD];

%defines the output arguments of the input function X (a series of X
%values) and t_demand (which is the electricity demand on a given day with
%a given temperature.) HDD and CDD are our independent variables.

[BETA,SIGMA,RESID]=mvregress(X,t_demand);

%mvregress Multivariate regression with missing data.
    %[BETA,SIGMA,RESID]=mvregress(X,Y) performs multivariate regression of
    %the multivariate observations in the N-by-D matrix Y on the predictor
    %variables in X, and returns a P-by-1 column vector BETA of coefficient
    %estimates, a D-by-D matrix SIGMA of the estimated covariance of Y, and an
    %N-by-D matrix RESID of residuals.  NaN values in X or Y are taken to be
    %missing.  Observations with missing values in X are ignored.  Missing
    %values in Y are handled according to the value of the 'algorithm'
    %parameter described below.
    
    %RESID is differences between conditionally inputted y-values and
    %estimated y-values.
    
%Question 3
predicted = BETA(1)*ones(length(v_CDD),1) + v_CDD*BETA(2) + v_HDD*BETA(3);
    %creates a prediction model to test the quality of our fit
    %we can see based on our BETA values that each CDD has roughly 3 times the
    %electricity demand impact of the HDD values. 

    %so this step is creating an estimation "predicted" based on the coefficients we
    %derived from the actual data; we're adding up the sum of these terms

    %the point of validation is to test the goodness of a fit; to make sure our
    %model is accurate in more instances than just that one.

figure;
scatter(predicted,v_demand);
title('Predicted and Observed Values','FontSize',14);
xlabel('Predicted Values','FontSize', 14);
ylabel('Validation Observed Values','FontSize',14);
%plots a scatter of the estimation model (simulated) and validation data
%(observed). %This order corresponds to what we did in the previous scatter

%Question 4%
SSE = 0;
for i = 1:length(v_demand)
    SSE = SSE + (v_demand(i)- predicted(i)).^2;
end 

SST = 0;
for i = 1:length(v_demand)
    SST = SST + (v_demand(i)- mean(v_demand)).^2;
end 

R_squared = 1 - (SSE/SST)

%this could all have been done without looping also, because we're not
%selecting bits or parts of the data based on its content, we're working on
%all of it. If we just defined a variable to be v_demand - predicted we
%would get a new matrix and we could square that, for instance. 

%our R-squared value appears correct here.

%Question 5

RMSE = sqrt(SSE./length(v_demand))

%Question 6

figure;
scatter(v_demand, predicted-v_demand);
title('Residuals vs. Observed Demand', 'FontSize',14);
xlabel('Validation Observed Demand','FontSize',14); 
ylabel('Validation Residuals','FontSize',14);

%heteroskedasticity means that the variance of a variable is not uniform
%across the domain of values it represents; in other words y might vary
%less when x is small and more when it is large, as one example.

%it might be heteroskedastic in this case; data points are clustered very
%heavily near the right end of the predicted approximation.












