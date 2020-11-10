%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem has QRE and LP constraints. We want to minimize the quantum relative
%% entropy of two matrices X:=x1*A1+x2*A2+x3*A3  and Y:=I+x1*A2+x3*A3 
%% with additional linear constraint 2*x1+3*x2-x3 <=5. 

%% We reformulate  
%%      min  QRE(X,Y),  ...
%% by 
%%      min    x4    QRE(X,Y)<=x4, ...

%% Copyright (c) 2020, by 
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars A b cons;

 A1=[1 0 0;0 1 0;0 0 1];
 A2=[0 0 1;0 1 0;1 0 0];
 A3=[0 1 0; 1 0 0; 0 0 0];
 
 
 %%%% adding linear constraint
 cons{1,1}='LP';
 cons{1,2}=[1];
 A{1,1}=[-2 -3 +1 0];
 b{1,1}=[5];
 
 
 %%%% adding QE constraint
 cons{2,1}='QRE';
 cons{2,2}=[3];
 A{2,1}= [0 0 0 1; [sm2vec(A1)  sm2vec(A2)  sm2vec(A3) sm2vec(zeros(3))]; ...
     [ sm2vec(A2)  sm2vec(zeros(3))  sm2vec(A3) sm2vec(zeros(3))]];
 b{2,1}=[0;sm2vec(zeros(3));sm2vec(eye(3))];
 
 
 c=[0;0;0;1];

 [x,y,info]=DDS(c,A,b,cons);
