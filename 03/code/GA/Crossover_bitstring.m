function children  = Crossover_bitstring(bitPop, parentIds, p)
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

%Initialization of the children array
children = zeros(size(bitPop));
nGenes = 32;
nBits = size(bitPop,2)/nGenes;

%Calculation of the number of parents
num_parents = size(parentIds,1);

%Array containing a flag for the parents over which crossover is going to
%be performed. 
%If the random number between 0 and 1 is less than the probability of 
%crossover True is stored, False otherwise.
cross_flag = rand(2,length(parentIds)) < p.crossProb;

%Iterate over the parents array in steps of 2
for i = 1 : num_parents
    
    %If both parents are active for crossover
    if cross_flag(1,i) && cross_flag(2,i)
        
        % -- Using set theory to find missing and common values
        parentA = parentIds(i,1);
        parentB = parentIds(i,2);
        
        splitPoint = randi([1 nGenes])*nBits;
        parent1Genes = bitPop(parentA,[1:splitPoint]);

        % Get those missing values in parent2, in the same order ('stable') 
        parent2Genes = bitPop(parentB,[splitPoint+1:end]);

        children(i,:) = [parent1Genes, parent2Genes];
        
    %If one or both parents are not active for crossover 
    else
        %Create the genome for the children by passing the first parent
        children(i,:) = bitPop(parentIds(i,1),:);   
    end
end 
%------------- END OF CODE -------------
end


