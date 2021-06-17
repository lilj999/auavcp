function [neighborX,neighborY] = RandomCalNeighbor(DX,DY,N,c,DepotX,DepotY,DepotN)
for k = 1:N
            num = 1;
            for i = 3:8
                for j = 3:8
                   
                    temp = [i j];
                    dis=norm([DX(k) DY(k)]-temp);
                    if dis<c                   
                        neighbor(k,num) = i*10+j;
                        neighborX(k,num) = i;
                        neighborY(k,num) = j;
                        num = num + 1;
                    end
                   
                end
            end
            
            for t = 1:DepotN
                dis = norm([DX(k) DY(k)] - [DepotX(t) DepotY(t)]);
                if dis<c
                    neighbor(k,num) = 100+t;
                    neighborX(k,num) = DepotX(t);
                    neighborY(k,num) = DepotY(t);
                    num = num + 1;
                end
            end
        end