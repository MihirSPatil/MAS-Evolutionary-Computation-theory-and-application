function fitness = mean_square(wing, foil)
    [~,errorTop] =    dsearchn(wing.nacafoil(:,1:end/2)'    ,foil(:,1:end/2)');
    [~,errorBottom] = dsearchn(wing.nacafoil(:,1+end/2:end)',foil(:,1+end/2:end)');

    % Total fitness (mean squared error)
    fitness = mean([errorTop.^2; errorBottom.^2]);
end