%%%%%%%%%%%%%%%%%%%计算随着无人设备满能源时最大移动距离的增加，其与最短距离的差距%%%%%%%%%%%%%%%%
clear
for N = 1:10
tic
NumNodes(N)=N;
maxDistance = 58;%无人设备满能源时所能移动的最远直线距离
CorrectCount=zeros(1,maxDistance);

    G=Initial();
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%运行30次，求10次按照本算法在栅格网络中随机生成的目标节点的距离与最短距离差的平均值%%%%%%%%%%%%
for times = 1:30
    Smin=0;%各节点最短距离（直线连接距离）
    shortestdis = zeros(1,N-1);
    DX=5*rand(1,N)+1;%生成起始与初始节点横坐标
    DY=5*rand(1,N)+1;%生成起始与初始节点纵坐标
    %确认各节点的最短距离
    X=[DX' DY'];
    L=pdist(X);
    LM=squareform(L);
    for i = 1:N-1
        Smin = Smin + LM(i,i+1);
    end
%     for p = 1:maxDistance
%         c = 1.41 + p/100;
%         C(p) = c;
    c=2.5;
        G = ExtendG(c,G);     
        %%%%%%%%%%寻找节点的邻居节点%%%%%%%%%%
        [neighborX,neighborY] = CalNeighbor(DX,DY,N,c);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%计算节点所需保留的能量%%%%%%%%%%
        remain = CalRemain(neighborX,neighborY,DX,DY,N);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Gtemp = G;
        %%%%%%%%%%计算考虑能源补给的情况下的最短距离%%%%%%%%%%
        for i = N:-1:2
            for k = i-1:i
            for s = 1:6
                for t = 1:6
                    temp = [s t];
                    dis=norm([DX(k) DY(k)]-temp);
                    if dis<c
                        Gtemp(k,s*10+t)=dis;
                        Gtemp(s*10+t,k)=dis;
                    end
                end
            end
            end
            %%%%%%%%%%终止节点的约束信息%%%%%%%%%%
            [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
            FinalDis = Gtemp(Path(length(Path)),Path(length(Path)-1)) + remain(i);
            while(FinalDis > c)
                  Gtemp(Path(length(Path)),Path(length(Path)-1)) = 0;
                  Gtemp(Path(length(Path)-1),Path(length(Path))) = 0;
                  [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
                  FinalDis = Gtemp(Path(length(Path)),Path(length(Path)-1)) + remain(i);
            end
            %%%%%%%%%%起始节点的约束信息%%%%%%%%%%
            StartDis = Gtemp(Path(1),Path(2)) + remain(i-1);
            while(StartDis > c)
                Gtemp(Path(1),Path(2)) = 0;
                Gtemp(Path(2),Path(1)) = 0;
                [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
                StartDis = Gtemp(Path(1),Path(2)) + remain(i-1);
            end
            %%%%%%%%%%修正邻接矩阵拓扑图%%%%%%%%%%
           remain(i-1) = Gtemp(Path(1),Path(2));
            shortestdis(i-1) = Dist;
            Gtemp = G;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        t=toc;
        Caltimes(N,times) = t;
    end
end
Ctimes=sum(Caltimes,2)/times;
plot(NumNodes,Ctimes,'o-')
xlabel('number of targets');
ylabel('Computation time (\s)');
%%title('算法运行时间与目的节点个数的关系');
