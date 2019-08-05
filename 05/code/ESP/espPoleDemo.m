clc;
clear all;
fig = figure(1);
totalSteps = 2000;
initialState = [0 0 .017 0 0.0 0]';
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]';
state = initialState;
p.simParams.force = 10;
gensize = 500 ;
weights = esp(9,9,gensize);

for step = 1:totalSteps
    %% Check that all states are legal
    onTrack = abs(state(1)) < 2.16;
    notFast = abs(state(2)) < 1.35;
    pole1Up = abs(state(3)) < pi/2;
    pole2Up = abs(state(5)) < pi/2;
    failureConditions = ~[onTrack notFast pole1Up pole2Up];
    if any(failureConditions)   
        fitness = step
        break;
    else
        % Do the next time step
        scaledInput = state./scaling;
        output = rnn(scaledInput,weights);
        action = output*p.simParams.force;
        % visualization
        state = cart_pole2( state, action );
%         cpvisual(fig, 1, state(1:4), [-3 3 0 2], action ); 
%         cpvisual(fig, 0.5, state([1 2 5 6]), [-3 3 0 2], action );% Pole 2 
%         pause(0.02);
    end
    step
end