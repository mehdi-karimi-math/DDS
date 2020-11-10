%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem contains p-norm constraints. Let us define p_norm as
%%    |z|_p:=(z_1^p+...+z_m^p)^{1/p),      for p>=1. 
%% We similarly define |z|_(-1), i.e.,
%%        |z|_(-1)^(-1)=1/|z_1|+...+1/|z_m|.
%% The following problem contains two consraints of the form 
%%                     |A*x+b|_p^p+d^T*x+e <= 0, 
%%                     |A*x+b|_(-1)^(-1)+d^T*x+e <= 0.

%% Copyright (c) 2020, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_var=5;
num_fun=10;
p=3;

% adding p-norm constraint
cons{1,1}='TD';
type=4;
cons{1,2}={[type num_fun], ones(num_fun,1), p*ones(num_fun,1)};

A{1,1}=rand(num_fun+1,num_var);
b{1,1}=[-10;ones(num_fun,1)];


% adding (-1)-norm constraint
cons{2,1}='TD';
type=6;  % this type is for function f(z)=1/z
cons{2,2}={[type num_fun], ones(num_fun,1)};

A{2,1}=A{1,1};
b{2,1}=b{1,1};

c=ones(num_var,1);
[x,y,info]=DDS(c,A,b,cons);


