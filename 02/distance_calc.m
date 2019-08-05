function fitness = distance_calc(pop,distMat)
    fitness = zeros(size(pop,1),1);
    for i=1:size(pop,1)
        ind = pop(i,:);
        distance = distMat(ind(1), ind(end));
        for iCity = 2:size(pop,2)
            twoCityIndices= [ind(iCity-1), ind(iCity)]; % Indices of distance matrix
            distance = distance + distMat(twoCityIndices(1), twoCityIndices(2));
        end
        fitness(i) = distance;
        %disp(distance)
    end
end