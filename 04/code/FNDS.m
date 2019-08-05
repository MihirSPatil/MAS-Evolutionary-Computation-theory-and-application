function [individuals, F] = FNDS(individuals)
% function to perform the non-dominated sort
%% initialize the variables 
F{1} = [];
n = size(individuals,1);
%% begin the sorting procedure, obtain the values for Sp and Np for each solution
for ip = 1:n
    individuals(ip).sp = [];
    individuals(ip).np = 0;
    for iq = 1:n
        if ip ~= iq
            if dom_validator(ip, iq, individuals)
                individuals(ip).sp = [individuals(ip).sp; iq];
            elseif dom_validator(iq, ip, individuals)
                individuals(ip).np = individuals(ip).np + 1;
            end
        end
    end
    
    if individuals(ip).np == 0
        individuals(ip).rank = 1;
        F{1} = [F{1}; ip];
    end
end   

%% calculate pareto rank of each individuals
iFront = 1;
while true
    Q = [];
    
    for i=1:numel(F{iFront})
        p = individuals(F{iFront}(i));
        for j = 1:numel(p.sp)
            q = individuals(p.sp(j));
            q.np = q.np - 1;
            
            if q.np == 0
                q.rank = iFront + 1;
                Q = [Q; p.sp(j)];
            end
            individuals(p.sp(j)) = q;           
        end
    end
    
    if isempty(Q)
        break;
    end
    
    iFront = iFront +1;
    F{iFront} = Q;
    
end
end