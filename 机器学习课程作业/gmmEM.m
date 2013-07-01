function  [model iter] = gmmEM(data,K,option)
%
% K 为model数
% Reference: PRML p438-439
tic 
if nargin < 3
    option.eps = 1e-12;
    option.maxiter = 1000;
    
end

global num_data K
X = data.X;  %X为D*N型数据，跟PRML对样本数据描述相反
[dim num_data] = size(X);

%Initialize
%-------------------------------
%K = numel(unique(data.y));
[inx, C,~] = kmeans(X',K);
mu = C';
pai = zeros(1,K);
E = zeros(dim,dim,K);
for k=1:K
    pai(k) = sum(inx==k);   
    E(:,:,k) = eye(dim);
end
pai = pai/num_data;

iter = 0;
log_val = logGMM(X,mu,E,pai);

while   iter<option.maxiter     
    iter = iter+1;
    % E step 
    Yz = compu_Yz(X,mu,E,pai);    
    % M step 
    NK = sum(Yz);
    for k = 1:K
        mu(:,k) = 1/NK(k)*X*Yz(:,k);
        Ek = zeros(dim,dim);
        for n=1:num_data
            Ek = Ek + Yz(n,k)*(X(:,n)-mu(:,k))*(X(:,n)-mu(:,k))';
        end
        E(:,:,k) = 1/NK(k)*Ek;        
    end
    pai = NK/num_data;
    %检查是否收敛  
    log_val_new = logGMM(X,mu,E,pai);
    if abs(log_val_new-log_val) < option.eps        
        model.Yz = Yz;
        model.mu = mu;
        model.E = E;
        model.iter = iter;
        break
    end
    log_val = log_val_new;
    if mod(iter,10)==0
        disp(['-----进行第' num2str(iter) '迭代...'])
    end
end
if iter==option.maxiter
    fprintf('达到最大迭代次数%d',maxiter)
    model.Yz = Yz;
    model.mu = mu;
    model.E = E;
    model.iter = iter;
end
toc
%model.usedTime = toc-tic;
end

%------------------------------------
function val = logGMM(X,mu,E,pai)
global num_data K
val = 0;
%N = size(X,2);
%K = size(mu,2);
for n=1:num_data
    tmp = 0;
    for k=1:K        
        p = mvnpdf(X(:,n),mu(:,k),E(:,:,k));
        tmp = tmp+pai(k)*p;
    end
    val = val + log(tmp);
end
end

%---------------------------------------------------------------
function Yz = compu_Yz(X,mu,E,pai)
    global num_data K
    Yz = zeros(num_data,K);
    for n = 1:num_data
        Y_nK = zeros(1,K);
        for k=1:K
            Y_nK(k) = pai(k)*mvnpdf(X(:,n),mu(:,k),E(:,:,k));
        end
        Yz(n,:) = Y_nK/sum(Y_nK);
    end
end
