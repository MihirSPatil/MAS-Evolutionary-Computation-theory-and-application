function float_rep = bit2float(bit_rep)
    n = 1; %Number of bits for integer part
    m = 31; %Number of bits for fraction part of your number
    
    bit_rep = reshape(bit_rep,m+n,length(bit_rep)/(m+n))';
    
    %Float number
    float_rep = bit_rep*pow2(n-1:-1:-m).';
      
end
