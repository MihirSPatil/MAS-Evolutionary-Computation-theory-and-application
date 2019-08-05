%% GA Real value - Single run
clc; clear all;
tic
wing_type = 1;
wing = shape_real_GA(wing_type);
p = shape_real_GA(wing_type,'mean_square_mul', wing);
output = shape_real_GA(wing_type,'mean_square_mul', wing, p);
disp("Foil calculated")
toc

%% GA Bitstring - Single run
clc; clear all;
wing_type = 1;
wing = shape_bitstring_GA(wing_type);
p = shape_bitstring_GA(wing_type,'mean_square_mul', wing);
output = shape_bitstring_GA(wing_type,'mean_square_mul', wing, p);
disp("Foil calculated")

%% Plotting fitness
plot([output.fitMax; output.fitMed]','LineWidth',3);
legend('Min Fitness','Median Fitness','Location','NorthWest');
xlabel('Generations'); ylabel('Mean square error'); set(gca,'FontSize',16);
title('Performance of Shape formation')

%% Calculating the best individual
[lowest, ilowest] = min(output.fitMax);
smallest = output.best(:,ilowest)';

%% Plotting the best individual
plot_foil(smallest', wing)

%NOTE: Pending finding the right parameters to improve performance. 



%% Evaluating over 20 runs the GAs
clc; clear all;
wing_type = 1;
tic;
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
GA_Real_Fitness = mean(fitness);

tic;
%Bit string representation
parfor iExp = 1:20
    wing = shape_bitstring_GA(wing_type);
    p = shape_bitstring_GA(wing_type,'mean_square_mul', wing);
    output = shape_bitstring_GA(wing_type,'mean_square_mul', wing, p);
    fitness(iExp,:) = output.fitMax;
    [lowest, ilowest] = min(output.fitMax);
    best = output.best(:,ilowest)';
    best_ind{iExp} = {best, lowest};
end
disp('GA with bitstring representation took: ')
toc;

%Extracting the values from the best_ind cells
for iPen=1:20
    penalizations(iPen) = best_ind{iPen}{2};
end

%Getting the best individual
[~, iVal] = min(penalizations);
smallest_Bit = best_ind{iVal}{1};
GA_Bit_Fitness = mean(fitness);

% plot_foil(smallest', wing)
% pause;
% close all;


wing = shape_real_GA(wing_type);
% myMedian = mean(fit_median);
plot([GA_Real_Fitness; GA_Bit_Fitness]','LineWidth',3);
legend('Mean Real Fitness','Mean Bit Fitness','Location','NorthEast');
xlabel('Generations'); ylabel('Fitness'); set(gca,'FontSize',16,'YScale','log');
title('Real value representation against Bitstring representation')

save('GA_20_runs', 'GA_Real_Fitness', 'GA_Bit_Fitness')