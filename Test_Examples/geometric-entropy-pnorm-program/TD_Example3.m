%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This example solves the following problem
%% minimize (c'*x)
%% subject to 
%%     2.2*exp(2*x(1)+3)+|(x(1)+x(2)+x(3))|^3+4.5*|(x(1)+2*x(2))|^2.5+|(x(2)+2*x(3))|^3+x(1)-2 <=0;

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars c A b cons;


cons{1,1}='TD';
cons{1,2}={[2 1;4 3], [2.2 1 4.5 1], [0 3 2.5 3]};
% One function of type 2 with coeff 2.2, three functions of type 4 with
% coeff's 1, 4.5, and 1
% [0 3 2.5 3] is for the powers, the first entry 0 must be put in place of
% exp function.

A{1,1}=[1.3 0 0;2 0 0;1 1 1;1 2 0;0 1 2];
b{1,1}=[-1.9;3;0;0;0];   

% objective function
c=[-1;1;-1];

[x,y,info]=DDS(c,A,b,cons);


%%%%%%%%%%%%%%% CVX code for comparison
% cvx_begin
% variable x(3)
% minimize (c'*x)
% subject to 
%     2.2*exp(2*x(1)+3)+pow_abs((x(1)+x(2)+x(3)),3)+4.5*pow_abs((x(1)+2*x(2)),2.5)+pow_abs((x(2)+2*x(3)),3)+x(1)-2 <=0;
% cvx_end


