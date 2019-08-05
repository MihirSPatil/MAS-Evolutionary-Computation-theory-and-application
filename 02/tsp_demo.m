clear
cityData = importdata('cities.csv');
nCities = 10;
coords = cityData.data([1:nCities], [3 2])';
plot(coords(1,:), coords(2,:), 'o')

%% Algorithm parameters
popSize = 25;
nGenes = nCities;

%% Create a single individual
someInd = 1:10;
plot(coords(1, someInd), coords(2,someInd), '-o')

plotTsp(someInd, coords);

%% Create a population
pop = zeros()
for iPop = 1:popSize
    pop(iPop,:) = randperm(nGenes);
end

%% Distance of path of an individual
% distance from last to first city
%distance = pdist(coords(:, someInd([1 end])'));

for iCity = 2:nCities
    distance = distance + pdist(coords(:, someInd([iCity iCity-1])'));
end

%% Look up distance of an individual
distance_matrix = squareform(pdist(coords'))

ind = pop(1,:)
distance = distance_matrix(ind(1), ind(end))
for iCity = 2:ncities
    distance = distance + distance_matrix(ind(iCity - 1 ), ind(iCity));
end

%% Crossover
parentA = 1;
parentB = 2;

splitPoint = randi(nGenes);
parent1Genes = pop(parentA, [1:splitPoint]);
missing = setdiff(1:nCities, parent1Genes);
parent2Genes = intersect(pop(parentB, :), missing, 'stable');

child = [parent1Genes, parent2Genes];