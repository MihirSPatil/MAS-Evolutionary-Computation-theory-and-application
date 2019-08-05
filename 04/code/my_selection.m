function parentIds = my_selection(p, individuals)
%Selection - Returns indices of parents for crossover

% %% This is tournament selection


parentIds = zeros(p.popSize,2);

distance = [individuals.crowding_distance];
ranking = [individuals.rank];
for i= 1:p.popSize
    
    a = randi(p.popSize, [1 p.sp_]);
    
    if ranking(a(1)) < ranking(a(2))
        parentIds(i,1) = a(1);
    else
        if ranking(a(1)) == ranking(a(2))
            if distance(a(1)) > distance(a(2))
                parentIds(i,1) = a(1);
            else
                parentIds(i,1) = a(2);
            end
        else
            parentIds(i,1) = a(2);
        end
    end
    
    b = randi(p.popSize, [1 p.sp_]);
    
    if ranking(b(1)) < ranking(b(2))
        parentIds(i,2) = b(1);
    else
        if ranking(b(1)) == ranking(b(2))
            if distance(b(1)) > distance(b(2))
                parentIds(i,2) = b(1);
            else
                parentIds(i,2) = b(2);
            end
        else
            parentIds(i,2) = b(2);
        end
    end
end