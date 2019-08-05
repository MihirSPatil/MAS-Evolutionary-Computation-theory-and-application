function new_chromosome  = mutation(chromosome)
mut_prob = 0.2 ;
nGenes = numel(chromosome);

new_chromosome = chromosome;
mut_chance = (rand(1,nGenes) < mut_prob);
for j = 1:length(mut_chance)
    if mut_chance(1,j)==1
        new_chromosome(1,j) = rand(1,1)-0.5;
    end
end
end

