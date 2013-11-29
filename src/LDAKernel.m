function out = LDAKernel(data, label, kernel, argsup)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    uniquelabel = unique(label);
    nblabel = size(uniquelabel,2);
    for j=1:nblabel
        idx = find(label == uniquelabel(1,j));
        d = data(:,idx);
        for i=1:size(data,2)
            for k=1:size(d,2)
                Ktemp(i,k) = kernel(data(:,i),d(:,k),argsup);
            end
        end
        K{j} = Ktemp;
        rat{j} = eye(size(d,2)) -  1 / size(d,2) * ones(size(d,2),size(d,2));
    end
    
    %Calcul de N qui est égale à la matrice intra-classe
    N = 0;
    for j=1:nblabel
        N = N + K{j}*rat{j}*transpose(K{j});
    end
    
    %Calcul de M qui est égale à la matrice inter-classe
    M = 0;
    for j=1:nblabel
        idx = find(label == uniquelabel(1,j));
        d = data(:,idx);
        Mstar{j} = 0;
        for i=1:size(data,2)
            Mstar{j} = Mstar{j} + kernel(d, data(:,i),argsup);
        end
        Mstar{j} = Mstar{j}/size(data,2);
        
        for i=1:nblabel
            idx = find(label == uniquelabel(1,i));
            d2 = data(:,idx);
            s = 0;
            for h=1:size(d2,2)
                s = s + kernel(d, d2(:,h),argsup)/size(idx,2);
            end
        end
        tempM{j} = s;
        idx = find(label == uniquelabel(1,j));
        d = data(:,idx);
        li = size(d,2);
        M = M + li*(tempM{j}-Mstar{j})*transpose((tempM{j}-Mstar{j}));
    end
    out = 0;
    
    %Calcul des valeurs propres
    Astar = eig(inv(N)*repmat(M,nblabel,nblabel));
    
    %Calcul de la projection pour chaque donnée
    for t=1:size(data,2)
        K{t} = kernel(data, data(:,t));
        out(t) = transpose(Astar)*K{t};
    end
end

