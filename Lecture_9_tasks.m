%Lecture 9 tasks%

[data text combined] = xlsread('state_fuel_cf.xlsx','A2:C7022');

%conditions
state = 'NC';
source = 'SUN';
CF = 0.20;

%creates a column vector consisting of just states that have the matching
%text to what we've specified in our conditions
a = strcmp(state,text(:,1));
%this takes the sum of a (which consists of just zeros and ones) over the
%length of the total list of power plants. yields a probability
state_prob = sum(a)/length(data)
%probability a given plant out of all US plants is in a given state

%probability a given plant out of all US plants is a given source
b = strcmp(source,text(:,2)); 
source_prob = sum(b)/length(data)

%data operates independently of text
%the third column of a matrix is not the third column of data
%we need to operate in either data or text depending on our application
%most likely

%probability a given plant out of all US plants has CF >= specified value
c = data(:,1) >= CF;
CF_prob = sum(c)/length(data)

%for the problem when we're interested in greater than, and not equal to
d = data(:,1) > CF;
CF_prob2 = sum(d)/length(data);

%alternative to sum() is to use find()
%c_alt = find(data(:,1)) >= CF;
%creates a new vector with just those values satisfying CF constraint
%CF_prob_alt = length(c_alt)/length(data);

%total plant numbers
US_plant_total = length(data); %total number of US power plants; total = 7021
state_plant_total = sum(a); %total number of power plants in a given state; ex NC = 224 
source_plant_total = sum(b); %total number of power plants of a given source type; ex SUN = 587 


%%Question 7b.i%%
%Given all solar plants in US, what is likelihood of one being in NC?
%consolidate column vectors
A = zeros(length(data),3);
A(:,1) = a;
A(:,2) = b;
A(:,3) = d;

%count the number of solar farms when NC is the state (conditional)
counter_1 = 0; %starting value
for i = 1:length(A)
    if A(i,1) == 1;        
        counter_1 = counter_1 + (A(i,2));
    end 
end 
%counter_1 value is # solar plants in NC
%probability a given US solar plant is in NC
prob_source_plant_is_in_state = counter_1/source_plant_total


%%Question 7b.ii%%
%count the number of NC power plants (conditional) that are also solar farms
%probability a given NC power plant is a solar plant
prob_state_power_plant_is_source = counter_1/state_plant_total
%only difference is divide by # NC power plants this time, not # US solar plants


%Question 7b.iii
%probability of selecting a solar farm in NC with CF > 0.20, out of all power plants in the US
counter_2 = 0;
for i = 1:length(A)
    if A(i,1) == 1 && A(i,2) == 1        
        counter_2 = counter_2 + (A(i,3));
    end 
end 
%divide this result by the total number of US power plants
non_conditional = counter_2/length(data)


%Question 7b.iv
%Given the number of NC solar plants, what is the probability a given plant's capacity
%factor is greater than 0.2?

%count the number of CF > 0.20 among NC solar plants
counter_3 = 0;
for i = 1:length(A)
    if A(i,1) == 1 && A(i,2) == 1        
        counter_3 = counter_3 + (A(i,3));
    end 
end 
%probability of selecting one of these out of all the NC solar plants
prob_given_state_and_source_is_threshold_CF_plant = counter_3/counter_1


%Question 7b.v

%iii is different from iv because we first specified the condition that we'd be looking
%only at solar plants in NC, rather than at all power plants in the US.
%This would explain why the probability is so much higher for selecting a
%power plant given the constraints laid out