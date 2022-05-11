%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This optimization problem has hyperbolic programming, SDP and LP constraints. 
%% We want to minimize x_1+x_2+x_3 while A0+x_1*A1+x_2*A2+x_3A3 is positive semidefinite. 
%% In addition, we want 
%%             x_1x_2+x_2x_3+x_1x_3 >= 0. 

%% We also have the linear constraint x_1+x_2 >= 2. 

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 % adding LP constraint
 cons{1,1}='LP';
 cons{1,2}=[1];
 A{1,1}=[1 1 0];
 b{1,1}=[-2];
 
 % adding SDP constraint
 cons{2,1}='SDP';
 cons{2,2}=[3];
 
 A1=[0 1 0;1 0 0;0 0 0]; 
 A2=[0 0 1; 0 0 0; 1 0 0];
 A3=[0 0 0;0 0 1; 0 1 0];
 A0=[1 0 0;0 1 1;0 1 1];
 
 A{2,1}=[sm2vec(A1)   sm2vec(A2)  sm2vec(A3)];
 b{2,1}=sm2vec(A0);

 % adding HB constraint
 cons{3,1}='HB';
 cons{3,2}=[3]; 
 
 % we use the monomial format
 num_mon=3;
 num_var=3;
 cons{3,3}=sparse(num_mon,num_var+1);
 cons{3,3}(1,1)=1;  cons{3,3}(1,2)=1; cons{3,3}(1,4)=1;
 cons{3,3}(2,1)=1;  cons{3,3}(2,3)=1; cons{3,3}(2,4)=1;
 cons{3,3}(3,2)=1;  cons{3,3}(3,3)=1; cons{3,3}(3,4)=1;

 cons{3,4}='monomial'; % shows the format of the polynomial
 cons{3,5}=[1;1;1]; % a vector in the interior of the hyperbolicity cone defined by p(x) >= 0. 
 
 A{3,1}=[1 0 0; 0 1 0;0 0 1];
 b{3,1}=[0;0;0];
 
 % objective function
 c=[1;1;1];
 
 [x,y,info]=DDS(c,A,b,cons);
 
  
