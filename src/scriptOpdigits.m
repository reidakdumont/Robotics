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
kern = {{@linearKernel,0,'r'};{@polynomialKernel,2,'b'};...
    {@polynomialKernel,4,'y'};{@RBFKernel,2,'g'};...
    {@RBFKernel,4,'c'}; {@LaplacianRBFKernel,2,'m'};...
    {@LaplacianRBFKernel,4,'k'}};
for h=1:turn
    c = power(100,h);
    figure('name',strcat('c=',num2str(c)),'NumberTitle','off');
    matcell = cell(1,size(kern,1));
    for g=1:size(kern,1)
        error = 0;
        func = kern{g}{1};
        arg = kern{g}{2};
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
        bar(g,error, kern{g}{3});
        hold on;
        if kern{g}{2} > 0
            matcell{1,g} = strcat(func2str(kern{g}{1}), num2str(kern{g}{2}));
        else
            matcell{1,g} = func2str(kern{g}{1});
        end
    end
    legend(matcell);
end