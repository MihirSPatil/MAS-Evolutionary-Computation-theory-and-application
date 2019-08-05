function child  = two_point_crossover(pop, parentA, parentB,nCities)
    
    %Creating two random crossover points
    splitP1 = randi(nCities);
    splitP2 = randi(nCities);
    
    if splitP1 == splitP2 || abs(splitP1 - splitP2) == 1
        % Perform one point crossover when the two splitpoints match or the
        % difference between the two points is equal to 1
        child = one_point_crossover(pop, parentA, parentB,nCities, ...
                                    min(splitP1, splitP2));
        return
    else
    
        %Collecting the genes of the first parent based on the crossover points
        parent1Genes_1 = pop(parentA,[1:min(splitP1,splitP2)]);
        parent1Genes_2 = pop(parentA,[max(splitP1,splitP2):end]);

        % Find the values in [1:nCities] that are NOT in parent1Genes
        missing = setdiff(1:nCities, [parent1Genes_1, parent1Genes_2]);

        % Get those missing values in parent2, in the same order ('stable') 
        parent2Genes = intersect( pop(parentB,:) ,missing,'stable');

        child = [parent1Genes_1,parent2Genes,parent1Genes_2];
    end
end
