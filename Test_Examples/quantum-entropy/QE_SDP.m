%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem has QE, SDP, and LP constraints. We want to minimize the quantum 
%% entropy of x1*A1+x2*A2+x3*A3 while its eigenvalues are at least 3, with additional linear 
%% constraint 2*x1+3*x2-x3 <=5. 

%% We reformulate  
%%      min  QE(x1*A1+x2*A2+x3*A3),  ...
%% by 
%%      min    x4    QE(x1*A1+x2*A2+x3*A3)<=x4, ...

%% Copyright (c) 2020, by 
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars c A b cons;

 A1=[1 0 0;0 1 0;0 0 1];
 A2=[0 0 1;0 1 0;1 0 0];
 A3=[0 1 0; 1 0 0; 0 0 0];
 
 
 %%%% adding linear constraint
 cons{1,1}='LP';
 cons{1,2}=[1];
 A{1,1}=[-2 -3 +1 0];
 b{1,1}=[5];
 
 %%%% adding SDP constraint
 cons{2,1}='SDP';
 cons{2,2}=[3];
 A{2,1}=[sm2vec(A1)  sm2vec(A2)  sm2vec(A3) -sm2vec(zeros(3))];
 b{2,1}=-3*sm2vec(eye(3));
 
 %%%% adding QE constraint
 cons{3,1}='QE';
 cons{3,2}=[3];
 A{3,1}= [0 0 0 1; [sm2vec(A1)  sm2vec(A2)  sm2vec(A3) -sm2vec(zeros(3))]];
 b{3,1}=[0;sm2vec(zeros(3))];
 
 
 c=[0;0;0;1];

 [x,y,info]=DDS(c,A,b,cons);
