function [neighborX,neighborY] = CalNeighbor(DX,DY,N,c)
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
        end