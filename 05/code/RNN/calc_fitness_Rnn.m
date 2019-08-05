function fitness = calc_fitness_Rnn(wMat,p)
state = p.initialState;
nInputs = 3;
for step=1:p.totalSteps    
    %% Check that all states are legal
    onTrack = abs(state(1)) < 2.16;
    notFast = abs(state(2)) < 1.35;
    pole1Up = abs(state(3)) < pi/2;
    pole2Up = abs(state(5)) < pi/2;
    failureConditions = ~[onTrack notFast pole1Up pole2Up];
    
    if any(failureConditions)   
        fitness = step; break;
    else % Do the next time step
        
        
     if step == p.totalSteps
         fitness = p.totalSteps;
     end
     
        %% ACTION SELECTION [your code goes here]
        scaledInput = state./p.scaling; % Normalize state vector for ANN
        inputVector = [scaledInput(1) scaledInput(3) scaledInput(5)];

        nodeAct = zeros(p.nSample,p.nNode);
        nodeAct(1:nInputs) = inputVector;

        nodeAct = tanh(nodeAct*wMat); 
        nodeAct(1:nInputs) = inputVector;
        nodeAct = tanh(nodeAct*wMat);

        output = nodeAct(end);
        action = output*p.force; % Scale to full force
        
        %% SIMULATE RESULT
        % Take action and return new state:
        state = cart_pole2( state, action );   
        end
    end
end

