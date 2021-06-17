%%%%%%%%%%%%%%%%%%%�������������豸����Դʱ����ƶ���������ӣ�������̾���Ĳ��%%%%%%%%%%%%%%%%
clc
clear
N = 20;%Ŀ�Ľڵ����
maxDistance = 79;%�����豸����Դʱ�����ƶ�����Զֱ�߾���
CorrectCount=zeros(1,maxDistance);
G = Initial();
%%%%%%%%%%%����30�Σ���10�ΰ��ձ��㷨��դ��������������ɵ�Ŀ��ڵ�ľ�������̾�����ƽ��ֵ%%%%%%%%%%%%
for window = 2:20
    W(window-1) = window;
tic
for times = 1:30
    Smin(times)=0;%���ڵ���̾��루ֱ�����Ӿ��룩
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
        G = ExtendG(c,G);
        
        %%%%%%%%%%Ѱ�ҽڵ���ھӽڵ�%%%%%%%%%%
        [neighborX,neighborY] = CalNeighbor(DX,DY,N,c);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%%����ڵ����豣��������%%%%%%%%%%
        remain = CalRemain(neighborX,neighborY,DX,DY,N);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Gtemp = G;
        %%%%%%%%%%���㿼����Դ����������µ���̾���%%%%%%%%%%
        [Dist,Path,remain,shortestdis,hops] = SlidingW(Gtemp,DX,DY,c,remain,N,window);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
Caltime(window-1) = toc;
end
figure(4)
plot(W,Caltime/30,'k*-');
xlabel('The window size');
ylabel('Total computation cost/s');
hold on

