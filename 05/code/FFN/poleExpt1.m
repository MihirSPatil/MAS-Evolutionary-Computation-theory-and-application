function poleExpt1
clear all; clc;
%% Initialize the values
p.totalSteps = 1000;
p.initialState = [0 0 .017 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
p.scaling = [ 2.4 10.0 0.628329 5 ]'; % Divide state vector by this to scale state to numbers between 1 and 0
p.state = p.initialState;
p.force = 10;
p.nSample =1;
p.nInputs = length(p.initialState); 
p.nHidden = 3; 
p.nOutputs = 1; 
p.nNode = p.nInputs+p.nHidden+p.nOutputs;
fwMat = zeros(p.nNode);
fig = figure(1);
%% Getting the weight matrix and fitness

[fitness, wMat] = CMA_ES_EP(p)
save('spb.mat','wMat','fitness')
state = p.initialState;
%% Visualize result (optional and slow, don't use all the time!)

for step=1:p.totalSteps    

        scaledInput = state./p.scaling; % Normalize state vector for ANN
        inputVector = scaledInput';

        nodeAct = zeros(p.nSample,p.nNode);
        nodeAct(1:p.nInputs) = inputVector;

        for iNode = (p.nInputs+1):p.nNode
            % Here we compute the activation of a node by applying only the 
            % relevant column of the weight matrix, and then apply the
            % activation function, in this case 'tanh', to the result.
           nodeAct(iNode) = tanh(nodeAct*fwMat(:,iNode)); 
        end
        output = nodeAct(end);
        action = output*p.force; % Scale to full force
        disp(step)
%% SIMULATE RESULT
        % Take action and return new state:
        state = cart_pole1( state, action );   
% %% Visualize the pole
%         %clf
%         cpvisual(fig, 1, state(1:4), [-3 3 0 2], action );         % Pole 1
%         cpvisual(fig, 0.5, state([1 2 5 6]), [-3 3 0 2], action );% Pole 2
%         pause(0.02);
% disp(toc) 
end
