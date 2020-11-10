%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem has three variables x(1),x(2),x(3), and it solves
%% minimize (c'*x)
%% subject to 
%%     x>=0;
%%     -1.2*log(x(2)+2*x(3)+55) + 1.8*exp(x(1)+x(2)+1)+x(1)-2.1 <= 0;
%%     -3.5*log(x(1)+2*x(2)+3*x(3)-30) + 0.9*exp(-x(3)-3) -x(3)+1.2 <= 0;

%% Copyright (c) 2020, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars c b A cons;

% adding LP constraint
cons{2,1}='LP';  cons{2,2}=[3];

A{2,1}=[1 0 0;0 1 0;0 0 1];
b{2,1}=[0;0;0];

% adding 2-dim constraints
cons{1,1}='TD';  
cons{1,2} = {[1 1; 2 1], [1.2 1.8];  % 1st constraint: one type 1 (-log(z)) with coeff 1.2, one type 2 (exp(z)) with coeff 1.8
             [1 1; 2 1], [3.5 0.9]}; % 2nd constraint: one type 1 (-log(z)) with coeff 3.5, one type 2 (exp(z)) with coeff 0.9

A{1,1}=[1 0 0;0 1 2;1 1 0 ;0 0 -1;1 2 3;0 0 -1];
b{1,1}=[-2.1;55;1;1.2;-30;-3];

% adding an equation
% cons{3,1}='EQ';
% A{3,1}=[1 1 1];
% b{3,1}=10.1;

c=[1;1;1];

[x,y]=DDS(c,A,b,cons);




%%%%%%%%%%%%%%% CVX code for comparison
% cvx_begin
% variable x(3)
% minimize (c'*x)
% subject to 
%     x>=0;
%     -1.2*log(x(2)+2*x(3)+55) + 1.8*exp(x(1)+x(2)+1)+x(1)-2.1 <= 0;
%     -3.5*log(x(1)+2*x(2)+3*x(3)-30) + 0.9*exp(-x(3)-3) -x(3)+1.2 <= 0;
% cvx_end