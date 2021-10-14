function [ GC, path2,distance, remain] = khuller( G, src, dst,  L , gx, gy, rt, sL,rL, ~)
%uniroute 此处显示有关此函数的摘要
%   此处显示详细说明
%extend G
%src=[x,y]
%dst1={[x,y],[x,y]}
%gx=[,,,,,,,]
%gy=[,,,,,,,]
%rt= recharging time
%idst= index of dst


dstcount=length(dst);
onodecount=  numnodes(G);
dst1=dst(1,:);
dst2=dst(2,:);
dst3=dst(3,:);
A=G.adjacency;
Z=zeros(onodecount,onodecount);
AE=[A,Z,Z;Z,A,Z;Z,Z,A];

GC=G;
GE=digraph(AE);
gnodecount=numnodes(GE);
srcid=gnodecount+1;
dstids=(2:(dstcount+1))+gnodecount;
GE=addnode(GE, dstcount+1);
GC=addnode(GC, dstcount+1);
for i=1:onodecount
    %add src
     dis=dist( src(1),src(2), gx(i),gy(i));
     if  dis <= sL
            GE=addedge(GE, srcid,i, dis);
            GC=addedge(GC, srcid-onodecount-onodecount,i, dis);
     end
    %add dst1
     dis=dist( gx(i),gy(i), dst1(1),dst1(2));
     if  dis <= L-rL
            GE=addedge(GE, i,dstids(1), dis);
            GC=addedge(GC, i,dstids(1)-onodecount-onodecount, dis);
     end
end

for i=1:onodecount
    %add dst1
    gei=i+onodecount;
    dis=dist( dst1(1),dst1(2), gx(i),gy(i));
     if  dis <= rL
            GE=addedge(GE, dstids(1),gei, dis);
            GC=addedge(GC, dstids(1)-onodecount-onodecount,i, dis);
     end
    %add dst2
     dis=dist( gx(i),gy(i), dst2(1),dst2(2));
     if  dis <= L-rL
            GE=addedge(GE, gei,dstids(2), dis);
            GC=addedge(GC, i,dstids(2)-onodecount-onodecount, dis);
     end
end

for i=1:onodecount
    %add dst2
    gei=i+onodecount+onodecount;
    dis=dist( dst2(1),dst2(2), gx(i),gy(i));
     if  dis <= rL
            GE=addedge(GE, dstids(2),gei, dis);
            GC=addedge(GC, dstids(2)-onodecount-onodecount,i, dis);
     end
    %add dst3
     dis=dist( gx(i),gy(i), dst3(1),dst3(2));
     if  dis <= L-rL
            GE=addedge(GE, gei,dstids(3), dis);
            GC=addedge(GC, i,dstids(3)-onodecount-onodecount, dis);
     end
end


%shortest path
[path, len]=shortestpath(GE, srcid, dstids(3));

xx=[gx';src(1);dst1(1);dst2(1);dst3(1)]';
yy=[gy';src(2);dst1(2);dst2(2);dst3(2)]';

path2=path;
for i =1:length(path2)
    if path2(i)>onodecount
        path2(i)=path2(i)-onodecount;
    end
    if path2(i)>onodecount
        path2(i)=path2(i)-onodecount;
    end
end

distance=len;%dist(src(1),src(2),dst(1),dst(2));%sqrt((src(1)-dst(1))^2+(src(2)-dst(2))^2);
remain=L;
number = length(path2);
if ~isempty(path2)
    remain = L - dist(xx(path2(number-1)),yy(path2(number-1)),xx(path2(number)),yy(path2(number)));
end

end

