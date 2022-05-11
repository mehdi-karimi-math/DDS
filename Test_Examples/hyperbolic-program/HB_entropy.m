%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Optimization problem with hyperbolic programming and entropy constraints. 
%% We want to minimize the entorpy of (x_1,x_2,x_3) subjet to another constraint
%% involving hyperbolic polynomials. 
%%                min t
%%                    x_1*ln(x_1)+x_2*ln(x_2)+x_3*ln(x_3) <= t. 
%%                          p(Ax+b) >= 0. 

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars c A b cons;

% adding hyperbolic constraint
 cons{1,1}='HB';
 cons{1,2}=[3];
 
 % we use the monomial format
 num_mon=3;
 num_var=3;
 cons{1,3}=sparse(num_mon,num_var+1);
 cons{1,3}(1,1)=1;  cons{1,3}(1,2)=1; cons{1,3}(1,4)=1;
 cons{1,3}(2,1)=1;  cons{1,3}(2,3)=1; cons{1,3}(2,4)=1;
 cons{1,3}(3,2)=1;  cons{1,3}(3,3)=1; cons{1,3}(3,4)=1;
 

 cons{1,4}='monomial';
 
 cons{1,5}=[1;1;1]; % a vector in the interior of the hyperbolicity cone defined by p(x) >= 0. 
 
 A{1,1}=[1 -1 1 0;
         0 1 -2 0;
         0 0 -1 0];
 b{1,1}=[0;0;0];
 
 % adding entropy constraint
 cons{2,1}='TD';
 cons{2,2}={[3 3], [1 1 1]};
 
 A{2,1}=[0 0 0 -1; 
         1 0 0 0; 
         0 1 0 0; 
         0 0 1 0];
 b{2,1}=[0;0;0;0];
 
 
 c=[0;0;0;1];
 
 [x,y,info]=DDS(c,A,b,cons);
