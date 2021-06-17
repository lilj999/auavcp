%%%%%%%%%%%%%%%%%%%计算随着无人设备满能源时最大移动距离的增加，其与最短距离的差距%%%%%%%%%%%%%%%%
clc
clear
N = 20;%目的节点个数
DepotN = 14;
DepotX = 5*rand(1,DepotN)+3;
DepotY = 5*rand(1,DepotN)+3;
maxDistance = 79;%无人设备满能源时所能移动的最远直线距离
CorrectCount=zeros(1,maxDistance);
G = Initial();
%%%%%%%%%%%运行30次，求10次按照本算法在栅格网络中随机生成的目标节点的距离与最短距离差的平均值%%%%%%%%%%%%
for window = 2:20
    W(window-1) = window;
tic
for times = 1:30
    Smin(times)=0;%各节点最短距离（直线连接距离）
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

        c = 2.4;
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
end
Caltime(window-1) = toc;
end

figure(4)
plot(W,Caltime/30,'kd-');
xlabel('The window size');
ylabel('Total computation cost/s');
hold on

