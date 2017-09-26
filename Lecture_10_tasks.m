%Lecture10%

%Power plant can have 4 states: 2000 MW
%25% reduction 1500
%50% reduction 1000

data=xlsread('catawba_data.xlsx');

temps = data(:,4);
flows = data(:,5);

days=length(temps);

W = zeros(days,1); 
losses = zeros(days,1);

for i = 1:days
    
    W(i) = (33.3/(1+exp(.15*(16.9-temps(i)))) + 127/flows(i));
    
    if W(i) > 37 && W(i) <= 40
    losses(i) = .25*2000*24;
    elseif W(i) > 40 && W(i) <= 42
    losses(i) = .50*2000*24;
    elseif W(i) > 42
    losses(i) = 2000*24;
    end
        
end

losses_dollars = (losses*100)/1000;
%he plotted the losses in 1000's of dollars instead of alternative
%converts losses to thousands of dollars

annual_losses = zeros(41,1);

for i = 1:41
    annual_losses(i) = sum(losses_dollars((i-1)*365+1:(i-1)*365+365));
end

sorted_losses = sort(annual_losses);
idx = round(.95*41);
CVar = sorted_losses(idx)

%Do the same for climate data

climate_temps = data(:,4)+2; %the actual temps values are in farenheit but we're going to play with it and assume celsius
%flows = data(:,5);

log_flows = log(flows);
mu = mean(log_flows); %takes mean of every single element in the vector
sigma = std(log_flows); %standard deviation of every value
whitened_flows = (log_flows - mu)/(sigma); %standardizes that value

%add climate change
climate_mu = 0.9*mu;
climate_sigma = 1.2*sigma;

climate_log_flow = climate_mu + climate_sigma*whitened_flows;
climate_flows = exp(climate_log_flow);

%whitened flows is a vector between 0 and 1, a standard normal
%distribution. In matlab it is functionally the same idea as randn but with
%real data. We want to modify things in the format of 
%climate_mu + climate_sigma*whitened_flows = the climate_log_flow
%and so we need to just put that in exponential to get climate_flows

%days=length(temps);

%values further from mean are impacted a lot more by a multiplying factor
%of the standard deviation. means moving affects everything and std.
%deviation too, but affects things a lot more that are farther from mean.
%Extreme values become moreso. 

climate_W = zeros(days,1); 
climate_losses = zeros(days,1);

for i = 1:days
    
    W(i) = (33.3/(1+exp(.15*(16.9-climate_temps(i)))) + 127/climate_flows(i));
    
    if W(i) > 37 && W(i) <= 40
    climate_losses(i) = .25*2000*24;
    elseif W(i) > 40 && W(i) <= 42
    climate_losses(i) = .50*2000*24;
    elseif W(i) > 42
    climate_losses(i) = 2000*24;
    end
        
end

climate_losses_dollars = (climate_losses*100)/1000;
%he plotted the losses in 1000's of dollars instead of alternative
%converts losses to thousands of dollars

climate_annual_losses = zeros(41,1);

for i = 1:41
    climate_annual_losses(i) = sum(climate_losses_dollars((i-1)*365+1:(i-1)*365+365));
end

climate_sorted_losses = sort(climate_annual_losses);
idx = round(.95*41);
CVar_CC = climate_sorted_losses(idx) %this is just the point where these values exceed 95% in terms of rarity

%creating the bins
a = ceil(max(annual_losses)/100000)*100000;
edges = [0:10000:a]; 

figure;
hold on
histogram(annual_losses,edges)
histogram(climate_annual_losses,edges)
xlabel('Losses (thousands of dollars)');
ylabel('Event Frequency');
title('Annual Financial Losses from water temp shutdowns');
legend('1970-2010','Climate change');
hold off

sorted_losses;
climate_sorted_losses; %for number verification

%From the CVar and CCVar values we can determine that the each year the
%utility has at least a 5% chance of losing 61200 thousand under normal
%circumstances and a 5% chance of losing 373200 thousand under climate
%change circumstances.




