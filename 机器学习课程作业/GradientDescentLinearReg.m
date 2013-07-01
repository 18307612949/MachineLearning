function [theta iter] = GradientDescentLinearReg(X,Y,option)
% Gradient descent for linear regression

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

[m n] = size(X);%数据维数 

maxiter = option.maxiter;
iter = 0;
% 初始化theta
thetak = zeros(n,1);
if ~Regularization
    %%------------------非正则化迭代----------------%%
    while iter < maxiter
        iter = iter+1;
        GJ = 1/m*(X')*(X*thetak-Y); %J对theta的梯度
        % 结束条件设为：梯度变化较小 
        if norm(GJ) < eps 
            theta = thetak;
            break
        end
        %更新theta
        thetak = thetak - a*GJ;
    end
else
    %%------------------正则化迭代----------------%%
    rate = 1-a*lambda/m;
    while iter < maxiter
        iter = iter+1;
        GJ = 1/m*(X')*(X*thetak-Y);
        if norm(GJ) < eps
            theta = thetak;
            break
        end        
        thetak(1) = thetak(1)- a*GJ(1);        
        thetak(2:end) = thetak(2:end)*rate- a*GJ(2:end);
    end    
end

if iter == maxiter
    disp(['   a=' num2str(a) '的梯度下降方法未得到收敛解'])
    theta = thetak;
end

end

