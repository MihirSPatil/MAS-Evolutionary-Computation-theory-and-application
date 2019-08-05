%% Calculating the best individuals over 20 runs for four different algorithms
 clear all; clc; 
% tic
for i=1:3
    % Running GA
    wing_type = i;
    disp(['Wing: ' num2str(wing_type)])
    fitness = [];
    parfor iExp = 1:20
        wing = shape_real_GA(wing_type);
        p = shape_real_GA(wing_type,'mean_square_mul', wing);
        output = shape_real_GA(wing_type,'mean_square_mul', wing, p);
        fitness(iExp,:) = output.fitMax;
    end
    GAFitness = fitness;
    disp('GA done')
    
    % Running ES
    fitness = [];
    parfor iExp = 1:20
        fitness(iExp,:) = oneFifthES(wing_type);
    end
    ESFitness = fitness;
    disp('ES done')
    fitness = [];
    
    % Running CMA-ES without evolution path
    parfor iExp = 1:20
        fitness(iExp,:) = CMA_ES(wing_type);
    end
    CMAESFitness_s = fitness;  
    disp('CMA-ES without EP done')
    
    fitness = [];
    % Running CMA-ES with evolution path
    parfor iExp = 1:20
        fitness(iExp,:) = CMA_ES_EP(wing_type);
    end
    CMAESFitness = fitness;   
    disp('CMA-ES with EP done')
    
    
    save(['Master_Comparison' num2str(i)], 'GAFitness', 'ESFitness', 'CMAESFitness_s', 'CMAESFitness')
end

%% Plotting 
%Shape 1 Data

load('Master_Comparison1.mat')
shape1_GA = GAFitness;
shape1_ES = ESFitness;
shape1_CMA_ES_N = CMAESFitness_s;
shape1_CMA_ES = CMAESFitness;

%Shape 2 Data

load('Master_Comparison2.mat')
shape2_GA = GAFitness;
shape2_ES = ESFitness;
shape2_CMA_ES_N = CMAESFitness_s;
shape2_CMA_ES = CMAESFitness;

%Shape 3 Data

load('Master_Comparison3.mat')
shape3_GA = GAFitness;
shape3_ES = ESFitness;
shape3_CMA_ES_N = CMAESFitness_s;
shape3_CMA_ES = CMAESFitness;

%Plot 


plot(median([shape1_GA;shape2_GA;shape3_GA]),'LineWidth',3)
hold on
plot(median([shape1_ES;shape2_ES;shape3_ES]),'LineWidth',3)
plot(median([shape1_CMA_ES_N;shape2_CMA_ES_N;shape3_CMA_ES_N]),'LineWidth',3)
plot(median([shape1_CMA_ES;shape2_CMA_ES;shape3_CMA_ES]),'LineWidth',3)

legend('GA Real value ','ES','CMA-ES No Path', 'CMA-ES Path','Location','NorthEast');
xlabel('Generations'); ylabel('Fitness'); set(gca,'FontSize',16,'YScale','log');
title('GA vs ES vs CMA-ES No Path vs CMA-ES Path')
grid

%% GA vs ES
%Real value
parfor iExp = 1:20
    wing = shape_real_GA(wing_type);
    p = shape_real_GA(wing_type,'mean_square_mul', wing);
    output = shape_real_GA(wing_type,'mean_square_mul', wing, p);
    fitness(iExp,:) = output.fitMax;
%     fit_median(iExp,:) = output.fitMed;
    [lowest, ilowest] = min(output.fitMax);
    best = output.best(:,ilowest)';
    best_ind{iExp} = {best, lowest};
end
disp('GA with real value took: ')
toc;

%Extracting the values from the best_ind cells
for iPen=1:20
    penalizations(iPen) = best_ind{iPen}{2};
end

%Getting the best individual
[~, iVal] = min(penalizations);
smallest_Real = best_ind{iVal}{1};
GA_Real_Fitness = median(fitness);

fitness = [];
parfor iExp = 1:20
   [fitness(iExp,:), best_individuals(:,iExp)] = oneFifthES(wing_type);
end

ESFitness_med = median(fitness);
disp('ES done')

plot([GA_Real_Fitness; ESFitness_med]','LineWidth',3);
legend('GA Real value ','ES','Location','NorthEast');
xlabel('Generations'); ylabel('Fitness'); set(gca,'FontSize',16,'YScale','log');
title('GA vs ES')
grid

plot_foil(smallest_Real', wing)
best_individual_ES = mean(best_individuals,2);
plot_foil(best_individual_ES, wing);


%% ES vs CMA ES No evolutionary paths
fitness = [];
parfor iExp = 1:20
   [fitness(iExp,:), best_individuals(:,iExp)] = CMA_ES(wing_type);
end

CMA_ES_NFitness_med = median(fitness);
disp('CMA-ES done')

plot([ESFitness_med; CMA_ES_NFitness_med]','LineWidth',3);
legend('ES','CMA-ES without path','Location','NorthEast');
xlabel('Generations'); ylabel('Fitness'); set(gca,'FontSize',16,'YScale','log');
title('ES vs CMA-ES')
grid

best_individual_CMA_ES_N = mean(best_individuals,2);
plot_foil(best_individual_CMA_ES_N, wing);

%% CMA ES No evolutionary paths vs CMA-ES with evolution paths
fitness = [];
parfor iExp = 1:20
   [fitness(iExp,:), best_individuals(:,iExp)] = CMA_ES_EP(wing_type);
end

CMA_ES_Fitness_med = median(fitness);
disp('CMA-ES done')

plot([ESFitness_med; CMA_ES_Fitness_med]','LineWidth',3);
legend('CMA-ES without path','CMA-ES with paths','Location','NorthEast');
xlabel('Generations'); ylabel('Fitness'); set(gca,'FontSize',16,'YScale','log');
title('CMA-ES with vs without evolutionary paths')
grid

% best_individual_CMA_ES = mean(best_individuals,2);
% plot_foil(best_individual_CMA_ES, wing);

