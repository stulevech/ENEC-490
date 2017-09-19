%% Lecture 2 Problem Set %% 

%Basic Matlab Operations%

%Question 1%
random_function = cos(0):0.02:log10(100);
%returns the vector length
 length(random_function)
 %indexes the 25th value in the vector
 random_function(25)
 
 %Question 2%
 %generates a 50x50 matrix of uniformly distributed values from 1 to 500.
 big_matrix = 500*rand(50,50);
 %returns a 1 or 0 for each value in the matrix if the value is > 400
 %there is probably a more elegant way to do this part of the solution
 big_matrix > 400

 
 %Question 3%
 %generates the desired tables plus a desired graph
 M = zeros(100,2);
 M(:,1) = 1000*rand(100,1);
 x = M(:,1);
 M(:,2) = 0.3*x.^3 -2*x.^2 + 200*x;
 y = M(:,2);
 
 %Another approaches to arriving at the same answer. Random values.
 N = zeros(100,2);
 N(:,1) = 1000*rand(100,1);
 for i = 1:length(N)
     N(i,2) = 0.3*N(i,1).^3 -2*N(i,1).^2 + 200*N(i,1);
 end 
 %variables can be defined either during or after for the for-loop method
 x = N(:,1);
 y = N(:,2);
 
 figure;
 scatter(x,y);
 title('This is X vs. Y', 'FontSize', 14);
 xlabel('X', 'FontSize', 14);
 ylabel('Y', 'FontSize', 14);
 
 %Question 4
 for i = 1:length(x)
     if N(i,1) < 350
         N(i,1) = 0;
     else ;N(i,1) >= 350;
         N(i,1) = 1;
     end 
 end 
 %Values are different each time because it is a random distribution
 
 %convert to vector
 X = N(:,1);
 figure;
 bar(X);
 %looks like a bar code!
 
 
 %%Section 2: Importing Data%%
 
 NY_gas = xlsread('87-16_gasoline_prices','Data 1','A11:B370');
 %specifies the sheet to be extracted from and then also trims the
 %half-years off at the beginning and end
 %we'll need to use annual_profile for this next part to group the data
 %into years
 
 %generates a 12x30 matrix 'annual' 
 annual = annual_profile(NY_gas);
 %returns the average of all the rows for each column
 mean(annual(:,:));
 
 %function to write in matlab is xlswrite
 %specify filename output and then variable name input
 %format is slightly different for csv and other functions (they can take
 %only numberical values)
 xlswrite('monthly_average_price', annual);
 
 %%Section 3: Plotting%%
 
 %%Question 1%%
 %define the interval for t 
 t = 0:0.01:5;
 s = 2*sin(3*t + 2) + sqrt(5*t + 1);
 
 figure;
 plot(t,s);
 title('Variation of speed over time');
 xlabel('Time (s)');
 ylabel('Speed(ft/s)');
 
 %%Question 2%%
 x = 0:0.01:15; 
 y = 4*sqrt(6*x + 1);
 z = 5*exp(0.3*x) - 2*x;
 
 figure;
 for a = 1:2
     subplot(1,2,a);
     if a == 1
         plot(x,y);
         xlabel('Distance (meters)')
         ylabel('Force (newtons)')
     else ;a == 2;
         plot(x,z);
          xlabel('Distance (meters)')
          ylabel('Force (newtons)')
     end
 end  
 %plots a subplot 
 %even though we have a z function in the second part its still referred to
 %by ylabel function. We do have to specify both axes both times here. 
 
 %this is how we plot multiple things on the same graph. The placement of
 %'figure' and 'hold on'/'hold off' is key.
 figure;
 hold on
 plot(x,y)
 plot(x,z)
 xlabel('Distance (meters)')
 ylabel('Force (newtons)')
 legend('y = 4*sqrt(6*x + 1)','z = 5*exp(0.3*x) - 2*x')
 hold off
 %this creates the labels and legends we need for multiple graphs on the
 %same plot
 
 %Question 3%
 
 [X,Y] = meshgrid(1:50,1:50);
 Z = (((-2.5+X)/10)).^2 + (((-2.5+Y)/10)).^2;
 figure;
 surf(X,Y,Z);
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 colorbar
 
 %This is another way to do the same task using a series of for loops
 [X,Y] = meshgrid(1:50,1:50);
 Z = zeros(50,50);
 for i = 1:50
     for j = 1:50
     Z(i,j) = (((-2.5+X(i,j))/10)).^2 + (((-2.5+Y(i,j))/10)).^2;
     end
 end 
 figure;
 surf(X,Y,Z);
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 colorbar

%%Question 4%%

%Goal: see if the v_package is <= v_max at which point it will shatter

v_max = 25; %maximum velocity (ft/second) package can handle and remain intact 
m_package = 20; %mass of package (lbs)
g = 32.2; %accelleration due to gravity (ft/second^2)

%these equations help us solve the system numerically
t_min = g/v_max;
h_max = 1/2*g*(t_min).^2; %height which will produce the max allowed impact speed

%and solving for these variables helps us to plot
h = 0:0.1:10;
t = sqrt(2*h./g);
v = g*t;
figure;
plot(h,v);
xlabel('Initial height(feet)');
ylabel('Impact velocity(feet/second)');
title('Package height and Impact Velocity');

%the box won't shatter unless dropped from a height higher than a delivery man will be carrying it


