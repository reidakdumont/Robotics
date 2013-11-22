function [alpha, margin, Err] = KHtrain(data, label, kernel,c, argsup)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    G = kernel(data,data,argsup);
    [n,~] = size(G);
    f = -ones(n,1);
    H = (label(:)*label(:)').*G;
    Aeq = label(:)';
    beq = 0;
    lb = zeros(n,1);
    %ub = inf * ones(n,1);
    ub = c*ones(n,1);
    A = [];
    b = [];
    [alpha,fval,stat,Nabla]  = gsmo(H,f,Aeq',beq,lb,ub);
    %[alpha,fval,exitflag,output,lambda]  = quadprog(H,f,A,b,Aeq,beq);
    margin = 2/(sqrt(alpha'*H*alpha));
    Err = stat.exitflag;

end

