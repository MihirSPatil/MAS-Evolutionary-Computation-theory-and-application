function fitness = non_consec_ones_zeros(pop)
    non_cons_count = 0;
    for i=1:numel(pop)-1
        if pop(i) ~= pop(i+1)
            non_cons_count = non_cons_count + 1;
        end
        
    end
    
    fitness = non_cons_count;

end