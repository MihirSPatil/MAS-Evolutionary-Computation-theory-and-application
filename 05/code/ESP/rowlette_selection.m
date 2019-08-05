function selection_id = rowlette_selection(fitness)
fitness_norm = fitness / sum(fitness,1);
r = rand(1);
index = 1;
while (r>0)
    r = r - fitness_norm(index,:);
    index = index + 1 ;
end
index = index - 1 ;
selection_id =  index;
end