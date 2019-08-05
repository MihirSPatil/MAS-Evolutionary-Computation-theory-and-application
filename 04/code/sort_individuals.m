function individuals = sort_individuals(individuals)
    
    crowding_distance = [individuals.crowding_distance];
    
    [~, crowding_idx] = sort(crowding_distance,'descend');
    individuals = individuals(crowding_idx);
    rank = [individuals.rank];
    
    [~, rank_idx] = sort(rank);
    individuals = individuals(rank_idx);
end