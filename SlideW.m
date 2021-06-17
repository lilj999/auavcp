function [Dist,Path,remain,shortestdis,hops] = SlideW(G,DX,DY,c,remain,N)
Gtemp = G;
   for i = N:-1:2
            for k = i-1:i
            for s = 3:8
                for t = 3:8
                    temp = [s t];
                    dis=norm([DX(k) DY(k)]-temp);
                    if dis<c
                        Gtemp(k,s*10+t)=dis;
                        Gtemp(s*10+t,k)=dis;
                    end
                end
            end
            end
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
            %if remain(i-1) <= Gtemp(Path(1),Path(2))
                remain(i-1) = Gtemp(Path(1),Path(2));
            %end
            shortestdis(i-1) = Dist;
            Gtemp = G;
        end