close
clear

%unit 100km

id=1:36;
x = 1:36;
y = 1:36;

for i=id
   x(i)= mod(i-1,6);
   y(i)= floor((i-1)/6);
end

nl=1:10;
L=(nl-1)/5+1.01;
L0=L(5);

G=digraph;
for i=id
   %G=  addnode(G, int2str(i));
   for j=id
       %dis=abs(x(j)-x(i))+abs(y(j)-y(i));
       dis=dist(x(i),y(i),x(j),y(j));%((x(j)-x(i))^2+(y(j)-y(i))^2);
       if i~=j && dis <L0
            G=addedge(G, i,j, dis);
       end
   end
end
src=[0.5,3.5];
dst1=[2.3,4.3];
%dst2=[4.6,1.3];
dst2=[2.7,1.3];
dst3=[4.6,3.3];
dst=[dst1;dst2;dst3];


alpha=1;% fuel per 100km
beta=0;
rt=0;% not used
sL=0.8*L0;
rL=0.4*L0;
[ GC, path1, dist1, ~] = khuller( G, src, dst, L0 , x, y, rt,sL,rL,1);
dist=[dist1];

hold on
p=plot(GC, 'XData',[x';src(1);dst1(1);dst2(1);dst3(1)]', 'YData', [y';src(2);dst1(2);dst2(2);dst3(2)]');
p.Marker='d';
p.MarkerSize=3;
p.NodeColor='k';
p.EdgeColor = 'w';
p.ArrowSize=5;

highlight(p,[37],'marker','o','MarkerSize', 10)
highlight(p,[38,39,40],'marker','^','MarkerSize', 15,'NodeColor','b')


sL=0.8*L0;
rL=0.5*L0;
[GC, path2, dist2, ~] = khuller( G, src, dst,  L0 , x, y, rt,sL,rL,1);
dist=[dist,dist2];
p=plot(GC, 'XData',[x';src(1);dst1(1);dst2(1);dst3(1)]', 'YData', [y';src(2);dst1(2);dst2(2);dst3(2)]');
p.Marker='d';
p.MarkerSize=3;
p.NodeColor='k';
p.EdgeColor = 'w';
p.ArrowSize=5;



sL=0.8*L0;
rL=0.6*L0;
[GC, path3, dist3, remain] = khuller( G, src, dst, L0 , x, y, rt,sL,rL,1);
dist=[dist,dist3];
p=plot(GC, 'XData',[x';src(1);dst1(1);dst2(1);dst3(1)]', 'YData', [y';src(2);dst1(2);dst2(2);dst3(2)]');
p.Marker='d';
p.MarkerSize=3;
p.NodeColor='k';
p.EdgeColor = 'w';
p.ArrowSize=5;
highlight(p,path1,'EdgeColor','r', 'LineWidth',3,'LineStyle', '--')

highlight(p,path3,'EdgeColor','b', 'LineWidth',3,'LineStyle', '-.')
highlight(p,path2,'EdgeColor','g', 'LineWidth',3,'LineStyle', '-')
%legend('Depot', 'Location','SouthEast');
% legend('0.5', 'Location','SouthEast');
% legend('0.8', 'Location','SouthEast');

hold off
L0
path1
path2
path3
dist

% U=100;
% K=0.01;
% Q=100000;
% f1=L*U;
% f2=L*U;
% for i=nl
%     f1(i)= 8*Q*K^2/ (pi*L(i)^2);
%     f2(i)= 4*Q*K^2/ (L(i)^2);
%     L(i)=L(i)/K;
% end
% figure
% hold on
% plot(L, f1, 'k-o',L, f2, 'k-*');
% xlabel('Normalized capacity of fuel(L/K)');
% ylabel('Number of fuel depots');
% legend('Necessary condition','Sufficient condition', 'Location','SouthEast');
% hold off
