close all;
clear all;
genfich;

%Calcul du kernel LDA
out = LDAKernel(DATAIRIS,LABELIRIS, @linearKernel, -1);

%Benchmark de test des kernels
turn = 6;
func = @RBFKernel;
arg = 1/0.01;
c = 1;
kern = {{@linearKernel,0,'r'};{@polynomialKernel,2,'b'};...
    {@polynomialKernel,4,'y'};{@RBFKernel,2,'g'};...
    {@RBFKernel,4,'c'}; {@LaplacianRBFKernel,2,'m'};...
    {@LaplacianRBFKernel,4,'k'}};
for h=1:turn
    if h ~= turn
        c = power(10,h-1);
    else
        c = inf;
    end
    figure('name',strcat('c=',num2str(c)),'NumberTitle','off');
    ind = find(LABELIRIS==1 | LABELIRIS==2);
    iris_data_1_2 = zeros(size(DATAIRIS,1),size(ind,2));
    iris_label_1_2 = zeros(1,size(ind,2));
    for i=1:size(ind,2)
        iris_data_1_2(:,i) = DATAIRIS(:,ind(i));
        if LABELIRIS(:,ind(i)) == 1
            iris_label_1_2(1,i) = 1;
        else
            iris_label_1_2(1,i) = -1;
        end
    end
    idx = randperm(length(iris_data_1_2));
    iris_data_1_2 = iris_data_1_2(:,idx);
    iris_label_1_2 = iris_label_1_2(:,idx);
    iris_data_1_2_train = zeros(size(DATAIRIS,1),size(ind,2)/2);
    iris_data_1_2_test = zeros(size(DATAIRIS,1),size(ind,2)/2);
    iris_label_1_2_train = zeros(size(LABELIRIS,1),size(ind,2)/2);
    iris_label_1_2_test = zeros(size(LABELIRIS,1),size(ind,2)/2);
    for i=1:size(ind,2)/2
        iris_data_1_2_train(:,i) = iris_data_1_2(:,i);
        iris_data_1_2_test(:,i) = iris_data_1_2(:,i+size(ind,2)/2);
        iris_label_1_2_train(:,i) = iris_label_1_2(:,i);
        iris_label_1_2_test(:,i) = iris_label_1_2(:,i+size(ind,2)/2);
    end

    ind = find(LABELIRIS==1 | LABELIRIS==3);
    iris_data_1_3 = zeros(size(DATAIRIS,1),size(ind,2));
    iris_label_1_3 = zeros(1,size(ind,2));
    for i=1:size(ind,2)
        iris_data_1_3(:,i) = DATAIRIS(:,ind(i));
        if LABELIRIS(:,ind(i)) == 1
            iris_label_1_3(1,i) = 1;
        else
            iris_label_1_3(1,i) = -1;
        end
    end
    idx = randperm(length(iris_data_1_3));
    iris_data_1_3 = iris_data_1_3(:,idx);
    iris_label_1_3 = iris_label_1_3(:,idx);
    iris_data_1_3_train = zeros(size(DATAIRIS,1),size(ind,2)/2);
    iris_data_1_3_test = zeros(size(DATAIRIS,1),size(ind,2)/2);
    iris_label_1_3_train = zeros(size(LABELIRIS,1),size(ind,2)/2);
    iris_label_1_3_test = zeros(size(LABELIRIS,1),size(ind,2)/2);
    for i=1:size(ind,2)/2
        iris_data_1_3_train(:,i) = iris_data_1_3(:,i);
        iris_data_1_3_test(:,i) = iris_data_1_3(:,i+size(ind,2)/2);
        iris_label_1_3_train(:,i) = iris_label_1_3(:,i);
        iris_label_1_3_test(:,i) = iris_label_1_3(:,i+size(ind,2)/2);
    end

    ind = find(LABELIRIS==2 | LABELIRIS==3);
    iris_data_2_3 = zeros(size(DATAIRIS,1),size(ind,2));
    iris_label_2_3 = zeros(1,size(ind,2));
    for i=1:size(ind,2)
        iris_data_2_3(:,i) = DATAIRIS(:,ind(i));
        if LABELIRIS(:,ind(i)) == 2
            iris_label_2_3(1,i) = 1;
        else
            iris_label_2_3(1,i) = -1;
        end
    end
    idx = randperm(length(iris_data_2_3));
    iris_data_2_3 = iris_data_2_3(:,idx);
    iris_label_2_3 = iris_label_2_3(:,idx);
    iris_data_2_3_train = zeros(size(DATAIRIS,1),size(ind,2)/2);
    iris_data_2_3_test = zeros(size(DATAIRIS,1),size(ind,2)/2);
    iris_label_2_3_train = zeros(size(LABELIRIS,1),size(ind,2)/2);
    iris_label_2_3_test = zeros(size(LABELIRIS,1),size(ind,2)/2);
    for i=1:size(ind,2)/2
        iris_data_2_3_train(:,i) = iris_data_2_3(:,i);
        iris_data_2_3_test(:,i) = iris_data_2_3(:,i+size(ind,2)/2);
        iris_label_2_3_train(:,i) = iris_label_2_3(:,i);
        iris_label_2_3_test(:,i) = iris_label_2_3(:,i+size(ind,2)/2);
    end
    matcell = cell(1,size(kern,1));
    for g=1:size(kern,1)
        error = 0;
        func = kern{g}{1};
        arg = kern{g}{2};
        iris_data_test = zeros(size(DATAIRIS,1),size(iris_data_1_2_test,2)+size(iris_data_1_3_test,2)+size(iris_data_2_3_test,2));
        iris_label_test = zeros(size(LABELIRIS,1),size(iris_label_1_2_test,2)+size(iris_label_1_3_test,2)+size(iris_label_2_3_test,2));
        idx = randperm(length(iris_data_test));
        iris_data_test = iris_data_test(:,idx);
        iris_label_test = iris_label_test(:,idx);
        for i=1:size(ind,2)/2
            iris_data_test(:,i) = iris_data_1_2_test(:,i);
            iris_data_test(:,i+size(ind,2)/2) = iris_data_1_3_test(:,i);
            iris_data_test(:,i+size(ind,2)) = iris_data_2_3_test(:,i);
            iris_label_test(:,i) = iris_label_1_2_test(:,i);
            iris_label_test(:,i+size(ind,2)/2) = iris_label_1_3_test(:,i);
            iris_label_test(:,i+size(ind,2)) = iris_label_2_3_test(:,i);
        end
        for i=1:size(iris_data_test,2)
            [alpha1, margin1, Err1] = KHtrain(iris_data_1_2_train,iris_label_1_2_train,func,c, arg);
            label = Kdecision(alpha1, iris_data_1_2_train, iris_data_test(:,i), iris_label_1_2_train,func, arg);
            if getClass(label) == 1
                [alpha2, margin2, Err2] = KHtrain(iris_data_1_3_train,iris_label_1_3_train,func,c, arg);
                label = Kdecision(alpha2, iris_data_1_3_train, iris_data_test(:,i), iris_label_1_3_train,func, arg);
                if getClass(label) ~= iris_label_test(1,i)
                   error = error+1;
                end
            else
                [alpha3, margin3, Err3] = KHtrain(iris_data_2_3_train,iris_label_2_3_train,func,c, arg);
                label = Kdecision(alpha3, iris_data_2_3_train, iris_data_test(:,i), iris_label_2_3_train,func, arg);
                if getClass(label) ~= iris_label_test(1,i)
                   error = error+1;
                end
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
%plotKSVMfig(alpha, X, -10, 10, -10, 10, Y,func, arg)