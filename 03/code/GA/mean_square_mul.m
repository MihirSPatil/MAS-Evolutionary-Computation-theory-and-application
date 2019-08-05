function fitness = mean_square_mul(wing, pop)
    fitness = zeros(length(pop),1);
    for iPop = 1:length(pop)
        foil = wing.foil{iPop};
        fitness(iPop) = mean_square(wing, foil);
    end
end