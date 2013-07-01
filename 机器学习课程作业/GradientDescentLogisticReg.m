function [theta iter] = GradientDescentLogisticReg(X,Y,option)
% Gradient descent for Logistic Regression
if nargin < 3
   option = struct(); 
end

if ~isfield(option, 'a')
    option.a = 0.01;
end
if ~isfield(option, 'eps')
    option.eps= 2e-4;
end
if ~isfield(option, 'lambda')
    Regularization = 0;
else
    lambda = option.lambda;
    Regularization = 1;
end
if ~isfield(option, 'maxiter')
    option.maxiter= 1000000;
end

a = option.a;
eps = option.eps;

[m n] = size(X);%����ά�� 

maxiter = option.maxiter;
iter = 0;
% ��ʼ��theta
thetak = zeros(n,1);
while iter < maxiter
    iter = iter+1;
    h_thetak = sigmodfun(X,thetak);%%
    GJ = 1/m*(X')*(h_thetak-Y); %J��theta���ݶ�
    % ����������Ϊ���ݶȱ仯��С
    if norm(GJ) < eps
        theta = thetak;
        break
    end    
    %����theta
    thetak = thetak - a*GJ; 
    if mod(iter,1000)==0
        disp(['========���е� ' num2str(iter) ' �ε���========='])
    end
end

if iter == maxiter
    disp(['   a=' num2str(a) '���ݶ��½�����δ�õ�������'])
    theta = thetak;
end

end

