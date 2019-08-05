function [fitness, individual] = oneFifthES(wing_type)
    %Number of evaluation points for the wing
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

    nGenes = 32;
    task = 'mean_square';

    % ES parameters
    gamma = (20/17)^(1/nGenes);
    s = 0;
    t = 0; %time
    p = 5; %period of time

    mean = zeros(nGenes,1);
    variance = ones(nGenes,1);
    step_size = 0.2;

    %Initializing an individual
    individual = rand(nGenes,1)-0.5;

    stop_criteria = false;
    iGen = 1;
    MaxGen = 1001;

    while(iGen < MaxGen)

        %Generating a random noise
        Z = normrnd(mean, variance);

        %Creating a new individual
        new_individual = individual + step_size.*Z;

        %Calculating the fitness for that particular individual
        [foil, ~] = pts2ind(individual, wing.numEvalPts);
        cur_fitness = feval(task, wing, foil);

        %Iterating over the new genes to only add the ones
        %that actually improve the fitness.
        %This helped to speed up the convergence of the algorithm
        for gene = 1:nGenes

            %Back up individual to test the new Genes
            temp_individual =individual;

            %Update gene
            temp_individual(gene) = new_individual(gene);

            %Calculate the corresponding fitness
            [foil, ~] = pts2ind(temp_individual, wing.numEvalPts);
            gene_fitness = feval(task, wing, foil);

            %Only update the gene to the individual when the fitness
            %improve
            if gene_fitness < cur_fitness
                individual(gene) = new_individual(gene);
            end

        end

        %Calculate the fitness of the whole new individual
        [temp_foil, ~] = pts2ind(individual, wing.numEvalPts);
        new_fitness = feval(task, wing, temp_foil);


        if new_fitness <= cur_fitness
            s = s+1;
            cur_fitness = new_fitness;
    %         individual = new_individual;
        end

        if mod(t,p) == 0

            %Update the step size base on the period we currently are
            if s/p < 0.2
                step_size = step_size/gamma;
            else
                step_size = step_size*gamma;
            end
            s = 0;
        end

        %Back up the fitness to track the progress
        fitness(iGen) = cur_fitness;

        %Current status
%         disp(['Generation: ' num2str(iGen) ' - Fitness: ' num2str(cur_fitness) ])
        %Increate the time and generation index
        t = t + 1; iGen = iGen + 1;

        %Validating stoping condition
%         if cur_fitness < 1e-5
%             stop_criteria = true;
%         end

        %Visualize the individual
%         plot_foil(individual, wing)
    %     pause(0.5);


    end
end
