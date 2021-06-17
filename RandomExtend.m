 function G = RandomExtend(c,G,DepotX,DepotY,DepotN)
   for i = 3:8
       for j = 3:8        
         for ii = 3:8
                for jj = 3:8                  
                    dis = 0;
                    if ii ~= i && jj ~= j
                        temp = [ii jj];
                        dis=norm([i j]-temp);
                    end
                    if dis<c                   
                        G(i*10+j,ii*10+jj) = dis;
                        G(ii*10+jj,i*10+j) = dis;
                    end                 
                end      
           end
       end     
   end

       for i = 3:8
            for j = 3:8
                for k = 1:DepotN
                    temp = [i,j];
                    dis = norm(temp - [DepotX(k) DepotY(k)]);
                    if dis<c
                        G(100+k,i*10+j) = dis;
                        G(i*10+j,100+k) = dis;
                    end
                end
            end
        end