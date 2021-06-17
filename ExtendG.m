function G = ExtendG(c,G)
   for i = 3:8
       for j = 3:8        
         for ii = 3:8
                for jj = 3:8                  
                    dis = 0;
                    if ii ~= i && jj ~= j
                        temp = [ii jj];
                        dis=dist(i,j,ii,jj);
                    end
                    if dis<c                   
                        G(i*10+j,ii*10+jj) = dis;
                        G(ii*10+jj,i*10+j) = dis;
                    end                 
                end      
           end
       end    
   end