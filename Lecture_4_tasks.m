%Lecture 4 tasks%

[data] = xlsread('monthly_demandNC');

%this is total monthly NC electricity demand across all sectors, 1998-2015
%converts data set to a 12 row, 18 column matrix for 18 full years
annual = annual_profile(data);

percent_change = zeros(12,17);
for i = 1:12
    for j = 1:17
        percent_change(i,j) = annual(i,j+1)/annual(i,j);
    end 
end 

figure;
plot(percent_change);
title('Year-over-Year changes in monthly NC electricity demand');
xlabel('Years since 1998');
ylabel('Factor of change');
legend('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');

%Determine fraction of electricity demand allocatable to each month
%determine total electricity demand for each year
annual_demand = sum(annual(:,:));
calendar_month_fraction = zeros(12,18);
for i = 1:12
    for j = 1:18
        calendar_month_fraction(i,j) = annual(i,j)/annual_demand(j);
    end 
end 

%plot change by month for each year 1998-2015
figure;
plot(calendar_month_fraction);
title('Month-over-Month changes in NC electricity demand, 1998-2015');
xlabel('Month');
ylabel('Fraction of total electricity consumption');
legend('1998','1999','2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015');

%plot change over the years 1998-2015, for each month
figure;
plot(calendar_month_fraction');
title('Annual changes in NC electricity demand by month, 1998-2015');
xlabel('Years elapsed since 1998');
ylabel('Fraction of total electricity consumption');
legend( 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');

%Question 5: Bootstrapping

%rand number formula r = a + (b-a).*rand(N,1) on interval (a,b)
bootstrap = random_sample(1,length(data),120,1);
bootstrap2 = vec2mat(bootstrap,10,12);
%bootstrap = vec2mat(bootstrap(10,12);
%generates a random index from one to the number of months contained in the
%data set, and arranges these indices in a 120 row column vector, which is
%the number of months that will pass over the next 10 years

%creation and assignment of randomly generated monthly indices
bootstrap_dist = zeros(10,12);
for i = 1:length(bootstrap2(:,1))
    for j = 1:length(bootstrap2(1,:))
    bootstrap_dist(i,j) = data(bootstrap2(i,j));
    end 
end 

%bootstrap dist
figure;
subplot(2,2,1);
plot(bootstrap_dist);
xlabel('Year');
ylabel('Demand (MWh)');

%autocorrelation
subplot(2,2,2);
plot(autocorr(bootstrap_dist));
xlabel('Months');
ylabel('Autocorrelation');


%Monte Carlo Analysis%

stats = monthly_stats(data);
monte_carlo_sample = zeros(120,1);

for i = 1:10
    for j = 1:12
    monte_carlo_sample((i-1)*12+j) = stats(j,1) + stats(j,2)*randn(1);
    end
end

%Monte Carlo Sample
subplot(2,2,3);
plot(monte_carlo_sample);
xlabel('Year');
ylabel('Demand (MWh)');

%autocorrelation
subplot(2,2,4);
autocorr(monte_carlo_sample);
xlabel('Months');
ylabel('Autocorrelation');

%Historical autocorrelation
vector = mat2vec(data);
figure;
autocorr(data);
xlabel('Months');
ylabel('Autocorrelation');

%the methods perform decidedly at less than the accuracy which would be
%desired; there appears to be another source of interference within the
%dataset


%Problem Solving
counter = 0;
for k = 1:500
    counter = counter + 10*k.^2 - 4*k + 2;
    if counter > 20000
        break
    end 
end 
k
%the break command is highly useful; it basically says stop iterating. Can
%be used in if statements, and apparently also for 'for' loops

%this is the philosophy for while loop
k2 = 1;
counter_two = 0;
while counter_two < 20000
      counter_two = counter_two + 10*k2.^2 - 4*k2 + 2;
      k2 = k2 + 1;
end 
k2

%Problem 3 
price = [19,18,22,21,25,19,17,21,27,29];
shares = 1000;
start_worth = price(1)*shares;
total_amount_buying = 0;
total_amount_selling = 0;

for i = 1:length(price)
    if price(i) < 20
        shares = shares + 100;        
        total_amount_buying = total_amount_buying + price(i)*100;        
    elseif price(i) > 25 
        shares = shares - 100;        
        total_amount_selling = total_amount_selling + price(i)*100;       
    end 
end 
shares
total_amount_buying
total_amount_selling
end_wealth = total_amount_selling - total_amount_buying + shares*price(10)
net_change = end_wealth - start_worth









        
