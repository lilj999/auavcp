function G = shanjiedian(G)
k = 0;
          for i = 3:8
            for j = 3:8
            G(37,i*10+j) = k;
            G(i*10+j,37) = k;
            G(44,i*10+j) = k;
            G(i*10+j,44) = k;
             G(53,i*10+j) = k;
            G(i*10+j,53) = k;
             G(58,i*10+j) = k;
            G(i*10+j,58) = k;
             G(64,i*10+j) =k;
            G(i*10+j,64) = k;
             G(68,i*10+j) = k;
            G(i*10+j,68) = k;
             G(77,i*10+j) = k;
            G(i*10+j,77) = k;
            G(84,i*10+j) = k;
            G(i*10+j,84) = k;
        end
    end