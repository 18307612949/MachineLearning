function plot_Graph(P,Label)

[d N] = size(P);


if     d==2
    plot_Graph_2D(P,Label)
elseif d==3
    plot_Graph_3D(P,Label)
else
    disp('###无法使用图像显示P###')
   return 
end


function plot_Graph_2D(P,Label)
figure
subplot(1,2,1)
hold on
plot(P(1,:),P(2,:),'r*')
K = max(Label);
subplot(1,2,2)

% for k=1:K
%     Pk = P(:,find(Label==k));
%     plot(Pi(1,:),Pi(2,:),'go');
%     hold on
% end
Pi = P(:,find(Label==1));
     plot(Pi(1,:),Pi(2,:),'go');
     hold on
Pi = P(:,find(Label==2));
plot(Pi(1,:),Pi(2,:),'r+');
hold on 
Pi = P(:,find(Label==3));
plot(Pi(1,:),Pi(2,:),'md');

function plot_Graph_3D(P,Label)
figure
subplot(1,2,1)
plot3(P(1,:),P(2,:),P(3,:),'r*')

subplot(1,2,2)
Pi = P(:,find(Label==1));
plot3(Pi(1,:),Pi(2,:),Pi(3,:),'go');
hold on 
Pi = P(:,find(Label==2));
plot3(Pi(1,:),Pi(2,:),Pi(3,:),'r+');
hold on 
Pi = P(:,find(Label==3));
plot3(Pi(1,:),Pi(2,:),Pi(3,:),'md');

