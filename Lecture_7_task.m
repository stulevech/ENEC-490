%Lecture 7 task%

[num2012 char2012 combined2012] = xlsread('coal860_data (1).xlsx','2012_coal');
[num2015 char2015 combined2015] = xlsread('coal860_data (1).xlsx','2015_coal');

%total years under consideration 
years=1925:1:2012;

%creates bins for the histogram
bins=zeros(length(years),1);

for i=1:length(num2012)
    
    %identifies the year
    yr = num2012(i,4);
    
    %locates the correct 'bin'
    bin_number = find(years==yr);
    
    %adds capacity to correct 'bin'
    bins(bin_number) = bins(bin_number) + num2012(i,3);
    
end

bar(bins,'FaceColor', [.8 .8 .8], 'EdgeColor', [.7 .7 .7], 'LineWidth', .01);

hold on;

ax=gca;
ax.XTick=([1 11 21 31 41 51 61 71 81 91]);
ax.XTickLabel=({'1925','1935','1945','1955','1965','1975','1985','1995','2005','2010'});
xlabel('Year');
ylabel('Capacity (MW)');
set(ax,'FontSize',12)

%Identify unique rows that are different

retired = setdiff(num2012, num2015, 'rows');

retired_bins = zeros(length(years), 1);

for i = 1:length(retired)
    
    r_year = retired(i, 4)
    
    r_bin_number = find(years==r_year);
    
    retired_bins(r_bin_number) = retired_bins(r_bin_number) + retired(i, 3);
end 

bar(retired_bins, 'FaceColor', [.7 .4 .3], 'EdgeColor', [.2 .5 .8], 'LineWidth', .01);