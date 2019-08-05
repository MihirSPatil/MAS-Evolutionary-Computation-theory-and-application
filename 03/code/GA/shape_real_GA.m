function output = shape_real_GA(wing_type, task, wing,  p )
    if nargin < 2
        %Parameters for the wing
        wing.numEvalPts = 256;
        
        switch wing_type
            case 1
                wing.nacaNum = [0,0,1,2];
%                 disp('Wing 1')
            case 2
                wing.nacaNum = [5,5,2,2];
%                 disp('Wing 2')
            case 3
                wing.nacaNum = [9,7,3,5];
%                 disp('Wing 3')
            otherwise
                wing.nacaNum = [0,0,1,2];
%                 disp('Wing 1')
        end
        
        wing.nacafoil= create_naca(wing.nacaNum,wing.numEvalPts);  % Create foil
        output = wing; %output of cityData
        return
    elseif nargin < 4
        p.task = task;
        p.nGenes = 32;
        p.maxGen    = 1000;
        p.popSize   = 50;
        p.sp        = 2;
        p.crossProb = 0.8; 
        p.cross_flag = 'one_point';
        p.mutProb   = 0.01;
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
            %Random population
            pop = rand(p.popSize,p.nGenes) - 0.5;
            
            %Getting the foils of each individual
            for iPop = 1:length(pop)
                [wing.foil{iPop}, ~] = pts2ind(pop(iPop,:)', wing.numEvalPts);
            end
            
            %Calculating the mean square error of the population
            fitness = feval(p.task, wing, pop);        
       end
       
       % Data Gathering
       [fitMax(iGen), iBest] = min(fitness); % 1st output is the max value, 2nd the index of that max value
       fitMed(iGen)          = median(fitness);
       best(:,iGen)          = pop(iBest,:);
       
       %Plotting progress
%        plot_foil(best(:,iGen), wing)
       
       % Selection -- Returns [MX2] indices of parents
       parentIds = my_selection_T(fitness, p); % Returns indices of parents

       % Crossover -- Returns children of selected parents
       children  = my_crossover_S(pop, parentIds, p);

       % Mutation  -- Applies mutation to newly created children
       children  = my_mutation_S(children, p); %waiting for Mihir

       % Elitism   -- Select best individual(s) to continue unchanged
       eliteIds  = my_elitism_T(fitness, p);

       % Create new population -- Combine new children and elite(s)
       newPop    = [pop(eliteIds,:); children];
       pop       = newPop(1:p.popSize,:);  % Keep population size constant
        
       % Evaluate new population
       for iPop = 1:length(pop)
                [wing.foil{iPop}, ~] = pts2ind(pop(iPop,:)', wing.numEvalPts);
       end
       fitness = feval(p.task, wing, pop);  
      
    end
    
    output.fitMax   = fitMax;
    output.fitMed   = fitMed;
    output.best     = best;
    
end