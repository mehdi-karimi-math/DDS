%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This problem is an LP-SDP problem with three variables. We want to 
%% find the maximum eigenvalue of A0+x_1*A1+x_2*A2+x_3A3 while 
%%      x_1+x_2+x_3 >= 1.
%% We add a redundant varibale t; the problem is 
%%   minimize t
%%   s.t.   x_1+x_2+x_3 >= 1
%%          tI-(A0+x_1*A1+x_2*A2+x_3A3) >= 0 
%%             

%% Copyright (c) 2022, by 
%% Mehdi Karimi
%% Levent Tuncel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 clearvars A b cons c;

 % adding LP constraint
 cons{1,1}='LP';
 cons{1,2}=[1 2];
 A{1,1}=[1 1 1 0; 0 0 0 0; 0 0 0 0];
 b{1,1}=[-1,1,2];

 
 % adding SDP constraint
 cons{3,1}='SDP';
 cons{3,2}=[3];
 
 A1=[0 1 0;1 0 0;0 0 0]; 
 A2=[0 0 1; 0 0 0; 1 0 0];
 A3=[0 0 0;0 0 1; 0 1 0];
 A0=[2 -.5 -.6;-.5 2 0.4; -.6 .4 3];
 
 A{3,1}=[ -sm2vec(A1)   -sm2vec(A2)  -sm2vec(A3)  sm2vec(eye(3))];
 b{3,1}=[-sm2vec(A0)];

 cons{2,1}='SDP';
 cons{2,2}=[3];
 A{2,1}=zeros(9,4);
 b{2,1}=zeros(9,1);
 
 
 cons{4,1}='LP';
 cons{4,2}=[1];
 A{4,1}=[0 0 0 0];
 b{4,1}=[10];
 
 c=[0;0;0;1];

 %OPTIONS.tol=10^-8;
 %OPTIONS.x0=rand(4,1);
 %OPTIONS.z0=rand(10,1);
 
 [x,y,info]=DDS(c,A,b,cons);
 
 
% cvx_begin sdp
% variable x(4);
% minimize (c'*x)
% subject to 
%     -x(1)-x(2)-x(3) <= -1;
%     x(4)*eye(3) >= (A0+x(1)*A1+x(2)*A2+x(3)*A3);
% cvx_end
