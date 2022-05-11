%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem has a quadratic constraint. 
%% We want to maimize the summation of three variables x1, x2, x3
%% while
%%
%%    x^T (A^T Q A) x <= k
%% Note that Q may have one nagative eigenvalue. 

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clearvars c A b cons;


% adding QC constraint
cons{1,1}='QC'; 
cons{1,2}=[4];
cons{1,3,1}=diag([1 2 1 0]);  % defining Q. 

k=3;

A{1,1}=[0 0 0; 0 0 1; 0 1 0; 1 0 0; -1 1 -1];
b{1,1}=[-k;zeros(4,1)];

c=[1;1;1];
 
[x,y,info]=DDS(c,A,b,cons);
 
 