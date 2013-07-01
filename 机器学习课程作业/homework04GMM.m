
ccc
%% EM for GMM
%载入数据
data = load('krkonose.mat');

%gmmEM算法估计
[model iter] = gmmEM(data,3);

%估计后的均值点 mu 对比 
EM_mu = model.mu 
true_mu = data.model.Mean

%各个model的协方差对比
EM_E = model.E ;
true_E = data.model.Cov;


