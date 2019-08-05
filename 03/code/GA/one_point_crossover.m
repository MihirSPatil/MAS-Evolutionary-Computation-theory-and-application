function child  = one_point_crossover(pop, parentA, parentB, nCities, splitPoint)
    if nargin < 5
    %   Select a point to split genes
    %   Here we do 1 point crossover. Can you think of any advantage of doing
    %   '2 point' crossover?
        splitPoint = randi(nCities);
        parent1Genes = pop(parentA,[1:splitPoint]);

        % Get those missing values in parent2, in the same order ('stable') 
        parent2Genes = pop(parentB,[splitPoint+1:end]);

        child = [parent1Genes, parent2Genes];
    else
    %   Perform one point crossover with the splitpoint given from the two
    %   point crossover function.
        parent1Genes = pop(parentA,[1:splitPoint]);

        % Find the values in [1:nCities] that are NOT in parent1Genes

        % Get those missing values in parent2, in the same order ('stable') 
        parent2Genes = pop(parentB,[splitPoint+1:end]);

        child = [parent1Genes, parent2Genes];
    end
end
