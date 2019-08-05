function dominates = dom_validator(ind_A, ind_B, individuals)
    % Validate if ind_A dominate ind_B
    
%     if (fitness_ones(ind_A) > fitness_ones(ind_B) && ...
%        fitness_zeros(ind_A) >= fitness_zeros(ind_B) || ...
%        fitness_zeros(ind_A) > fitness_zeros(ind_B) && ...
%        fitness_zeros(ind_A) >= fitness_zeros(ind_B))
%        dominates = true;
%     else
%         dominates = false;
%     end
    
    ind_A_fit = individuals(ind_A).fitness;
    ind_B_fit = individuals(ind_B).fitness;
    
%     ind_A_fit = [leading_zeros_fitness(individuals(ind_A).gen), trailing_ones_fitness(individuals(ind_A).gen)];
%     ind_B_fit = [leading_zeros_fitness(individuals(ind_B).gen), trailing_ones_fitness(individuals(ind_B).gen)];
    dominates = (all(ind_A_fit >= ind_B_fit) && ...
                 any(ind_A_fit > ind_B_fit));
    
   
end