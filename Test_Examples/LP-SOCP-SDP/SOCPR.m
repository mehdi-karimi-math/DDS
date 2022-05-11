%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem has LP and rotated SOCP constraints. 
%% We want to maximize the summation of three variables x1, x2, x3
%% while
%%
%%    x1,x2,x3 <= 3
%%    norm(x)^2 <= (x1+3)*(x2+1)

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clearvars Z A b cons;


% adding SOCPR constraint
cons{1,1}='SOCPR'; 
cons{1,2}=[3 3];

A{1,1}=[1 0 0; 0 1 0; eye(3); zeros(5,3)];
b{1,1}=[3;1;zeros(3,1); zeros(5,1)];

% cons{3,1}='SOCPR'; 
% cons{3,2}=[3];
% 
% A{3,1}=[0 0 0; 0 0 0; zeros(3)];
% b{3,1}=[3;1;zeros(3,1)];

% same problem with an additional redundant constraint
% A{1,1}=[1 0 0; 0 1 0; eye(3); 0 0 0;0 0 0; zeros(3)];
% b{1,1}=[3;1;zeros(3,1);5;1;1;1;1];

% adding LP constraint
cons{2,1}='LP';
cons{2,2}=[3];

A{2,1}=-eye(3);
b{2,1}=[3;3;3];


% objective function
c=[-1;-1;-1];

 
[x,y,info]=DDS(c,A,b,cons);
 
 