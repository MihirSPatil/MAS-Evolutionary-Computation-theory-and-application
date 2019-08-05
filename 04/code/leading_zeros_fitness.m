function fitness = leading_zeros_fitness(pop)
    [v,I] = max(pop');
    if v == 0
        fitness = size(pop,2);
    else
        fitness = I' - 1;
    end
end