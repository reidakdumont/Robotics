close all;
clear;
genfich;
genfichOpti;
Xtemp = DATAIRIS;
Ytemp = LABELIRIS;
X = [1 1 0 0;
     0 1 0 1];
Y = [1 -1 -1 1];
turn = 10;
func = @RBFKernel;
arg = 10;
c = 1;
for h=1:turn
    c = power(10,h-1);
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
        [alpha1, margin1, Err1] = KHtrain(iris_data_1_2_train,iris_label_1_2_train,func,c, arg);
        [alpha2, margin2, Err2] = KHtrain(iris_data_1_3_train,iris_label_1_3_train,func,c, arg);
        [alpha3, margin3, Err3] = KHtrain(iris_data_2_3_train,iris_label_2_3_train,func,c, arg);
        %alpha1
        %alpha2
        %alpha3
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
            label = Kdecision(alpha1, iris_data_1_2_train, iris_data_test(:,i), iris_label_1_2_train,func, arg);
            if getClass(label) == 1
                label = Kdecision(alpha2, iris_data_1_3_train, iris_data_test(:,i), iris_label_1_3_train,func, arg);
                if getClass(label) ~= iris_label_test(1,i)
                   error = error+1;
                end
            else
                label = Kdecision(alpha3, iris_data_2_3_train, iris_data_test(:,i), iris_label_2_3_train,func, arg);
                if getClass(label) ~= iris_label_test(1,i)
                   error = error+1;
                end
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
%plotKSVMfig(alpha, X, -10, 10, -10, 10, Y,func, arg)