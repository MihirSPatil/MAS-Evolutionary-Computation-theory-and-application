function output = rnn(state,weights)
inputVector = [state(1) state(3) state(5)];
nSample = 1;
nInputs = 3; nHidden = 5; nOutputs = 1;
nNode = nInputs+nHidden+nOutputs;
wMat = reshape(weights,[nNode,nNode])';
nodeAct = zeros(nSample,nNode);
nodeAct(1:nInputs) = inputVector;
nodeAct = tanh(nodeAct*wMat); 
nodeAct(1:nInputs) = inputVector;
nodeAct = tanh(nodeAct*wMat);
output = nodeAct(end);
end
