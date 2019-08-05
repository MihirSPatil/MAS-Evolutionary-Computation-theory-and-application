%% Using GA
clear; p = monkeyGa('hamletSoliloquy');
p.maxGen = 10000; % Increase the number of generations
tic; % Start the timer
output = monkeyGa('hamletSoliloquy',p, 'Full');
gene2text(output.best(:,end)') % Show the found text
percentCorrect = (output.fitMax(end)/1446);
timeToComplete = toc; % End the timer
disp([num2str(100*percentCorrect) '% correct in ' num2str(timeToComplete) ...
' seconds'])

%% Brute Force
aWholeBunchOfTimes = 100000;

test = randi([0 27], [aWholeBunchOfTimes, p.nGenes]);

tic; hamletSoliloquy(test); tEnd = toc; 

oneEval = tEnd/aWholeBunchOfTimes;

disp(['A single evaluation takes ' num2str(oneEval) ' seconds'])