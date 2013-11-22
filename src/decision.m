function FEval = decision(alpha, dataTrain, data, label)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% decision = sum_i(alpha_i * y_i * <x_i,x> + b)
    [~,n] = size(data);
    ind = find(alpha ~= 0);
    n2 = size(ind,1);
    b = zeros(1,n2);
    for i=1:n2
        s1 = 0;
        for j=1:n2
            s1 = s1 + label(1,ind(i,1))*alpha(ind(j,1),1)*polynomialKernel(dataTrain(:,ind(i,1)),dataTrain(:,ind(j,1)),4);
        end
        b(1,i) = label(1,i)-s1;
    end
    b = 1/size(ind,1)*b;
    %w = alpha*label*transpose(dataTrain)*data;
    %b = 1/size(ind,1)*sum(label(:,ind) - w'*dataTrain(:,ind));
    FEval = zeros(1,n);
    for j=1:n
        s1 = 0;
        for i=1:n2
            s1 = s1 + label(1,ind(i,1))*alpha(ind(i,1),1)*polynomialKernel(data(:,j),dataTrain(:,ind(i,1)),4)+b(1,i);
        end
        FEval(1,j) = s1;
    end
    %FEval = w'*data+b;

end

