%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% In this optimization problem, we are minimizing nuclear norm of a matrix under some linear constraints. 
%%       (P)   min   ||X||_*
%%             s.t.   trace(U1*X)=1;  trace(U2*X)=2;
%% The dual of this problem can be given into DDS as a matrix norm constraint:
%%       (D)   min -u_1-2*u_2
%%             s.t. ||u_1*U1+u_2*U2|| <= 1. 
%% Then, the optimal solution of (P) can be derived from the dual certificate. 

%% For the general case, please see the users' guide. 

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars c A b cons;
 
m=20;
n=500;

U1 = round(rand(m,n));
U2 = round(rand(m,n));


cons{1,1}='MN';
cons{1,2}=[m n];
A{1,1}=[m2vec(U1,n) m2vec(U2,n);  zeros(m^2,1) zeros(m^2,1)];
b{1,1}=[zeros(m*n,1); sm2vec(eye(m))];   

% objective function, constructed from the RHS vector in (P).
c=[-1;-2];


[x,y,info]=DDS(c,A,b,cons);


%%% The optimal solution of the primal problem (nuclear norm minimization) is 
X_DDS=vec2m(y{1}(1:m*n),m)';


%%%%%%%%%%%%%%% CVX code for comparison
% cvx_begin 
% variable X(n,m) 
% minimize norm_nuc(X)
% subject to 
%       trace(U1*X)==1
%       trace(U2*X)==2
% cvx_end



