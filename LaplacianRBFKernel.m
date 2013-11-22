function K = LaplacianRBFKernel(X,X2,gamma)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    sigma = 1/gamma;
    n1sq = sum(X.^2,1);
    n1 = size(X,2);

    if isempty(X2);
        D = (ones(n1,1)*n1sq)' + ones(n1,1)*n1sq -2*X'*X;
    else
        n2sq = sum(X2.^2,1);
        n2 = size(X2,2);
        D = (ones(n2,1)*n1sq)' + ones(n1,1)*n2sq -2*X'*X2;
    end;
    K = exp(-sqrt(D)/(2*sigma^2));
end

