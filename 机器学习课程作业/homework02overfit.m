

ccc

rand('seed',11)
% x_min = 0.1;
% x_max = 0.8;
x_min = 1;
x_max = 10;

N = 20;
train_num = round(N*0.70);

x = linspace(x_min, x_max, N);
%%%可选择
y = 0.1*(-1/2*x.^2+8*x+4);

% h = plot(x,y);
% set(h, 'LineWidth', 3, 'Color','r')

x = x + 0.02*(rand([1 N])-rand([1 N]));
y = y + 0.3*(rand([1 N])-rand([1 N]));%
% x = x + 0.01*(rand([1 N])-rand([1 N]));
% y = y + 0.1*(rand([1 N])-rand([1 N]));%用这个法子生成 [-1 1]之间的随机数  有更直接的方法么？
%% 随机选取点作为 train_data
randindex = randperm(N);
X_train = x(randindex(1:train_num));
Y_train = y(randindex(1:train_num))';
%%%余下部分作为 test_data
X_test = x(randindex((train_num+1):end));
Y_test = y(randindex((train_num+1):end))';
% hold on 
% plot(X_train,Y_train,'bo')%,X_test,Y_test,'bo'

%% 使用不同的多项式 
d = 11; %多项式的阶数d
%%%用来存储不同多项式拟合的误差J 
J_train=zeros(d,1);
J_test=zeros(d,1);

num = size(x,2);
X = x;
X_All = [ones(num,1) X' X.^2' X.^3' X.^4' X.^5' X.^6' X.^7' X.^8' X.^9' X.^10' X.^11'];

X_Train = X_All(randindex(1:train_num),:);
X_Test = X_All(randindex((train_num+1):end),:);

m = size(X_Train,1);

lines = {'r-','m-','c-','y-','g-','b-','w-','k-','m:','c:','r:','g:','b:','w:','k:',...
    'm-.','c-.','r-.','g-.','b-.','w-.','k-.','m--','c--','r--','g--','b--','w--','k--'};% 线的类型选择
% option = struct('a',0.1, 'eps', 2e-4); % a:Learning Rate
option = struct('a',1, 'eps', 2e-2, 'maxiter', 600000); % a:Learning Rate a = [0.001 0.004  0.1 0.2 0.6 0.8 1]
maxlines = min(length(lines),d);
figure(100)
for i=1:d
   % option.a = 0.4  % a = [0.01 0.003 0.00001 _4   ]
    X_tr = X_Train(:,1:(i+1)); %根据阶数选择不同维数的训练数据
    %%% 梯度下降方法  
    disp(['=============多项式阶数 ' num2str(i) ' =============='])  
    theta = (X_tr'*X_tr)\(X_tr')*Y_train; %Y_train 
   % [theta iter] = GradientDescentLinearReg(X_tr,Y_train,option) %步长a=0.1 
    
    Y_tr = X_tr*theta;
    J_train(i,1) = 1/(2*m)*(Y_tr-Y_train)'*(Y_tr-Y_train);
    Y_te = X_Test(:,1:(i+1))*theta;
    J_test(i,1) = 1/(2*size(X_test,2))*(Y_te-Y_test)'*(Y_te-Y_test);
    %%%绘制拟合曲线
    Y = X_All(:,1:(i+1))*theta;
    if i<maxlines   %
        hold on
        plot(x,Y,lines{i},'LineWidth',1.5);
    end
end
figure(100),legend(num2str((1:1:maxlines)'),'Location', 'NorthWest')
hold on 
plot(X_train,Y_train,'bo')%,X_test,Y_test,'bo'

figure
h = plot(1:d,J_train,1:d,J_test);
set(h,'LineWidth',2)
legend('J_t_r_a_i_n(\theta)','J_t_e_s_t(\theta)')
xlabel('degree of polynomial d')
ylabel('Error')


%%%======================================================================%%%
