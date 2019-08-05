function children  = my_mutation(children, p)
%Mutation - Make random changes in the child population
% - Point mutation:
%   1) Determine which genes will be mutated -- all have an equal chance
%   2) Change every gene chosen for mutation to another random value
%
% Syntax:  children  = my_mutation(children, p);
%
% Inputs:
%    children   - [M X N] - Population of M individuals
%    p          - _struct - Hyperparameter struct
%     .mutProb              - Chance per gene of performing mutation
%
% Outputs:
%    children   - [M X N] - New population of M individuals
%
% See also: selection, crossover, elitism, monkeyGa

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%Side notes for us: 
%A probabilistic mutation with rate α operates by going
%through the entire gene and performing a point mutation with probability α at
%each position. Probabilistic mutation is also called uniform mutation.
%SOURCE: http://www.springer.com/cda/content/document/cda_downloaddocument/9780387221960-c1.pdf?SGWID=0-0-45-166514-p46178519

%------------- BEGIN CODE --------------

%% No mutation happening, can you do better?
%tic
% children = children; 

%Create a logic array of the same size of the population based on the prob
%of mutation for every gene

mut_flag = (rand(p.popSize, p.nGenes) < p.mutProb);

%Passing a logic array to a normal array enables to change only those
%values that are "True"
children(mut_flag) = randi([0 1]);
% disp('Mutation process')
% toc
%------------- END OF CODE --------------
end


