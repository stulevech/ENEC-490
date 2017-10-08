%Lecture 6%

data_2014 = csvread('hourly-day-ahead-bid-data-2014.csv',5,1);
temps = csvread('tempdata.csv');
temps = temps(:,2);

%creates a vector of hourly data
data = mat2vec(data_2014);

%calculates peak hourly demand for each day of the year
peak_demand = zeros(365,1);
for i = 1:365
    peak_demand(i) = max(data_2014(i,:))/1000; 
end %adding the /1000 converts from MWH to GWH for question 5

%creates the vector juxtaposing temperature and peak electric demand per
%day
temp_peak = zeros(365,3);
temp_peak(:,1) = temps;
temp_peak(:,2) = peak_demand;

%another way to do this is to place column or row vectors together within
%brackets (no commas) and assign that to a new variable
together = [temps peak_demand];
together == temp_peak(:,1:2); %returns ones for every cell
%and we could do the same for k_cluster as well. i.e. temp_peak = [together
%k_cluster ]. Probably would position these so that placement of the final
%columns is how we want it; concatenation! Thats what these brackets do

%aligning
k_cluster = kmeans(temp_peak,3);
temp_peak(:,3) = k_cluster;

%sorts the values based on their k-means cluster partition
sorted = sortrows(temp_peak,3);

%what is the best way to select just the rows we want. Slice the data? A
%for loop, if statements, or the find function or simply array slicing are
%all ideas

%the find operator returns indices; the for loop is for definite matrices
%of length we already know

%since we just want a subset of the existing data, its best to just do a
%double index where we index it with itself under a certain condition
first_cluster = sorted(sorted(:,3) == 1, 1:2);
%this is all we needed to do with that

second_cluster =  sorted(sorted(:,3) == 2, 1:2);
third_cluster = sorted(sorted(:,3) == 3, 1:2);    

%a find operator, a for loop, and an if statement are all inappropriate in this case
%because we don't really know the length of the final output matrix; it could be computed more easily
%find just deals with values and we don't want this. 

figure;
hold on
scatter(first_cluster(:,1), first_cluster(:,2), 'red'); 
  %plots first cluster in red
scatter(second_cluster(:,1), second_cluster(:,2), 'blue'); 
  %plots second cluster in blue
scatter(third_cluster(:,1), third_cluster(:,2), 'green'); 
  %plots third cluster in green 
title('Clustered Average Temp and Peak Electricity Demand')
xlabel('Daily Average Temperature')
ylabel('Peak Electricity Demand, GWH')
legend('Cluster one','Cluster two','Cluster three')
hold off

%temperature is behaving sort of bizarre and not the way we would want. It
%is cluserting not by max or minimum demand, but horizontally (and some
%clusters are spread across the two ends of the u-curve!)
  
    %scatter model format for arguments    
    %scatter(sorted(:,1),sorted(:,2),'red','filled')
    
    %scatter takes input arguments vector X, vector Y, S, and C. S refers to
    %specifications for the spheres. C refers to the sphere colors; at end of
    %all of these, we also have the option to place a comma and the word
    %'filled' to fill in the spheres

%realization
%so we could have used the if statement conditions or the foor loop or find
%but we just needed to realize that self-indexing ability to retrieve a
%subset

%Question 5

%we go back and reduce the magnitude of the peak electricity demand data so
%they are the same order of magnitude. Dividing by 1000 or to get elec.
%demand in GWH vs. MWH seems to be a solution that makes sense

%the result is different because there were 1000's of values on the y-axis
%and just 10's of values on the x-axis

%also I'm not sure why, but the colors change sometimes; I don't think that
%is a flaw just a result of the way the kmeans generator takes place


%Time series data

jan = data_2014(1:31,:);
apr = data_2014(90:120,:);
jul = data_2014(182:182+31,:);

%monthly plots of hourly electricity demand, averaged by day (i.e. the
%average electricity demand each hour over the whole month. average by
%hour

figure;
plot(mean(jan)./1000)
title('January Hourly Electricity Demand')
xlabel('Hour of the day')
ylabel('Peak Electricity Demand, GWH')

figure;
plot(mean(apr)./1000)
title('April Hourly Electricity Demand')
xlabel('Hour of the day')
ylabel('Peak Electricity Demand, GWH')

figure;
plot(mean(jul)./1000)
title('July Hourly Electricity Demand')
xlabel('Hour of the day')
ylabel('Peak Electricity Demand, GWH')

data_2014(1:7:365); 
%here is how we step through a function
%matlab is smart enough to know that if we enter either 24 or 365 it will
%iterate in that respective direction. I would imagine if we did
%length(data_2014) it would also know how to respond there

%column vector, day of the week
%assign each day to a value
day_of_week = zeros(365,1);
day_of_week(1:7:365) = 4;
day_of_week(2:7:365) = 5;
day_of_week(3:7:365) = 6;
day_of_week(4:7:365) = 7;
day_of_week(5:7:365) = 1;
day_of_week(6:7:365) = 2;
day_of_week(7:7:365) = 3;

%combines
weekly = [peak_demand day_of_week];
%sorts the rows according to day of the week
sorted = sortrows(weekly, 2);
SUN = sorted(sorted(:,2) == 1);
MON = sorted(sorted(:,2) == 2);
TUE = sorted(sorted(:,2) == 3);
WED = sorted(sorted(:,2) == 4);
THU = sorted(sorted(:,2) == 5);
FRI = sorted(sorted(:,2) == 6);
SAT = sorted(sorted(:,2) == 7);

%alternatively could have SUN = sorted(sorted(:,2)==1,1); with the extra ',1' specification 
%assigns a variable which is the day of the week name to the sorted subset
%of the data
%by doing this we didn't actually need the sorting part; we did need to
%assign the values to 1-7 values though in order to get the data organized
%in a format we can classify it for our boxplot though

%this is how data is best organized for a boxplot
%week = [SUN MON TUE WED THU FRI SAT]
%this can't be done initially without making sure all column vectors are
%same length
length(SUN);
length(MON);
length(TUE);
length(WED);
length(THU);
length(FRI);
length(SAT);
%can see there are 53 wednesdays. to clip the last one off, we do
WED(53) = [];
length(WED);
%this is how we can remove data of a given vector cleanly. Assigning it
%empty automatically reduces the matrix size in matlab

%WED(50) = [] can assign values internal to the matrix to be blank as well

week = [SUN MON TUE WED THU FRI SAT];

figure;
boxplot(week,'Labels',{'SUN','MON','TUE','WED','THU','FRI','SAT'})
xlabel('Day of the Week','FontSize',14);
ylabel('Peak Demand,(GWH)','FontSize',14);
title('Demand Distribution by Day of Week','FontSize',14);
%boxplots have to be a single matrix. Can't run a bunch of column vectors
%but could concatenate them and do that pretty easily
%Label specification works like that for boxplots, or else they are
%indicated by numbers
%wonder if this could be extended to other things

%figure, by itself, creates a new figure window
%figure;
%plot(mean(jan)./1000,'Labels',{'Fish','Apple','Banana'})
%there is not a labels property on the line graph class

%figure;
%plot(mean(jan)./1000);
%if we don't add figure; in front of each plot, the last one will supplant
%all the others and become the only figure visible


%CONCLUSION%

%it looks like weekly electricity demand is slightly higher than the
%weekend-days.







    
    




 