function individuals =  crowding_distance(F, individuals)
    nFitness = numel(individuals(1).fitness);
    for fr= 1:size(F,2)  
        % Extract front_ind in the front
        front_ind = [F{fr}];
        
%         % Initialize the distance to be zero
        for ind=1:numel(front_ind)
            individuals(front_ind(ind)).crowding_distance = 0;                   
        end
        
        %Collected the fitness from the individuals in the front
        fitness_front = reshape([individuals(front_ind).fitness], nFitness,[])';
        
        for m = 1:nFitness
            
            %Sort the values of the individuals in the front based on the
            %fitness
            [sorted_val, idx] = sort(fitness_front(:,m));
            
            %Set crowding distance of the boundary individuals to inf
            individuals(front_ind(idx(1))).crowding_distance = inf;
            individuals(front_ind(idx(end))).crowding_distance = inf;
            
            % Iterate over each fitness function and update the
            % corresponding crowding distance
            for k = 2:numel(idx) - 1
                if (max(sorted_val) - min(sorted_val)) ~= 0
                    individuals(front_ind(idx(k))).crowding_distance= ...
                        individuals(front_ind(idx(k))).crowding_distance + ...
                        (sorted_val(k+1) - sorted_val(k-1)) / ...
                        (max(sorted_val) - min(sorted_val));
                end
            end
        end   
    end
end