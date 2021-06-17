clear
N=7;
threshold = 0.2;
CorrectCount=zeros(1,58);
%for times = 1:500
    Smin=0;%���ڵ���̾��루ֱ�����Ӿ��룩
    shortestdis = zeros(1,N-1);
    A=[1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6];%��������ڵ������
    B=[1 1 1 1 1 1 2 2 2 2 2 2 3 3 3 3 3 3 4 4 4 4 4 4 5 5 5 5 5 5 6 6 6 6 6 6];%��������ڵ�������
    DX=5*rand(1,N)+1;%������ʼ���ʼ�ڵ������
    DY=5*rand(1,N)+1;%������ʼ���ʼ�ڵ�������
    %ȷ�ϸ��ڵ����̾���
    X=[DX' DY'];
    L=pdist(X);
    LM=squareform(L);
    for i = 1:N-1
        Smin = Smin + LM(i,i+1);
    end

    %%%%%%%%%%���ɸ��������ڽӾ���%%%%%%%%%%
    S1=[11 11 21 21 21 31 31 31 41 41 41 51 51 51 61 61];
    E1=[12 21 11 22 31 21 32 41 31 42 51 41 52 61 51 62];
    S2=[12 12 12 22 22 22 22 32 32 32 32 42 42 42 42 52 52 52 52 62 62 62];
    E2=[11 22 13 12 21 32 23 22 31 42 33 32 41 52 43 42 51 62 53 52 61 63];
    S3=S2+ones(1,length(S2));
    E3=E2+ones(1,length(E2));
    S4=S3+ones(1,length(S2));
    E4=E3+ones(1,length(E2));
    S5=S4+ones(1,length(S2));
    E5=E4+ones(1,length(E2));
    S6=[16 16 26 26 26 36 36 36 46 46 46 56 56 56 66 66];
    E6=[15 26 16 25 36 26 35 46 36 45 56 46 55 66 56 65];
    S=[S1 S2 S3 S4 S5 S6];
    E=[E1 E2 E3 E4 E5 E6];
    W=ones(1,4*length(S2)+2*length(S6));
    G=sparse(S,E,W);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for p = 1:30
        c = 1.70 + p/100;
 
        %%%%%%%%%%Ѱ�ҽڵ���ھӽڵ�,��չ�ڽӾ���%%%%%%%%%%
        for k = 1:N
            num = 1;
            for i = 1:6
                for j = 1:6
                    temp = [i j];
                    dis=norm([DX(k) DY(k)]-temp);
                    if dis<c
                        G(k,i*10+j)=dis;
                        G(i*10+j,k)=dis;
                        neighbor(k,num) = i*10+j;
                        neighborX(k,num) = i;
                        neighborY(k,num) = j;
                        num = num + 1;
                    end
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%%����ڵ����豣��������%%%%%%%%%%
        SizeofNeighbor = size(neighborX);
        NumofNeighbor = SizeofNeighbor(2);
        for k = 1:N
            for j = 1:NumofNeighbor
                LastPointNeighbor(k,j) = norm([neighborX(k,j)-DX(k) neighborY(k,j)-DY(k)]);
            end
            remain(k) = min(LastPointNeighbor(k,:));
        end
        G1 = G;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Gtemp = G;
        %%%%%%%%%%���㿼����Դ����������µ���̾���%%%%%%%%%%
        for i = N:-1:2
            %%%%%%%%%%��ֹ�ڵ��Լ����Ϣ%%%%%%%%%%
            [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
            FinalDis = Gtemp(Path(length(Path)),Path(length(Path)-1)) + remain(i);
            while(FinalDis > c)
                  Gtemp(Path(length(Path)),Path(length(Path)-1)) = 0;
                  Gtemp(Path(length(Path)-1),Path(length(Path))) = 0;
                  [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
                  FinalDis = Gtemp(Path(length(Path)),Path(length(Path)-1)) + remain(i);
            end
            %%%%%%%%%%��ʼ�ڵ��Լ����Ϣ%%%%%%%%%%
            StartDis = Gtemp(Path(1),Path(2)) + remain(i-1);
            while(StartDis > c)
                Gtemp(Path(1),Path(2)) = 0;
                Gtemp(Path(2),Path(1)) = 0;
                [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
                StartDis = Gtemp(Path(1),Path(2)) + remain(i-1);
            end
            %%%%%%%%%%�����ڽӾ�������ͼ%%%%%%%%%%
            remain(i-1) = Gtemp(Path(1),Path(2));
            shortestdis(1,i-1) = Dist;
            for t = 1:size(neighbor,2)
                if neighbor(i,t) ~= 0
                    G(i,neighbor(i,t)) = 0;
                    G(neighbor(i,t),i) = 0;
                end
            end
            Gtemp = G;
            Pathsum(1) = sum(shortestdis(1,:));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%����ǰ�����ڵ�%%%%%%%%%%%%%%%%%%%%%%%%%%%
G = G1;
Gtemp = G;
        for i = 4:-1:2
            %%%%%%%%%%��ֹ�ڵ��Լ����Ϣ%%%%%%%%%%
            [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
            FinalDis = Gtemp(Path(length(Path)),Path(length(Path)-1)) + remain(i);
            while(FinalDis > c)
                  Gtemp(Path(length(Path)),Path(length(Path)-1)) = 0;
                  Gtemp(Path(length(Path)-1),Path(length(Path))) = 0;
                  [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
                  FinalDis = Gtemp(Path(length(Path)),Path(length(Path)-1)) + remain(i);
            end
            %%%%%%%%%%��ʼ�ڵ��Լ����Ϣ%%%%%%%%%%
            StartDis = Gtemp(Path(1),Path(2)) + remain(i-1);
            while(StartDis > c)
                Gtemp(Path(1),Path(2)) = 0;
                Gtemp(Path(2),Path(1)) = 0;
                [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
                StartDis = Gtemp(Path(1),Path(2)) + remain(i-1);
            end
            %%%%%%%%%%�����ڽӾ�������ͼ%%%%%%%%%%
            remain(i-1) = Gtemp(Path(1),Path(2));
            remain(i) = c - Gtemp(Path(length(Path)),Path(length(Path)-1));
            shortestdis(2,i-1) = Dist;
            for t = 1:size(neighbor,2)
                if neighbor(i-1,t) ~= 0
                    G(i-1,neighbor(i-1,t)) = 0;
                    G(neighbor(i-1,t),i-1) = 0;
                end
            end
            Gtemp = G;
        end
        
         for i = 7:-1:5
            %%%%%%%%%%��ֹ�ڵ��Լ����Ϣ%%%%%%%%%%
            [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
            FinalDis = Gtemp(Path(length(Path)),Path(length(Path)-1)) + remain(i);
            while(FinalDis > c)
                  Gtemp(Path(length(Path)),Path(length(Path)-1)) = 0;
                  Gtemp(Path(length(Path)-1),Path(length(Path))) = 0;
                  [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
                  FinalDis = Gtemp(Path(length(Path)),Path(length(Path)-1)) + remain(i);
            end
            %%%%%%%%%%��ʼ�ڵ��Լ����Ϣ%%%%%%%%%%
            StartDis = Gtemp(Path(1),Path(2)) + remain(i-1);
            while(StartDis > c)
                Gtemp(Path(1),Path(2)) = 0;
                Gtemp(Path(2),Path(1)) = 0;
                [Dist,Path]=graphshortestpath(Gtemp,i-1,i,'Method','Dijkstra');
                StartDis = Gtemp(Path(1),Path(2)) + remain(i-1);
            end
            %%%%%%%%%%�����ڽӾ�������ͼ%%%%%%%%%%
            remain(i-1) = Gtemp(Path(1),Path(2));
            remain(i) = c - Gtemp(Path(length(Path)),Path(length(Path)-1));
            shortestdis(2,i-1) = Dist;
            for t = 1:size(neighbor,2)
                if neighbor(i,t) ~= 0
                    G(i,neighbor(i,t)) = 0;
                    G(neighbor(i,t),i) = 0;
                end
            end
            Gtemp = G;
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%%%%%%%%        
    end
%end

