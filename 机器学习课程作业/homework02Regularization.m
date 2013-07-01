

ccc

rand('seed',11)
% x_min = 0.1;
% x_max = 0.8;
% N = 100;
% train_num = round(N*0.75);

% x = linspace(x_min, x_max, N);
% %%%可选择
% %y = (1/4*x.^2+8*x+4);
% y = sin(2*pi*x);
% h = plot(x,y);
% %h=ezplot('sin(2*pi*x)-y');
% set(h, 'LineWidth', 3, 'Color','r')
% % axis([x_min x_max -1.4 1.4])
% 
% x = x + 0.01*(rand([1 N])-rand([1 N]));
% y = y + 0.1*(rand([1 N])-rand([1 N]));%用这个法子生成 [-1 1]之间的随机数  有更直接的方法么？
x_min = 1;
x_max = 10;

N =21;
train_num = round(N*0.70);

x = linspace(x_min, x_max, N);
%%%可选择
y = 0.1*(-1/2*x.^2+8*x+4);

% h = plot(x,y);
% set(h, 'LineWidth', 3, 'Color','r')

x = x + 0.2*(rand([1 N])-rand([1 N]));
y = y + 0.2*(rand([1 N])-rand([1 N]));%

%% 正则化
d = 7;  %%正则化 d 阶多项式
num = size(x,2);
X = x;
X_All = [ones(num,1) X' X.^2' X.^3' X.^4' X.^5' X.^6' X.^7' X.^8' X.^9' X.^10' X.^11'];

X_Reg = X_All(:,1:(d+1));%1 x^1 x^2 ... x^6
num = size(X_Reg,1);
train_num = round(N*0.7);
randindex = randperm(N);
X_tr = X_Reg(randindex(1:train_num),:);
Y_train = y(randindex(1:train_num))';
X_test = X_Reg(randindex((train_num+1):end),:);
Y_test = y(randindex((train_num+1):end))';


lines = {'r-','m-','c-','y-','g-','b-','w-','k-','m:','c:','r:','g:','b:','w:','k:',...
    'm-.','c-.','r-.','g-.','b-.','w-.','k-.','m--','c--','r--','g--','b--','w--','k--'};
n = size(X_Reg,2);

%%% 改变lambda的值
lambda = (-0.1):0.1:1;
lam_num = length(lambda);
J_train = zeros(lam_num,1);
J_test = zeros(lam_num,1);

I = zeros(n,n);
I(2:end,2:end) = eye(n-1);
maxlines = min(length(lines),size(lambda,2));
test_num = size(X_test,2);

option = struct('a',0.1, 'eps', 2e-3); % a:Learning Rate

figure(88)
for i=1:length(lambda)  
    %待修改
  
    disp(['%%----------lambda =  ' num2str(lambda(i)) ' -----------%%'])
    disp('%%-----计算theta...')
    option.lambda = lambda(i);      
    theta = (X_tr'*X_tr+lambda(i)*I)\(X_tr')*Y_train
    %[theta iter] = GradientDescentLinearReg(X_tr,Y_train,option)
     
    Y_tr = X_tr*theta;
    J_train(i,1) = 1/(2*train_num)*(Y_tr-Y_train)'*(Y_tr-Y_train);
    Y_te = X_test*theta;
    J_test(i,1) = 1/(2*test_num)*(Y_te-Y_test)'*(Y_te-Y_test);
    %%%绘制拟合曲线
    Y = X_Reg*theta;
    if i< maxlines
        hold on
        plot(x,Y,lines{i},'LineWidth',1.5);
    end       
end
figure(88),legend(num2str(lambda(1:maxlines)'))
hold on 
plot(X_tr(:,2),Y_train,'bo')



figure
h = plot(lambda,J_train,lambda,J_test);
set(h,'LineWidth',2)
legend('J_t_r_a_i_n(\theta)','J_t_e_s_t(\theta)')
xlabel('\lambda')
ylabel('Error')
title([num2str(d) '阶多项式拟合y=0.1*(-1/2*x.^2+8*x+4)' '加入正则化'])
