%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This SDP shows if the univariate polynomial p(x):=c'*[x^6 x^5 x^4 x^3 x^2 x^1 1] is nonnegative. 
%% The coefficients of the polynomials are in objective vector c.
%% If the SDP has an optimal solution with obj value=0, p(x) is non-negative and if it is unbounded, 
%% p(x) is not non-negative. 

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clearvars A b cons c;
 
cons{1,1}='SDP';
cons{1,2}=[4];

 
 A{1}=[sm2vec(hankel([1;0;0;0],[0;0;0;0])) sm2vec(hankel([0;1;0;0],[0;0;0;0])) ...
     sm2vec(hankel([0;0;1;0],[0;0;0;0])) sm2vec(hankel([0;0;0;1],[1;0;0;0])) ...
     sm2vec(hankel([0;0;0;0],[0;1;0;0])) sm2vec(hankel([0;0;0;0],[0;0;1;0])) sm2vec(hankel([0;0;0;0],[0;0;0;1]))];

 b{1}=sm2vec(zeros(4,4));
 
 c{1}=[1;0;0;-2;0;0;1];
 

[x,y]=DDS(c,A,b,cons);
 
