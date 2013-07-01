
ccc

data = load('riply_trn'); 

X =data.X;
Y = data.y;Y(Y==2)=0;Y=Y';
X1 = X(:,Y==1);  X0 = X(:,Y==0);
figure
plot(X1(1,:),X1(2,:),'bo')
hold on
plot(X0(1,:),X0(2,:),'r*')
title('riply点集')
hold off

X_tr=[ones(size(X,2),1) X'];
%h = sigmodfun(X,[1 1 1]');

option.a = 0.5; %Learning Rate
[theta iter] = GradientDescentLogisticReg(X_tr,Y,option);

prob = sigmodfun(X_tr,theta);

true_Label = Y;
a = 0.02;
b = 1;
threshold = 0:a:b; %不同的threshold
plotROC(true_Label,prob,threshold);


