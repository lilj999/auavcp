%%%%%%%%%%%%%%%%%%%�������������豸����Դʱ����ƶ���������ӣ�������̾���Ĳ��%%%%%%%%%%%%%%%%
clc
clear
N = 30;%Ŀ�Ľڵ����
DepotN = 14;
window = 6;
maxDistance = 79;%�����豸����Դʱ�����ƶ�����Զֱ�߾���
totalhops = 0;
totaldis = 0;
 G = Initial();
  DepotX = 5*rand(1,DepotN)+3;
DepotY = 5*rand(1,DepotN)+3;
%%%%%%%%%%%����30�Σ���10�ΰ��ձ��㷨��դ��������������ɵ�Ŀ��ڵ�ľ�������̾�����ƽ��ֵ%%%%%%%%%%%%
for times = 1:20
    totalhops = 0;
    totaldis = 0;
    for turn = 1:30
    t = times/10;
    T(times) = t;
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
        c = 2.4;
   %%%%%%%%%%%%%%��չդ��ڵ���ڽӾ���%%%%%%%%%%%

        G = RandomExtend(c,G,DepotX,DepotY,DepotN);
        
        %%%%%%%%%%Ѱ�ҽڵ���ھӽڵ�%%%%%%%%%%
        [neighborX,neighborY] = RandomCalNeighbor(DX,DY,N,c,DepotX,DepotY,DepotN);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%%����ڵ����豣��������%%%%%%%%%%
        remain = CalRemain(neighborX,neighborY,DX,DY,N);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Gtemp = G;
        %%%%%%%%%%���㿼����Դ����������µ���̾���%%%%%%%%%%
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
%title('����Դʱ�����ƶ����롪���㷨���þ�������̾����ֵ')
