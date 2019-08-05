%%Testing the bitstring representation
% individual = rand(32,1)-0.5;
a = -0.487; %Test number

n = 1; %Number of bits for integer part
m = 25; %Number of bits for fraction part of your number

% for i=1:length(individual)
%     a = individual(i);
    %Binary number
    d2b = fix(rem(a*pow2(-(n-1):m),2));

    %Float number
    b2d = d2b*pow2(n-1:-1:-m).';
    a = round(a,5);
    b2d = round(b2d,5);
    if ~(abs(a-b2d) < eps(max(abs(a), abs(b2d))))
        disp('Error in the representation')
        disp([num2str(a) ' ' num2str(b2d)])
    end
% end

%% array implementation 
individual = rand(32,1)-0.5;
n = 1; %Number of bits for integer part
m = 15; %Number of bits for fraction part of your number
d2b = fix(rem(individual*pow2(-(n-1):m),2));

%Float number
b2d = d2b*pow2(n-1:-1:-m).';
individual = round(individual,5);
b2d = round(b2d,5);
if ~(abs(individual-b2d) < eps(max(abs(individual), abs(b2d))))
    disp('Error in the representation')
    disp([num2str(individual),num2str(b2d)])
end

%% Create a population of bitstrings
clear all; clc;
pop = rand(10,10) - 0.5;
for iPop = 1:size((pop),1)
    bitPop(iPop,:) = float2bit(pop(iPop,:)');
end

%% Revert the bits to float for the fitness calculation
for iPop = 1:size((pop),1)
    realPop(iPop,:) = bit2float(bitPop(iPop,:));
end
