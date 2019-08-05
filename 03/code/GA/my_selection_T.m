function parentIds = my_selection(fitness, p)
% tic
%Selection - Returns indices of parents for crossover
% - Tournament selection:
%   1) N individuals are chosen randomly (N is selection pressure)
%   2) The individual in this subset with the highest fitness is chosen as
%   a parent
%   3) Another N individuals are chosen randomly
%   4) The individual in this subset with the highest fitness is chosen as
%   the other parent
%   5) Repeat steps 1-4 until you have one _pair_ of parents for each child
%   you plan on producing.
%
% Syntax:  parentIds = selection(fitness, p)
%
% Inputs:
%    fitness    - [M X 1] - Fitness of every individual in the population
%    p          - _struct - Hyperparameter struct
%     .sp                   - Selection Pressure
%
% Outputs:
%    parentIds  - [M X 2] - Indices of each pair of parents
%
% See also: crossover, mutation, elitism, monkeyGa

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%------------- BEGIN CODE --------------

%% Tournament Selection
%Number of iterations to have as many parents for desired children
%2 would assure that we have an array of 200 parents

parentIds = randi(p.popSize, [p.popSize 2]);

iterations = 2;

% Array of random values from 1 till popSize
rand_fit = randi(p.popSize, [p.sp p.popSize*2]);

%Using the max over the fitness give us the [max_value (which we do not
%care), and the index of the max_value] of the pairs randomly instantiated.
[~, fit_idx] = min(fitness(rand_fit));

%Create the parentIds array with the index of the maximum values of the
%rand_fit array. 
for i=1:length(rand_fit)
    parentIds(i) = rand_fit(fit_idx(i),i);
end
%------------- END OF CODE --------------
end

