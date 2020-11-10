%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem has QE and vector entropy constraints. We want to minimize the quantum 
%% entropy of x1*A1+x2*A2+x3*A3+x4A4 while the entopry of the vector [x1 x2 x3 x4] 
%% is smaller than k. 

%% If k=-1, the problem has an optimal solution, but for k=-2, the problem
%% is infeasible. 

%% We reformulate  
%%      min  QE(x1*A1+x2*A2+x3*A3+x4*A4),  ...
%% by 
%%      min    x5    QE(x1*A1+x2*A2+x3*A3+x4*A4)<=x5, ...

%% Copyright (c) 2020, by 
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars  c A b cons;

 k=-1;

 A1=[1 0 0;0 1 0;0 0 1];
 A2=[0 0 1;0 1 0;1 0 0];
 A3=[0 1 0; 1 0 0; 0 0 0];
 A4=[0 0 -1; 0 -1 0; -1 0 0];

 
 %%%% adding QE constraint
 cons{1,1}='QE';
 cons{1,2}=[3];
 A{1,1}=[ 0 0 0  0 1; [sm2vec(A1)  sm2vec(A2)  sm2vec(A3) sm2vec(A4) -sm2vec(zeros(3))]];
 b{1,1}=[0;sm2vec(zeros(3))];
 
 %%%% adding vector entropy constraint (epigraph of 2-dim sets)
 
 cons{2,1}='TD';
 cons{2,2}={[3 4], [1 1 1 1]};  
 % First entry is [type of univariate function (3 for entropy)     the # of this type]
 % scalar coefficnets of each function 
 A{2,1}=[0 0 0 0 0; eye(4) zeros(4,1)];
 b{2,1}=[-k;0;0;0;0];
 
 
 c=[0;0;0;0;1];

 [x,y,info]=DDS(c,A,b,cons);

