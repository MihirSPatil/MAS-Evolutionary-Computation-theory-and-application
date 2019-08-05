function fitness = calc_fitness(wMat,p)
state = p.initialState;

for step=1:p.totalSteps    
    %% Check that all states are legal
    onTrack = abs(state(1)) < 2.16;
    notFast = abs(state(2)) < 1.35;
    pole1Up = abs(state(3)) < pi/2;
    pole2Up = abs(state(5)) < pi/2;    %replace true with the commented formula when running for two poles
    failureConditions = ~[onTrack notFast pole1Up pole2Up];
    
    if any(failureConditions)   
        fitness = step; break;
    else % Do the next time step
        
        
     if step == p.totalSteps
         fitness = p.totalSteps;
     end
     
        %% ACTION SELECTION [your code goes here]
        scaledInput = state./p.scaling; % Normalize state vector for ANN
        inputVector = scaledInput';

        nodeAct = zeros(p.nSample,p.nNode);
        nodeAct(1:p.nInputs) = inputVector;

        for iNode = (p.nInputs+1):p.nNode
            % Here we compute the activation of a node by applying only the 
            % relevant column of the weight matrix, and then apply the
            % activation function, in this case 'tanh', to the result.
           nodeAct(iNode) = tanh(nodeAct*wMat(:,iNode)); 
        end
        output = nodeAct(end);
        action = output*p.force; % Scale to full force
        
        %% SIMULATE RESULT
        % Take action and return new state:
%         state = cart_pole1( state, action ); %comment this when running for two poles
        state = cart_pole2( state, action ); %uncomment this line when
%         running for two poles
        end
    end
end

