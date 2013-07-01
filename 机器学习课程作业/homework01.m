
ccc
%%%生成数据 x
m = 100;
xR = [3 15];
x = linspace(xR(1), xR(2), m);
%%% 设置线性参数theta0 theta1 
theta0 = 1;
theta1 = 2;
y = theta0 + theta1*x + 0.8*(rand(1,m)-rand(1,m)); %添加噪声
m = size(x,2);
%% 标准化数据格式
X = [ones(m,1) x'];
Y = y';
disp(['==   Gradient Decent计算的theta'])
option = struct('a',0.01, 'eps', 1e-4); % a:Learning Rate
% option.lambda = 0.01;
[thetaGD iter] = GradientDescentLinearReg(X,Y, option)  %GDLR:Gradient Decent for Linear Regression
plot(x,y,'ro')
disp(['==   解析解计算的theta'])
theta = inv(X'*X)*X'*Y
refline(thetaGD(2),thetaGD(1))
title('y=\theta_0+\theta_1x')