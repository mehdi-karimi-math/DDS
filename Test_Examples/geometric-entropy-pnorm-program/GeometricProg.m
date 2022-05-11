%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem solves an optimization problem with two geometric programming 
%% constraints, i.e., constraints of the form
%%         exp(a_1^T x+b_1)+...+exp(a_l^T x+b_l)+d^T x+e <= 0. 
%% The coefficients are generated randomly. 

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars c b A cons;

num_fun=100;
num_var=50;

% adding TD constraint
cons{1,1}='TD';
cons{1,2}= {[2 num_fun], ones(1,num_fun);
             [2 num_fun], ones(1,num_fun)};

A{1,1}=rand(2*(num_fun+1),num_var);
b{1,1}=rand(2*(num_fun+1),1);


% objective function 
c=ones(num_var,1);

[x,y]=DDS(c,A,b,cons);



