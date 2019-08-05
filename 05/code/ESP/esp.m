function [fit,weights] = esp(h,nNode,gensize)
popsize = 50;
n_elites = 10 ;
%initialising sub population
for i = 1: h
    for j = 1:popsize
        sub_population(i).pop(j,:) = rand([1 nNode])*2 - 1; 
    end
end

for gen = 1:gensize
    % Evaluation
    threshold_avg = 10 ;
    check_avg_count = 0;
    for i = 1: h
        for j = 1:popsize
            sub_pop_data{i}.cum_fitness(j) = 0 ;
            sub_pop_data{i}.count(j) = 0 ;
        end
    end
    while check_avg_count ~= h
        randomly_selected_indices =  randi([1 popsize],h,1) ;
        for k = 1:h
            randomly_selected_neurons(k,:) = sub_population(k).pop(randomly_selected_indices(k),:);
        end   
        weights = randomly_selected_neurons ;
        fitness = esp_fitness(weights);
        % adding fitness to cum fitness and increasing the count value
        for i = 1: h
            sub_pop_data{i}.count(randomly_selected_indices(i)) = sub_pop_data{i}.count(randomly_selected_indices(i)) + 1 ;
            sub_pop_data{i}.cum_fitness(randomly_selected_indices(i)) = sub_pop_data{i}.cum_fitness(randomly_selected_indices(i)) + fitness; ;
        end
        %chech whether all the indivudals get selected more than threshold
        %times
        check_avg_count = 0;
        for i = 1: h
            if all(sub_pop_data{i}.count > threshold_avg)
                check_avg_count = check_avg_count + 1;
            end
        end
    end

    % Recombination
    for i = 1:h
        sub_pop_data{i}.cum_fitness = rdivide(sub_pop_data{i}.cum_fitness,sub_pop_data{i}.count);
        pop = sub_population(i).pop;
        fitness = sub_pop_data{i}.cum_fitness;
        [~ , idx] = sort(fitness,'descend') ; 
        pop = pop(idx,:);
        sub_population(i).pop([1:n_elites],:) = pop([1:n_elites],:);
        for j = n_elites+1:popsize
            winner_id1 = rowlette_selection(fitness');
            winner_id2 = rowlette_selection(fitness');
            off_spring = crossover(pop(winner_id1,:),pop(winner_id2,:));
            off_spring = mutation(off_spring);
            sub_population(i).pop(j,:) = off_spring ; 
        end
    end
    gen

end

for i = 1:h
    weights(i,:) = sub_population(i).pop(1,:);
    out.fit = [fitness];
end
end



