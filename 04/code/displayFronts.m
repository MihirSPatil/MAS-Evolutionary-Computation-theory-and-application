%% Display Fronts
% 
function fig = displayFronts(front, fitness, pop)
%displayFronts - Displays pareto fronts in leading ones/trailing zeros
% 
%
% Syntax:  [output1,output2] = function_name(input1,input2,input3)
%
% Inputs:
%    front   - [N X 1] - The front which an individual belongs (1st,2nd,...)
%    fitness - [N X 2] - Fitness values for each objective
%    pop     - [N X M] - Genome of length M of each of the N individuals
%
% Outputs:
%    fig     - handle  - figure handle
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Oct 2017; Last revision: 14-Jun-2018

nGenes = size(pop,2);
popSize= size(pop,1);
survivals = popSize / 2;
num_fitness = size(fitness,2);

hold off;
nFront = max(front); colors = parula(nFront);
if num_fitness ==2
    for iFront=1:nFront
        h = plot(fitness((front==iFront),1),fitness((front==iFront),2));
        set(h,'LineStyle','--','Color',colors(iFront,:),'Marker','o'...
             ,'MarkerFaceColor', colors(iFront,:),'MarkerSize',25)
        hold on;
        if iFront ==1
            text(fitness((front==iFront),1)+0.35,...
                fitness((front==iFront),2)-(0.25*~mod(iFront,2)),...
                num2str(pop( (front==iFront),:)))
        end
    end

    plot(fitness(1:survivals,1), fitness(1:survivals,2), 'go', 'MarkerSize', 15)
    plot(fitness(survivals+1:popSize,1), fitness(survivals+1:popSize,2), 'rx', 'MarkerSize', 15)
    
    xlabel('Trailing zeros');ylabel('Leading ones');
    axis([-0.5 nGenes+0.5 -0.5 nGenes+0.5]); hold off;
    title('Solutions and Fronts');
    grid on;
else
    for iFront=1:nFront      
        h = plot3(fitness((front==iFront),1),fitness((front==iFront),2),fitness((front==iFront),3));
        set(h,'LineStyle','--','Color',colors(iFront,:),'Marker','o'...
             ,'MarkerFaceColor', colors(iFront,:),'MarkerSize',25)
        hold on;
%         if iFront ==1
%             text(fitness((front==iFront),1)+0.35,...
%                 fitness((front==iFront),2)-(0.25*~mod(iFront,2)),...
%                 num2str(pop( (front==iFront),:)))
%         end
    end

    plot3(fitness(1:survivals,1), fitness(1:survivals,2), fitness(1:survivals,3),'go', 'MarkerSize', 15)
    plot3(fitness(survivals+1:popSize,1), fitness(survivals+1:popSize,2), fitness(survivals+1:popSize,3),'rx', 'MarkerSize', 15)
    
    xlabel('Trainling zeros');ylabel('Leading ones'); zlabel('Non Consecutive')
    axis([-0.5 nGenes+0.5 -0.5 nGenes+0.5 -0.5 nGenes+0.5]); hold off;
    title('Solutions and Fronts');
    grid on;
end




fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',14)
set(gca,'FontSize',18);