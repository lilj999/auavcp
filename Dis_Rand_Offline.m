%%%%%%%%%%%%%%%%%%%计算随着无人设备满能源时最大移动距离的增加，其与最短距离的差距%%%%%%%%%%%%%%%%
clear
N=15;%目的节点个数
DepotN = 14;
window = 15;
%threshold = 0.5;
maxDistance = 16;%无人设备满能源时所能移动的最远直线距离
CorrectCount=zeros(1,maxDistance);
DepotX = 5*rand(1,DepotN)+3;
DepotY = 5*rand(1,DepotN)+3;

 G = Initial();
%%%%%%%%%%%运行30次，求10次按照本算法在栅格网络中随机生成的目标节点的距离与最短距离差的平均值%%%%%%%%%%%%
for times = 1:30
    Smin(times)=0;%各节点最短距离（直线连接距离）
    SSmin=0;
    shortestdis = zeros(1,N-1);
    DX=5*rand(1,N)+3;%生成起始与初始节点横坐标
    DY=5*rand(1,N)+3;%生成起始与初始节点纵坐标
    %确认各节点的最短距离
    X=[DX' DY'];
    L=pdist(X);
    LM=squareform(L);
    for i = 1:N-1
        Smin(times) = Smin(times) + LM(i,i+1);  
    end

    for p = 1:maxDistance
        c = 1.4 + p/10;
        C(p) = c;
   %%%%%%%%%%%%%%扩展栅格节点的邻接矩阵%%%%%%%%%%%
        G = RandomExtend(c,G,DepotX,DepotY,DepotN);
        
        %%%%%%%%%%寻找节点的邻居节点%%%%%%%%%%
        [neighborX,neighborY] = RandomCalNeighbor(DX,DY,N,c,DepotX,DepotY,DepotN);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%%计算节点所需保留的能量%%%%%%%%%%
        remain = CalRemain(neighborX,neighborY,DX,DY,N);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Gtemp = G;
        %%%%%%%%%%计算考虑能源补给的情况下的最短距离%%%%%%%%%%
        [Dist,Path,remain,shortestdis,hops] = RandomSlidingW(Gtemp,DX,DY,c,remain,N,window,DepotX,DepotY,DepotN);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        dif(times,p) = sum(shortestdis) - Smin(times);
        RelativeError(times,p) = dif(times,p)/Smin(times);
    end
end
t = [0.1 0.2 0.3 0.5 0.8 1.0 1.2 1.5 1.8 2.0];
SSmin = sum(Smin)/times;
diff=sum(dif)/times;
Relative = sum(RelativeError)/times;
% figure(1)
% plot(C,diff,'r*-.')
% xlabel('The maximum distance when the vehicle is full of energy C');
% ylabel('Absolute error');
% hold on 
figure(1)
plot(C,Relative,'k^--')
xlabel('The maximum distance when the vehicle is full of energy C');
%ylabel('Relative error');
hold on 
% figure(3)
% totaltime = sum(shortestdis) + hops*t;
% plot(t,totaltime,'r*-.');
% xlabel('The time spent at each fuel station');
% ylabel('The total time to traverse all the target nodes');
% hold on
%title('满能源时最大可移动距离——算法所得距离与最短距离差值')
