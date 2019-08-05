clear; clear all;
cityData = TSP_German_ver();
p = TSP_German_ver('distance_calc',cityData);
output = TSP_German_ver('distance_calc',cityData,p);
disp("done")
plot([output.fitMax; output.fitMed]','LineWidth',3);
legend('Min Fitness','Median Fitness','Location','NorthWest');
xlabel('Generations'); ylabel('Total Distance [Coordinates]'); set(gca,'FontSize',16);
title('Performance of TSP')
%% Plotting the best individual over just one run
[lowest, ilowest] = min(output.fitMax);
smallest = output.best(:,ilowest)';

%coords = cityData.data([1:size(output.best,1)], [3 2])'; % <- switch to plot with north up after imagesc
plotTsp(smallest, cityData.coords);

%% Calculating the best individuals over 20 runs
clc; clear all;
parfor iExp = 1:30
    cityData = TSP_German_ver();
    p = TSP_German_ver('distance_calc',cityData);
    output = TSP_German_ver('distance_calc',cityData,p);
    fitness(iExp,:) = output.fitMax;
    fit_median(iExp,:) = output.fitMed;
    [lowest, ilowest] = min(output.fitMax);
    smallest = output.best(:,ilowest)';
    best_ind{iExp} = {smallest, lowest};
end
cityData = TSP_German_ver();
standardResult = fitness;

%Extracting the values from the best_ind cells
for i=1:30
    distances(i) = best_ind{i}{2};
end

%Getting the best individual
[val, iVal] = min(distances);
best = best_ind{iVal}{1};

%plot the best individual
plotTsp(best, cityData.coords);
disp('Press a key to continue')
pause;
close all;

myFitness = min(fitness);
myMedian = min(fit_median);
plot([myFitness; myMedian]','LineWidth',3);
legend('Best Fitness','Median Fitness','Location','NorthWest');
xlabel('Generations'); ylabel('Total Tour Distance [Coordinates space]'); set(gca,'FontSize',16);
title('Performance of TSP')

