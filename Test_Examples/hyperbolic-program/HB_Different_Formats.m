%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% An example for hyperbolic programming. 
%% In this problem, we give the polynomial p(x)=x1^2-x2^2-x3^2 in three different 
%% formats that DDS accepts:

%%        - monomial list
%%        - straight_line program
%%        - determinantal

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars c A b cons;


 cons{1,1}='HB';
 cons{1,2}=[3]; % This vector is the number of variables in hyperbolic polynomial.
 
 %%%%% input the format: uncomment the format you want to choose. 
 cons{1,4}='monomial'; 
 % cons{1,4}='straight_line';
 % cons{1,4}='determinant'; 
 
 % cons{k,3} defines the polynomial. In the following, we give
 % p(x)=x1^2-x2^2-x3^2 in three different formats. 
 
 if strcmp(cons{1,4},'monomial')
 
     % Each row represents a monomial. The last column is the 
     % coefficient of the mononial, whereas the other columns are the power of 
     % variables. The following is for p(x)=x1^2-x2^2-x3^2.
     num_mon=3;
     num_var=3;
     cons{1,3}=sparse(num_mon,num_var+1);
     cons{1,3}(1,1)=2;  cons{1,3}(1,4)=1;
     cons{1,3}(2,2)=2;  cons{1,3}(2,4)=-1;
     cons{1,3}(3,3)=2;  cons{1,3}(3,4)=-1;

    %  cons{1,3}=[2     0     0     1;
    %             0     2     0    -1;
    %             0     0     2    -1];
    
 elseif strcmp(cons{1,4},'straight_line')
     
     % In the stright-line program, the cons{k,3} is a m-by-4 matrix, where each row
     % represent one simple operation between two functions. If x is of length
     % m, the first m functions are f_0=1; f_1=x_1,...,f_m=x_m. If the kth row of cons{k,3}
     % is  [a   f_i   f_j  operation], then 
     %               f_(k+m)=a*(f_i operation f_j), 
     % where operation can be 
     %                         '+' . operation 11
     %                         '-' . operation 22
     %                         '*' . operation 33
     %
     % For f(x)=x_1^2-x_2^2-x_3^2, we have at least one striaght-line
     % program:
     %

     cons{1,3}=[1   1   1  33; % f_4=f_1*f_1
                -1  2   2  33; % f_5=-f_2*f_2
                -1  3   3  33; % f_6=-f_3*f_3
                1   4   5  11; % f_7=f_4+f_5
                1   6   7  11];% f_8=f_6+f_7
    
 elseif strcmp(cons{1,4},'determinant')
     
     % For the determinantal representaion,
     % we have p(x)=det(H_0+x_1H_1+...+x_mH_m), where H_0,...,H_m are symmetric matrices.  
     % In this case, we have
     %        cons{k,3}=[sm2vex(H_0)  sm2vec(H_1) ...  sm2vec(H_m)]

     % For example, for f(x)=x_1^2-x_2^2-x_3^2, we have 

     H0=[0 0;0 0];  H1=[1 0;0 1]; H2=[1 0;0 -1]; H3=[0 1;1 0];
     cons{1,3}=[sm2vec(H0) sm2vec(H1) sm2vec(H2) sm2vec(H3)];
 end
     

 
 cons{1,5}=[1;0;0]; % a vector in the interior of the hyperbolicity cone defined by p(x) >= 0. 
 
 A{1,1}=[1 0; 0 1;1 1];
 b{1,1}=[-1;-1;1];
 
 c=[1;0];
 
 
 [x,y,info]=DDS(c,A,b,cons);
