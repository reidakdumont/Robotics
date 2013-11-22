function [alpha, margin, Err] = Htrain(G, label,c)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [n,~] = size(G);
    f = -ones(n,1);
    H = (label(:)*label(:)').*G;
    Aeq = label(:)';
    beq = 0;
    lb = zeros(n,1);
    %ub = inf * ones(n,1);
    ub = c*ones(n,1);
    A = -eye(n);
    b = zeros(n,1);
    [alpha,fval,exitflag,output,lambda]  = quadprog(H,f,A,b,Aeq,beq,lb,ub);
    %[alpha,fval,exitflag,output,lambda]  = quadprog(H,f,A,b,Aeq,beq);
    margin = 2/(sqrt(alpha'*H*alpha));
    Err = exitflag;
end

