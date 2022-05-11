%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This example solves the following problem
%% minimize (c'*x)
%% subject to 
%%     x(1) <=0;
%%     x(2:3)>=0;
%%     -1.2*log(x(2)+2*x(3)+55) + 1.8*exp(x(1)+x(2)+1)+1.5*(x(2)-3*x(3))*log(x(2)-3*x(3))+x(1)-2.1 <= 0;
%%     -3.5*log(x(1)+2*x(2)+3*x(3)-30) + 0.9*exp(-x(3)-3) -x(3)+1.2 <= 0;

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars c A b cons;

% adding LP constraint
cons{1,1}='LP';
cons{1,2}=[3];
A{1,1}=[-1 0 0;0 1 0;0 0 1];
b{1,1}=[0;0;0];

% adding 2-dim constraints
cons{2,1}='TD';
cons{2,2}={[1 1;2 1;3 1], [1.2 1.8 1.5];  % 1st constraint: one type 1 (-log(z)), one type 2 (exp(z)), one type 3 (zlog(z))
           [1 1; 2 1], [3.5 0.9]}; % 2nd constraint: one type 1 (-log(z)), one type 2 (exp(z))

A{2,1}=[1 0 0;0 1 2;1 1 0; 0 1 -3 ;0 0 -1;1 2 3;0 0 -1];
b{2,1}=[-2.1;55;1;0;1.2;-30;-3];

% objective function 
c=[-1;-1;1];

[x,y,info]=DDS(c,A,b,cons);




%%%%%%%%%%%%%%% CVX code for comparison
% cvx_begin
% variable x(3)
% minimize (c'*x)
% subject to 
%     x(1) <=0;
%     x(2:3)>=0;
%     -1.2*log(x(2)+2*x(3)+55) + 1.8*exp(x(1)+x(2)+1)- 1.5*entr(x(2)-3*x(3))+x(1)-2.1 <= 0;
%     -3.5*log(x(1)+2*x(2)+3*x(3)-30) + 0.9*exp(-x(3)-3) -x(3)+1.2 <= 0;
% cvx_end