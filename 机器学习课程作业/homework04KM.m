ccc

%% 二维点
point_1 = [10;10];
point_2 = [20;40];
point_3 = [40;30];

num = 20;
points_1 = repmat(point_1,1,num)+10*rand(2,num);
points_2 = repmat(point_2,1,num)+10*rand(2,num);
points_3 = repmat(point_3,1,num)+10*rand(2,num);

%% 三维点
point_1 = [10;10;10];
point_2 = [20;40;30];
point_3 = [40;30;50];

num = 20;
points_1 = repmat(point_1,1,num)+10*rand(3,num);
points_2 = repmat(point_2,1,num)+10*rand(3,num);
points_3 = repmat(point_3,1,num)+10*rand(3,num);

%% 测试KM算法
%P = [points_1 points_2 points_3];
P = [points_1 points_2 points_3];
K = 3;
[best_Label best_Center best_ind label] = KM(P,K,'kmedoids');
 
%% 对Label中的分类信息画图
 plot_Graph(P,best_Label);
 title('从所有初始化中选取的最优分类')  
 %plot(best_Center(1,:),best_Center(2,:),'kp');
 axis([0 80 0 80])
