%Lecture18

%Define state vector
% 1 - sunny; 2 - rainy

x = [0 1];
P = [.9 .1; .5 .5];

% Probability of weather 10 days from now
x_n = zeros(10,2);
for i = 1:10
    x_n(i,:) = x*P^i;
end

% Steady state probability

% q (P - I) = 0

P_I = P - [1 0;0 1];

% Solve system of equations 
% -.1(q1) + .5(q2) = 0
%  .1(q1) - .5(q2) = 0
%   q1 + q2 = 1

% .1(q1) - .5(1-q1) = 0; -->
% .6(q1)  = .5
q1 = .5/.6;
q2 = 1-q1;
weather_prob = [q1 q2]

sunny = q1*365;
rainy = q2*365;


%Lecture 18 in-class example: socioeconomic status and generations%

%state definitions% p = professional; s = skilled; u = unskilled;
p = [1 0 0];
s = [0 1 0];
u = [0 0 1];

P = [0.8 0.1 0.1; 0.6 0.2 0.2; 0.5 .25 .25];

%probability of a given grandaughter's potential labor classes
x_n = zeros(2,3);
for i = 1:length(x_n)
    x_n(i,:) = u*P^i;
end 
professional_prob = x_n(length(x_n),1)

%now the idea is to solve for the steady state values; this means we need
%to find q. 

%form of solving for the steady state equilibrium (q)
%steady = q(P - eye(3,3)) == 0;
P - eye(3,3); 

%we can solve to get our coefficient values (out to second or third decimal place)
%which q1, q2, q3 multiply by to have the whole equation equal to zero. 

%one way to go about solving a system of equations

%syms q1 q2 q3 
%eqn1 = -0.2*q1 + 0.6*q2 + 0.5*q3 == 0;
%eqn2 = 0.1*q1 - 0.8*q2 + 0.2*q3 == 0;
%eqn3 = 0.5*q1 + 0.25*q2 - 0.75*q3 == 0;
%eqn4 = q1 + q2 + q3 == 1;

%solution = solve([eqn1, eqn2, eqn3, eqn4], [q1, q2, q3]);
%q1Sol = solution.q1
%q2Sol = solution.q2
%q3Sol = solution.q3


%another way: define matrices of our coefficients and of our intercepts
%coefficients\intercepts 
%A\B is the solution to A*X = B. 
%A must be an NxN matrix and B must be a column vector

coeff = [-.2 .6 .5; .1 -.8 .25; .1 .2 -.75; 1, 1, 1];
intercept = [0; 0; 0; 1];
equilibrium = coeff\intercept;
q1 = equilibrium(1)
q2 = equilibrium(2)
q3 = equilibrium(3)

%how many generations

x_m = zeros(10,3);
for i = 1:length(x_m)
    x_m(i,:) = u*P^i;
end 
prob_over_generations = x_m
%we can look at the probabilities out to three decimal places to see when
%steady-state roughly arrives

%appears between 7-8 generations.

%we should interpret the results to mean that after 8 generations there is
%not a higher or lower probability that a given great^x grandaugther will
%be in the professional class instead of another class.










