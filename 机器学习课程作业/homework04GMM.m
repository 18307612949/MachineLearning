
ccc
%% EM for GMM
%��������
data = load('krkonose.mat');

%gmmEM�㷨����
[model iter] = gmmEM(data,3);

%���ƺ�ľ�ֵ�� mu �Ա� 
EM_mu = model.mu 
true_mu = data.model.Mean

%����model��Э����Ա�
EM_E = model.E ;
true_E = data.model.Cov;


