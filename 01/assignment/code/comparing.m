%% Saving comparison data between Adam's code and me 
% changing 'for' to 'parfor'.
%parfor allows to run code in paraller processors
clear; p = monkeyGa('hamletQuote');

parfor iExp = 1:20
output = adamGa('hamletQuote',p);
fitness(iExp,:) = output.fitMax;
end

standardResult = fitness;

parfor iExp = 1:20
output = monkeyGa('hamletQuote',p,'Full');
fitness(iExp,:) = output.fitMax;
end

myFull = fitness;

parfor iExp = 1:20
output = monkeyGa('hamletQuote',p,'No_cross');
fitness(iExp,:) = output.fitMax;
end

myNoCross = fitness;

parfor iExp = 1:20
output = monkeyGa('hamletQuote',p,'No_mut');
fitness(iExp,:) = output.fitMax;
end

myNoMut = fitness;

parfor iExp = 1:20
output = monkeyGa('hamletQuote',p,'No_cross_elit');
fitness(iExp,:) = output.fitMax;
end

myNoCrossElit = fitness;

parfor iExp = 1:20
output = monkeyGa('hamletQuote',p,'No_mut_elit');
fitness(iExp,:) = output.fitMax;
end

myNoMutElit = fitness;

save('runData.mat','standardResult', 'myFull', 'myNoCross', 'myNoMut',...
    'myNoCrossElit', 'myNoMutElit')
%% Plotting comparisons
load('runData.mat')
    %% Adams vs Ours
    
    gens = 1:length(standardResult);

    % Get Significance of comparisons
    fit1 = standardResult; fit2 = myFull;
    [p,h] = sigPerGen(fit1,fit2);

    % Plot results at every generation
    figure(1); clf; hold on; C = parula(8); % Create figures and color map

    % Plot Significance at every generations. What is this?
    hS1 = scatter(gens(~h),ones(1,sum(~h))*19,20,C(1,:),'filled','s');
    hS2 = scatter(gens(h),ones(1,sum(h))*19,20,C(8,:),'filled','s');

    % Plot median and percentiles
    [hLine(1), hFill(1)] = percPlot(gens,fit1 ,C(3,:));
    [hLine(3), hFill(2)] = percPlot(gens,fit2,C(5,:));

    % Label and make pretty
    hLeg = legend([hFill hS1 hS2],'Adams code', 'Ours code','p > 0.05', ...
    'p < 0.05','Location','SouthEast');
    xlabel("Generations", 'Fontsize', 20)
    ylabel("Fitness",'Fontsize', 20)
    grid()
    title("Adams vs Ours")
    
    %% Comparing Full implementation vs No Crossover
    gens = 1:length(myFull);

    % Get Significance of comparisons
    fit1 = myFull; fit2 = myNoCross;
    [p,h] = sigPerGen(fit1,fit2);

    % Plot results at every generation
    figure(2); clf; hold on; C = parula(8); % Create figures and color map

    % Plot Significance at every generations. What is this?
    hS1 = scatter(gens(~h),ones(1,sum(~h))*19,20,C(1,:),'filled','s');
    hS2 = scatter(gens(h),ones(1,sum(h))*19,20,C(8,:),'filled','s');

    % Plot median and percentiles
    [hLine(1), hFill(1)] = percPlot(gens,fit1 ,C(3,:));
    [hLine(3), hFill(2)] = percPlot(gens,fit2,C(5,:));

    % Label and make pretty
    hLeg = legend([hFill hS1 hS2],'Full', 'No Crossover','p > 0.05', ...
    'p < 0.05','Location','SouthEast');
    xlabel("Generations", 'Fontsize', 20)
    ylabel("Fitness",'Fontsize', 20)
    grid()
    title("Full vs No Crossover")
    
    %% Comparing Full implementation vs No Mutation
    gens = 1:length(myFull);

    % Get Significance of comparisons
    fit1 = myFull; fit2 = myNoMut;
    [p,h] = sigPerGen(fit1,fit2);

    % Plot results at every generation
    figure(3); clf; hold on; C = parula(8); % Create figures and color map

    % Plot Significance at every generations. What is this?
    hS1 = scatter(gens(~h),ones(1,sum(~h))*19,20,C(1,:),'filled','s');
    hS2 = scatter(gens(h),ones(1,sum(h))*19,20,C(8,:),'filled','s');

    % Plot median and percentiles
    [hLine(1), hFill(1)] = percPlot(gens,fit1 ,C(3,:));
    [hLine(3), hFill(2)] = percPlot(gens,fit2,C(5,:));

    % Label and make pretty
    hLeg = legend([hFill hS1 hS2],'Full', 'No Mutation','p > 0.05', ...
    'p < 0.05','Location','SouthEast');
    xlabel("Generations", 'Fontsize', 20)
    ylabel("Fitness",'Fontsize', 20)
    grid()
    title("Full vs No Mutation")
    
    %% Comparing No Crossover vs No Crossover and No Elitism
    gens = 1:length(myFull);

    % Get Significance of comparisons
    fit1 = myNoCross; fit2 = myNoCrossElit;
    [p,h] = sigPerGen(fit1,fit2);

    % Plot results at every generation
    figure(4); clf; hold on; C = parula(8); % Create figures and color map

    % Plot Significance at every generations. What is this?
    hS1 = scatter(gens(~h),ones(1,sum(~h))*19,20,C(1,:),'filled','s');
    hS2 = scatter(gens(h),ones(1,sum(h))*19,20,C(8,:),'filled','s');

    % Plot median and percentiles
    [hLine(1), hFill(1)] = percPlot(gens,fit1 ,C(3,:));
    [hLine(3), hFill(2)] = percPlot(gens,fit2,C(5,:));

    % Label and make pretty
    hLeg = legend([hFill hS1 hS2],'No Crossover', 'No Crossover-Elit','p > 0.05', ...
    'p < 0.05','Location','SouthEast');
    xlabel("Generations", 'Fontsize', 20)
    ylabel("Fitness",'Fontsize', 20)
    grid()
    title("No Crossover vs No Crossover and No Elitism")
    
    %% Comparing No Mutation vs No Mutation and No Elitism
    gens = 1:length(myFull);

    % Get Significance of comparisons
    fit1 = myNoMut; fit2 = myNoMutElit;
    [p,h] = sigPerGen(fit1,fit2);

    % Plot results at every generation
    figure(5); clf; hold on; C = parula(8); % Create figures and color map

    % Plot Significance at every generations. What is this?
    hS1 = scatter(gens(~h),ones(1,sum(~h))*19,20,C(1,:),'filled','s');
    hS2 = scatter(gens(h),ones(1,sum(h))*19,20,C(8,:),'filled','s');

    % Plot median and percentiles
    [hLine(1), hFill(1)] = percPlot(gens,fit1 ,C(3,:));
    [hLine(3), hFill(2)] = percPlot(gens,fit2,C(5,:));

    % Label and make pretty
    hLeg = legend([hFill hS1 hS2],'No Mutation', 'No Mutation-Elit','p > 0.05', ...
    'p < 0.05','Location','SouthEast');
    xlabel("Generations", 'Fontsize', 20)
    ylabel("Fitness",'Fontsize', 20)
    grid()
    title("No Mutation vs No Mutation and No Elitism")

