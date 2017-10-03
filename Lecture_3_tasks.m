%Lecture 3 tasks%

%Functions-- part 1%

[data text combined] = xlsread('henry_hub_97_17.xls','Data 1','B4:B251');

%invokes annual profile and converts henry hub data to format
annual_hub = annual_profile(data);
% clips off 2017. So this is 1997-2016.
%counts the number of years, to be sure. This is 20 years of data
tot_years = length(annual_hub(1,:));  
%gets us the years just since 2008 (the 12th year from january 1997)
post_2008 = annual_hub(:,12:20);

%figure;
%plot(post_2008)
%xlabel('Month of the year');
%ylabel('Henry Hub NG Price (Dollars per Million Btu)');
%legend('2008','2009','2010','2011','2012','2013','2014','2015','2016')


%Statistics-- part 2%

%mean and standard deviation for each month, 2008 to present
stats = monthly_stats(post_2008);

%format for this y = stdev*randn(# samples, degree of variance) + mean
apr = stats(4,2)*randn(1000,1) + stats(4,1)
jan = stats(1,2)*randn(1000,1) + stats(1,1)

figure;
hold on
histogram(apr)
histogram(jan)
title('January and April Natural Gas Prices')

%January has a much larger peak than April, although the shape of each
%invidiual section is comparable. The curves are comparable, but the
%magnitude of the mean is greater in January by quite a bit. In fact, April
%can actually completely fit inside January


%Problem Solving%

%1. Hemispherical tank

%radius r, height h, hemispherical top
%cylinder cost $400 / m2
%hemispherical cost $600 / m2

%range acceptable volumetric requirement 0:10,000
%maximum height allowed 1000m
%frank the tank function that takes an input value for volumetric
%requirement and exports r and h values which minimize cost














