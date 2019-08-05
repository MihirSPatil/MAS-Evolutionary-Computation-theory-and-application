function output = TSP_German_ver(task, cityData,  p )
    if nargin < 1
        cityData = importdata('cities.csv');
        nCities = length(cityData.data);
%         nCities = 10;
        cityData.coords = cityData.data([1:nCities], [3 2])'; % <- switch to plot with north up after imagesc
        % Precalculate Distance Matrix
        cityData.distMat = squareform(pdist(cityData.coords')); 
        %plot(cityData.coords(1,:), cityData.coords(2,:), 'o')
        output = cityData; %output of cityData
        return
    elseif nargin < 3
        p.task = task;
        p.nGenes = size(cityData.coords,2);
        p.maxGen    = 300;
        p.popSize   = 100;
        p.sp        = 2;
        %Play with different rates for crossover
        p.crossProb = 0.8; 
%         p.crossProb = 0.01;
%         p.crossProb = 0.10;
%         p.crossProb = 0.99;
        p.cross_flag = 'two_point';
        %Play with different rates for mutation
%         p.mutProb   = 1/p.nGenes;
        p.mutProb   = 0.10;
%         p.mutProb   = 0.01;
%         p.mutProb   = 0.99;
        p.elitePerc = 0.1;
        output      = p;             % Output default hyperparameters
        return
    end
    
    %Record data
    fitMax = nan(1, p.maxGen);
    fitMed = nan(1, p.maxGen);
    best = nan(p.nGenes, p.maxGen);
    
    %Generation loop
    for iGen = 1:p.maxGen
        
       if iGen == 1
            %Create a pop as logical array representing true for item
            %picked, false otherwise
            pop         = cell2mat(arrayfun(@(pop_creat) ...
                randperm(p.nGenes), 1:p.popSize, 'UniformOutput', false)');
            
            fitness = feval(p.task, pop, cityData.distMat);        
       end
       
       % Data Gathering
       [fitMax(iGen), iBest] = min(fitness); % 1st output is the max value, 2nd the index of that max value
       fitMed(iGen)          = median(fitness);
       best(:,iGen)          = pop(iBest,:);
       
       %Plot current best individual
%        subplot(1,2,1)
%        plotTsp(pop(iBest,:), cityData.coords);
%        subplot(1,2,2)
%        plot([fitMax; fitMed]','LineWidth',3);
%        legend('Min Fitness','Median Fitness','Location','NorthWest');
%        xlabel('Generations'); ylabel('Total Distance [Coordinates]'); set(gca,'FontSize',16);
%        title('Performance of TSP')
%        pause(0.05)
       
       % Selection -- Returns [MX2] indices of parents
       parentIds = my_selection_T(fitness, p); % Returns indices of parents

       % Crossover -- Returns children of selected parents
       children  = my_crossover_T(pop, parentIds, p);

       % Mutation  -- Applies mutation to newly created children
       children  = my_mutation_T(children, p); %waiting for Mihir

       % Elitism   -- Select best individual(s) to continue unchanged
       eliteIds  = my_elitism_T(fitness, p);

       % Create new population -- Combine new children and elite(s)
       newPop    = [pop(eliteIds,:); children];
       pop       = newPop(1:p.popSize,:);  % Keep population size constant
        
       % Evaluate new population
       fitness = feval(p.task, pop, cityData.distMat);
      
    end
    
    output.fitMax   = fitMax;
    output.fitMed   = fitMed;
    output.best     = best;
    
end