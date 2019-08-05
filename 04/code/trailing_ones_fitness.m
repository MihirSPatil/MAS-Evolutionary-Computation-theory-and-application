function fitness = trailing_ones_fitness(pop)
    flipped_pop = fliplr(pop);
    [v,I] = min(flipped_pop');
    
    if v == 1
        fitness = 20;
    else
        fitness = I' - 1;
    end
end