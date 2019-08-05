function bit_rep = float2bit(individual)
    n = 1; %Number of bits for integer part
    m = 31; %Number of bits for fraction part of your number
    
    %Bitstring 
    %PEDING Analysis: Sometimes the bits are expressed as -1 or 1
    d2b = fix(rem(individual*pow2(-(n-1):m),2));

    %Float number
    b2d = d2b*pow2(n-1:-1:-m).';
    
    %Validation
    individual = round(individual,5);
    b2d = round(b2d,5);
    if ~(abs(individual-b2d) < eps(max(abs(individual), abs(b2d))))
        disp('Error in the representation')
        disp([num2str(individual),num2str(b2d)])
    end
    
    bit_rep = reshape(d2b.',1,[]);
    
    
    
end
