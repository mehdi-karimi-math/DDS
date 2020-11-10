%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem has a generalized popwer cone (GPC) constraint. 
%% We want to maximize the summation of three variables x1, x2, x3
%% while
%%
%%    x1,x2,x3 <= 3
%%    norm(x) <= (x1+3)^0.3 * (x2+1)^0.3 * (x3+2)^0.4

%% Copyright (c) 2020, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clearvars c A b cons;

% adding GPC constraint
cons{1,1}='GPC'; 
cons{1,2}={[3 3], [0.3; 0.3; 0.4]};

A{1,1}=[1 0 0; 0 1 0; 0 0 1;eye(3)];
b{1,1}=[3;1;2;zeros(3,1)];

% adding LP constraint
cons{2,1}='LP';
cons{2,2}=[3];

A{2,1}=-eye(3);
b{2,1}=[3;3;3];

% adding a redundant GPC constraint
cons{3,1}='GPC'; 
cons{3,2}={[3 3], [0.3;0.5;0.2]};

A{3,1}=[0 0 0; 0 0 0; 0 0 0;zeros(3)];
b{3,1}=[3;1;2;zeros(3,1)];

c=[-1;-1;-1];

 
[x,y,info]=DDS(c,A,b,cons);
 
 