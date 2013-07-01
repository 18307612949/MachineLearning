function plotROC(true_Label,pro,threshold)

num = length(threshold);
num_p = sum(true_Label==1);
num_n = sum(true_Label==0);

TP = zeros(1,num);
FP = zeros(1,num);

M = zeros(2,num);
for i=1:num
    %%%判别  类别  Label
    Labeli = pro>=threshold(i);
    M(1,i) = sum(Labeli.*true_Label==1);  %TP数
    M(2,i) = sum((Labeli+true_Label)==0); % TN数 
end
TP = M(1,:)./num_p;
FP = 1-M(2,:)./num_n;
figure
plot(FP,TP,'r*')
hold on
plot(FP,TP,'b-','LineWidth',1.5)
hold on 
plot([0 1],[0 1],'c-','LineWidth',1.5)
title('Logistic Regression ROC curve')
xlabel('False Positives rate')
ylabel('True Positives rate')

C = [TP;FP]-repmat([1;0],1,num);
[val index] = min(diag(C'*C));
hold on
plot(FP(index),TP(index),'gp','MarkerSize',15)

end