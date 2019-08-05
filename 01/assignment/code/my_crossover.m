function children  = my_crossover(pop, parentIds, p)
%tic
%Crossover - Creates child solutions by combining genes of parents
% - Single Point Crossover:
%   1) For each set of parents:
%   2) Determine whether or not to perform crossover (p.xoverChance)
%   3) If not, take first parent as child
%   4) If yes, choose random point along genome and:
%   5) Create child from genes behind point from parent A and in front of
%   that point from parent B
%
% Syntax:  children  = crossover(pop, parentIds, p)
%
% Inputs:
%    pop        - [M X N] - Population of M individuals
%    parentIds  - [M X 2] - Parent pair indices
%    p          - _struct - Hyperparameter struct
%     .crossProb            - Chance of performing crossover
%
% Outputs:
%    children   - [M X N] - New population of M individuals
%
% See also: selection, mutation, elitism, monkeyGa

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 20-Feb-2018

%% No crossover happening, can you do better?
%children = pop( parentIds(:,1) ,:);

%------------- BEGIN CODE --------------

%% 
%Index used to itterate over children array
child_idx = 1;

%Initialization of the children array
children = zeros(size(pop));

%Calculation of the number of parents
num_parents = size(parentIds,2);

%Array containing a flag for the parents over which crossover is going to
%be performed. 
%If the random number between 0 and 1 is less than the probability of 
%crossover True is stored, False otherwise.
cross_flag = rand(1,length(parentIds)) < p.crossProb;

%Iterate over the parents array in steps of 2
for i = 1 : 2 : num_parents
    
    %If both parents are active for crossover
    if cross_flag(i) && cross_flag(i+1)
        
        %Random point to perform crossover from 1 till 17
        cross_point = randi(p.nGenes-1);
        
        %Get the index for the first part
        part_1 = 1 : cross_point;
        
        %Get the index for the second part
        part_2 = cross_point + 1 : p.nGenes;
        
        %Create the genome for the children combining the first part for
        %the first parent and the second part of the second parent
        children(child_idx,:) = ...
            [pop(parentIds(i),part_1), pop(parentIds(i+1),part_2)];
        
    %If one or both parents are not active for crossover 
    else
        %Create the genome for the children by passing the parent
        children(child_idx,:) = pop(parentIds(i),:);

        
    end
    child_idx = child_idx + 1;
end 
%disp('Crossover process')
%toc
%------------- END OF CODE -------------
end


