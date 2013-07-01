
ccc
%%%�������� x
m = 100;
xR = [3 15];
x = linspace(xR(1), xR(2), m);
%%% �������Բ���theta0 theta1 
theta0 = 1;
theta1 = 2;
y = theta0 + theta1*x + 0.8*(rand(1,m)-rand(1,m)); %�������
m = size(x,2);
%% ��׼�����ݸ�ʽ
X = [ones(m,1) x'];
Y = y';
disp(['==   Gradient Decent�����theta'])
option = struct('a',0.01, 'eps', 1e-4); % a:Learning Rate
% option.lambda = 0.01;
[thetaGD iter] = GradientDescentLinearReg(X,Y, option)  %GDLR:Gradient Decent for Linear Regression
plot(x,y,'ro')
disp(['==   ����������theta'])
theta = inv(X'*X)*X'*Y
refline(thetaGD(2),thetaGD(1))
title('y=\theta_0+\theta_1x')