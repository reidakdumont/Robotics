function G = polynomialKernel(X,Y,d)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    G = power((transpose(X)*Y+1),d);

end

