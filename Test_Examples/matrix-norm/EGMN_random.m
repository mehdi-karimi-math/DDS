%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem has a matrix norm constraint, created by random matrices.
%%             

%% Copyright (c) 2020, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 clearvars c A b cons;
 
 m=20;
 n=50;
 cons{1,1}='MN';
 cons{1,2}=[m n];

% U1=[1 0;0 1;0 1]';
% U2=[-1 0; -1 0; 1 1]';
% U0=[1 0;0 1;0 0]';
 
U0=rand(m,n);
U1=rand(m,n);
U2=rand(m,n);

A{1,1}=[m2vec(U1,n) m2vec(U2,n) m2vec(zeros(m,n),n) ;  zeros(m^2,1) zeros(m^2,1) sm2vec(eye(m))];
b{1,1}=[m2vec(U0,n); zeros(m^2,1)]; 

c=[0;0;1];

[x,y,info]=DDS(c,A,b,cons);


%%%%%%%%%%%%%%% CVX code for comparison
%  cvx_begin sdp
%  variable x(3)
%  minimize (c'*x)
%  subject to 
%       [x(3)*eye(m) (U0+x(1)*U1+x(2)*U2) ; (U0+x(1)*U1+x(2)*U2)'  eye(n)] >= 0
%  %       x(3)*eye(m)-(U0+x(1)*U1+x(2)*U2)* (U0+x(1)*U1+x(2)*U2)' >=0
%  cvx_end




 
 



