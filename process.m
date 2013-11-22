function proc = process(alpha, dataTrain, data, label)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    proc = sign(decision(alpha,dataTrain,data,label));

end

