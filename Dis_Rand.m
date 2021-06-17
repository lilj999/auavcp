%%%%%%%%%%%%%%%%%%%�������������豸����Դʱ����ƶ���������ӣ�������̾���Ĳ��%%%%%%%%%%%%%%%%
clear
N=30;%Ŀ�Ľڵ����
DepotN = 14;

window1 = 2;
window2 = 4;
window3 = 8;
window4 = 12;
window5 = 2;

%threshold = 0.5;
maxDistance = 16;%�����豸����Դʱ�����ƶ�����Զֱ�߾���
CorrectCount=zeros(1,maxDistance);
DepotX = 5*rand(1,DepotN)+3;
DepotY = 5*rand(1,DepotN)+3;

 G = Initial();
%%%%%%%%%%%����30�Σ���10�ΰ��ձ��㷨��դ��������������ɵ�Ŀ��ڵ�ľ�������̾�����ƽ��ֵ%%%%%%%%%%%%
for times = 1:30
    Smin(times)=0;%���ڵ���̾��루ֱ�����Ӿ��룩
    SSmin=0;
    shortestdis = zeros(1,N-1);
    DX=5*rand(1,N)+3;%������ʼ���ʼ�ڵ������
    DY=5*rand(1,N)+3;%������ʼ���ʼ�ڵ�������
    %ȷ�ϸ��ڵ����̾���
    X=[DX' DY'];
    L=pdist(X);
    LM=squareform(L);
    for i = 1:N-1
        Smin(times) = Smin(times) + LM(i,i+1);  
    end
    
    for p = 1:maxDistance
        c = 1.4 + p/10;
        C(p) = c;
  

   %%%%%%%%%%%%%%��չդ��ڵ���ڽӾ���%%%%%%%%%%%
        G = RandomExtend(c,G,DepotX,DepotY,DepotN);
        
        %%%%%%%%%%Ѱ�ҽڵ���ھӽڵ�%%%%%%%%%%
        [neighborX,neighborY] = RandomCalNeighbor(DX,DY,N,c,DepotX,DepotY,DepotN);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%%����ڵ����豣��������%%%%%%%%%%
        remain = CalRemain(neighborX,neighborY,DX,DY,N);
        remain_temp = remain;
        remain_fill = (c/2) * ones(1,N);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Gtemp = G;
        %%%%%%%%%%���㿼����Դ����������µ���̾���%%%%%%%%%%
%         [Dist1,Path1,remain,shortestdis1,hops1] = RandomSlidingW(Gtemp,DX,DY,c,remain,N,window1,DepotX,DepotY,DepotN);%offline
%         remain = remain_temp;
%         Gtemp = G;
        Dist1 = 0;
        for i = 1:N-1
            Dist1 = dist(DX(i),DY(i),DX(i+1),DY(i+1)) + Dist1;
        end
        [Dist2,Path2,remain,shortestdis2,hops2] = RandomSlidingW(Gtemp,DX,DY,c,remain,N,window2,DepotX,DepotY,DepotN);%online4
        remain = remain_temp;
        Gtemp = G;
        [Dist3,Path3,remain,shortestdis3,hops3] = RandomSlidingW(Gtemp,DX,DY,c,remain,N,window3,DepotX,DepotY,DepotN);%online8
        remain = remain_temp;
        Gtemp = G;
        [Dist4,Path4,remain,shortestdis4,hops4] = RandomSlidingW(Gtemp,DX,DY,c,remain,N,window4,DepotX,DepotY,DepotN);%online12
        remain = remain_temp;
        Gtemp = G;
        [Dist5,Path5,remain_fill,shortestdis5,hops5] = RandomSlidingW(Gtemp,DX,DY,c,remain_fill,N,window5,DepotX,DepotY,DepotN);%fill
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Dis1(times,p) = Dist1;
        Dis2(times,p) = sum(shortestdis2);
        Dis3(times,p) = sum(shortestdis3);
        Dis4(times,p) = sum(shortestdis4);
        Dis5(times,p) = sum(shortestdis5);
        %dif(times,p) = sum(shortestdis) - Smin(times);
        %RelativeError(times,p) = dif(times,p)/Smin(times);
    end
end
t = [0.1 0.2 0.3 0.5 0.8 1.0 1.2 1.5 1.8 2.0];
SSmin = sum(Smin)/times;
%diff=sum(dif)/times;
%Relative = sum(RelativeError)/times;
Result1 = sum(Dis1)/times;
Result2 = sum(Dis2)/times;
Result3 = sum(Dis3)/times;
Result4 = sum(Dis4)/times;
Result5 = sum(Dis5)/times;
% figure(1)
% plot(C,diff,'r*-.')
% xlabel('The maximum distance when the vehicle is full of energy C');
% ylabel('Absolute error');
% hold on 
figure(3)
plot(C,Result1,'k*-')
xlabel('The maximum distance when the vehicle is full of energy C');
ylabel('Relative error');
hold on 
plot(C,Result2,'ks-')
plot(C,Result3,'ks--')
plot(C,Result4,'ks-.')
plot(C,Result5,'k^-')
% figure(3)
% totaltime = sum(shortestdis) + hops*t;
% plot(t,totaltime,'r*-.');
% xlabel('The time spent at each fuel station');
% ylabel('The total time to traverse all the target nodes');
% hold on
%title('����Դʱ�����ƶ����롪���㷨���þ�������̾����ֵ')
