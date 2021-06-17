%%%%%%%%%%%%%%%%%%%计算随着无人设备满能源时最大移动距离的增加，其与最短距离的差距%%%%%%%%%%%%%%%%
clear
N=15;%目的节点个数
DepotN = 14;
window1 = 2;
window2 = 4;
window3 = 8;
window4 = 12;
window5 = 2;
window6 = N;

%CorrectCount=zeros(1,maxDistance);
totalhops = 0;
totaldis = 0;
 G = Initial();
DepotX = 5*rand(1,DepotN)+3;
DepotY = 5*rand(1,DepotN)+3;

%%%%%%%%%%%运行30次，求10次按照本算法在栅格网络中随机生成的目标节点的距离与最短距离差的平均值%%%%%%%%%%%%
for times = 1:10
    totalhops1 = 0;
    totaldis1 = 0;
    totalhops2 = 0;
    totaldis2 = 0;
    totalhops3 = 0;
    totaldis3 = 0;
    totalhops4 = 0;
    totaldis4 = 0;
    totalhops5 = 0;
    totaldis5 = 0;
    totalhops6 = 0;
    totaldis6 = 0;
    
    for turn = 1:30
    t = times*0.2;
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
        remain_temp = remain;
        remain_fill = (c/2) * ones(1,N);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Gtemp = G;
        %%%%%%%%%%计算考虑能源补给的情况下的最短距离%%%%%%%%%%
%         [Dist1,Path1,remain,shortestdis1,hops1] = RandomSlidingW(Gtemp,DX,DY,c,remain,N,window1,DepotX,DepotY,DepotN);
%         remain = remain_temp;
%         Gtemp = G;
        Dist1 = Smin(times) + N*t;
        [Dist2,Path2,remain,shortestdis2,hops2] = RandomSlidingW(Gtemp,DX,DY,c,remain,N,window2,DepotX,DepotY,DepotN);
        remain = remain_temp;
        Gtemp = G;
        [Dist3,Path3,remain,shortestdis3,hops3] = RandomSlidingW(Gtemp,DX,DY,c,remain,N,window3,DepotX,DepotY,DepotN);
        remain = remain_temp;
        Gtemp = G;
        [Dist4,Path4,remain,shortestdis4,hops4] = RandomSlidingW(Gtemp,DX,DY,c,remain,N,window4,DepotX,DepotY,DepotN);
        remain = remain_temp;
        Gtemp = G;
        [Dist5,Path5,remain,shortestdis5,hops5] = RandomSlidingW(Gtemp,DX,DY,c,remain_fill,N,window5,DepotX,DepotY,DepotN);
        remain = remain_temp;
        Gtemp = G;
        [Dist6,Path6,remain_fill,shortestdis6,hops6] = RandomSlidingW(Gtemp,DX,DY,c,remain_fill,N,window6,DepotX,DepotY,DepotN);%fill
%         totalhops1 = totalhops1  + hops1;
%         totaldis1 = totaldis1 + sum(shortestdis1);
        totalhops1 = totalhops1+N;
        totaldis1 = totaldis1+Dist1;
        totalhops2 = totalhops2  + hops2;
        totaldis2 = totaldis2 + sum(shortestdis2);
        totalhops3 = totalhops3  + hops3;
        totaldis3 = totaldis3 + sum(shortestdis3);
        totalhops4 = totalhops4  + hops4;
        totaldis4 = totaldis4 + sum(shortestdis4);
        totalhops5 = totalhops5  + hops5;
        totaldis5 = totaldis5 + sum(shortestdis5);
        totalhops6 = totalhops6  + hops6;
        totaldis6 = totaldis6 + sum(shortestdis6);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
          totaltime1(times) = totaldis1 + totalhops1*t;          
          totaltime2(times) = totaldis2 + totalhops2*t;
          totaltime3(times) = totaldis3 + totalhops3*t;
          totaltime4(times) = totaldis4 + totalhops4*t;
          totaltime5(times) = totaldis5 + totalhops5*t;
          totaltime6(times) = totaldis6 + totalhops6*t;
end


figure(4)
hold on
%totaltime = (totaldis + totalhops*t)/30;
plot(T,totaltime1/30,'k*-');
%plot(T,totaltime1,'k*-');
plot(T,totaltime2/30,'ks-');
plot(T,totaltime3/30,'ko-');
plot(T,totaltime4/30,'k^-');
plot(T,totaltime5/30,'kx-');
plot(T,totaltime6/30,'k+-');
xlabel('The time spent at each fuel station');
ylabel('Total Time Delay');
hold on
legend('Theoretical optimal time  delay','Online algorithm (window size =4)','Online algorithm (window size =8)','Online algorithm (window size =12)','Khuller algorithm','Liao algorithm');

%title('满能源时最大可移动距离——算法所得距离与最短距离差值')
