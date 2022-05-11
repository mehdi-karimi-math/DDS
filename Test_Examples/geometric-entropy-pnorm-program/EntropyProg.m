%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem solves an optimization problem with two entropy programming 
%% constraints, i.e., constraints of the form
%%         f(a_i^T x+b_i)+...+f(a_l^T x+b_l)+d^T x+e <= 0,
%% where f(z)=zln(z).
%% The coefficients are generated randomly. 

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars c b A cons;

num_fun=100;
num_var=50;

% adding LP constraint
cons{1,1}='TD';
cons{1,2}={[3 num_fun], ones(1,num_fun);
           [3 num_fun], ones(1,num_fun)};


A{1,1}=rand(2*(num_fun+1),num_var);
b{1,1}=rand(2*(num_fun+1),1);


% objective function
c=ones(num_var,1);

[x,y,info]=DDS(c,A,b,cons);



