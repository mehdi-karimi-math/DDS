%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This file finds the Nearest Correlation Matrix in the Quantum Sense. 
%% For a given matrix M, we are looking for a matrix Y, so solution of the following
%% optimization problem:
%%                  min    qre(M,Y)   s.t.   Diag(Y) == 1

%% Here, we assume that Y is tridiagonal.

%% Copyright (c) 2023, by 
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars A b cons;

side = 50;


M = 2*eye(side);

% If we want M to be a random matrix:

% M = rand(side);
% M = M*M'/(max(diag(M*M')));


M1 = ones(side)-eye(side);
A1 = sm2vec(M1);
A2 = sm2vec(zeros(side));


A11=[];
for k=1:side-1
    temp=zeros(side);
    temp(k,k+1) = 1;
    temp(k+1,k) = 1;
    A11 = [A11 sm2vec(temp)];
end

 %%%% adding QE constraint
 cons{1,1}='QRE';
 cons{1,2}=[side];
 A{1,1}= [zeros(1,size(A11,2)) 1; zeros(side^2,size(A11,2)) zeros(side^2,1); A11 zeros(side^2,1)];
 b{1,1}=[0;sm2vec(M);sm2vec(eye(side))];
 
 
c=[zeros(1,size(A11,2)) 1];

[x,y,info]=DDS(c,A,b,cons);


