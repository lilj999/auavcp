%%%%%%%%%%%%%%%%%%%计算随着无人设备满能源时最大移动距离的增加，其与最短距离的差距%%%%%%%%%%%%%%%%
clc
clear
N = 30;%目的节点个数
DepotN = 14;
window = 6;
maxDistance = 79;%无人设备满能源时所能移动的最远直线距离
totalhops = 0;
totaldis = 0;
 G = Initial();
  DepotX = 5*rand(1,DepotN)+3;
DepotY = 5*rand(1,DepotN)+3;
%%%%%%%%%%%运行30次，求10次按照本算法在栅格网络中随机生成的目标节点的距离与最短距离差的平均值%%%%%%%%%%%%
for times = 1:20
    totalhops = 0;
    totaldis = 0;
    for turn = 1:30
    t = times/10;
    T(times) = t;
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
        totalhops = totalhops + hops;
        totaldis = totaldis + sum(shortestdis);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
        totaltime(times) = totaldis + totalhops*t;
end


figure(3)
%totaltime = (totaldis + totalhops*t)/30;
plot(T,totaltime/30,'kp-');
xlabel('The time spent at each fuel station');
ylabel('The total time to traverse all the target nodes');
hold on
%title('满能源时最大可移动距离——算法所得距离与最短距离差值')
