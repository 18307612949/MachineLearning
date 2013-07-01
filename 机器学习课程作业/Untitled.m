ccc

rand('seed',11)
% x_min = 0.1;
% x_max = 0.8;
x_min = 1;
x_max = 10;

N = 100;
train_num = round(N*0.70);

x = linspace(x_min, x_max, N);
%%%可选择
y = 0.02*x.*x+0.2*x+1;

% h = plot(x,y);
% set(h, 'LineWidth', 1.5, 'Color','r')


x = x + 0.2*(rand([1 N])-rand([1 N]));
y = y + (rand([1 N])-rand([1 N]));%


X = [ones(N,1) x' (x').^2];
Y = y';

randindex = randperm(N);
X = X(randindex(1:train_num),:);
x = x(randindex(1:train_num));
Y = y(randindex(1:train_num))';

w = inv(X'*X)*X'*Y
X1 = X(:,2:3);
Y1 = Y-mean(Y);
w1 = inv(X1'*X1)*X1'*Y1
Y_hat = X*w;

hold on 
plot(x,Y_hat,'bo')%,X_test,Y_test,'bo'
title('y=0.02x^2+0.2x+1')

x = x_min:0.01:x_max;
X = [ones(length(x),1) x' (x').^2];
Y = X*w;
hold on 
plot(x,Y,'r-')

% randindex = randperm(N);
% X_train = x(randindex(1:train_num));
% Y_train = y(randindex(1:train_num))';
% %%%余下部分作为 test_data
% X_test = x(randindex((train_num+1):end));
% Y_test = y(randindex((train_num+1):end))';










