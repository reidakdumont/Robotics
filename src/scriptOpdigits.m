close all;
clear;
genfichOptiTest;
genfichOptiTrain;
load('optdigitdata_test.mat');
load('optdigitdata_train.mat');

turn = 10;
func = @RBFKernel;
arg = 10;
c = 1;
for h=1:turn
    c = power(10,h-1);
    figure('name',strcat('c=',num2str(c)),'NumberTitle','off');
    for g=1:4
        error = 0;
        if g == 1
            func = @linearKernel;
        elseif g ==2
            func = @polynomialKernel;
            arg = 2;
        elseif g == 3
            func = @polynomialKernel;
            arg = 4;
        else
            func = @RBFKernel;
            arg = 2;
        end
        for i=1:size(DATAOPTDIGITTEST,2)
            inter = [min(LABELOPTDIGITTRAIN),max(LABELOPTDIGITTRAIN)];
            while inter(1) ~= inter(2)
                ind = find(LABELOPTDIGITTRAIN==inter(1) | LABELOPTDIGITTRAIN==inter(2));
                opdigit_data_train = zeros(size(DATAOPTDIGITTRAIN,1),size(ind,2));
                opdigit_label_train = zeros(1,size(ind,2));
                for j=1:size(ind,2)
                    opdigit_data_train(:,j) = DATAOPTDIGITTRAIN(:,ind(j));
                    if LABELOPTDIGITTRAIN(:,ind(j)) == inter(1)
                        opdigit_label_train(1,j) = 1;
                    else
                        opdigit_label_train(1,j) = -1;
                    end
                end
                [alpha, margin, Err] = KHtrain(opdigit_data_train,opdigit_label_train,func,c, arg);
                label = Kdecision(alpha, opdigit_data_train, DATAOPTDIGITTEST(:,i), opdigit_label_train,func, arg);
                if getClass(label) == 1
                    inter(2) = inter(2)-1;
                else
                    inter(1) = inter(1)+1;
                end
            end
            if inter(1) ~= LABELOPTDIGITTEST(1,i)
                error = error+1;
            end
        end
        error = error/size(iris_label_test,2)*100;
        if g == 1
            bar(g,error, 'r');
            hold on;
        elseif g ==2
            bar(g,error, 'b');
            hold on;
        elseif g == 3
            bar(g,error, 'y');
            hold on;
        else
            bar(g,error, 'g');
            hold on;
        end
    end
    legend('linearKernel','polynomialKernel 2','polynomialKernel 4','RBFKernel 2');
end