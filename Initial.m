function G = Initial()
    A=[1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6];%生成网格节点横坐标
    B=[1 1 1 1 1 1 2 2 2 2 2 2 3 3 3 3 3 3 4 4 4 4 4 4 5 5 5 5 5 5 6 6 6 6 6 6];%生成网格节点纵坐标
    %%%%%%%%%%生成各坐标间的邻接矩阵%%%%%%%%%%
    S1=[11 11 21 21 21 31 31 31 41 41 41 51 51 51 61 61]+22;
    E1=[12 21 11 22 31 21 32 41 31 42 51 41 52 61 51 62]+22;
    S2=[12 12 12 22 22 22 22 32 32 32 32 42 42 42 42 52 52 52 52 62 62 62]+22;
    E2=[11 22 13 12 21 32 23 22 31 42 33 32 41 52 43 42 51 62 53 52 61 63]+22;
    S3=S2+ones(1,length(S2));
    E3=E2+ones(1,length(E2));
    S4=S3+ones(1,length(S2));
    E4=E3+ones(1,length(E2));
    S5=S4+ones(1,length(S2));
    E5=E4+ones(1,length(E2));
    S6=[16 16 26 26 26 36 36 36 46 46 46 56 56 56 66 66]+22;
    E6=[15 26 16 25 36 26 35 46 36 45 56 46 55 66 56 65]+22;
    S=[S1 S2 S3 S4 S5 S6];
    E=[E1 E2 E3 E4 E5 E6];
    W=ones(1,4*length(S2)+2*length(S6));
    G=sparse(S,E,W);
    
    