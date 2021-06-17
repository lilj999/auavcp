function [remainMin,remainMax] = CalRemain(neighborX,neighborY,DX,DY,N)
       SizeofNeighbor = size(neighborX);
        NumofNeighbor = SizeofNeighbor(2);
        for k = 1:N
            for j = 1:NumofNeighbor
                LastPointNeighbor(k,j) = norm([neighborX(k,j)-DX(k) neighborY(k,j)-DY(k)]);
            end
            remainMin(k) = min(LastPointNeighbor(k,:));
            remainMax(k) = max(LastPointNeighbor(k,:));
        end