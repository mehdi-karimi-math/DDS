
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% An example to check if DDS 2.0 is running properly. 

%% Copyright (c) 2020, by 
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 clearvars c A b cons;
 
 % adding LP constraint
 cons{1,1}='LP';
 cons{1,2}=[2];
 A{1,1}=eye(2);
 b{1,1}=[0;0];
 
 % adding SOCP constraint
 cons{2,1}='SOCP';
 cons{2,2}=[2];
 A{2,1}=[0 0; eye(2)];
 b{2,1}=[1;0;0];

% adding SDP constraint
 cons{3,1}='SDP';
 cons{3,2}=[2];
 A{3,1}=[sm2vec([1 0;0 0])  sm2vec([0 0;0 1])];
 b{3,1}=sm2vec([0 0;0 0]);
 
% adding QC constraint
 cons{4,1}='GPC';
 cons{4,2}={[2 2], [.2 .8]};
 A{4,1}=[eye(2); eye(2)];
 b{4,1}=[1;1;0;0];
 
% adding redundant MN constraint
 cons{5,1}='MN';
 cons{5,2}=[10 50];
 A{5,1}=zeros(600,2);
 b{5,1}=[zeros(500,1); sm2vec(eye(10))];
 
 % adding TD constraint
 cons{6,1}='TD';
 cons{6,2}={[3 1],[1]};
 A{6,1}=[0 0;1 1];
 b{6,1}=[-1;0];
 
 % adding RE constraint
 cons{7,1}='RE';
 cons{7,2}=[3];
 A{7,1}=[0 0;0 0;1 1];
 b{7,1}=[-1;1;0];
  
 % adding HB constraint
 cons{8,1}='HB';
 cons{8,2}=[2];
 cons{8,3}=[2 0 1;0 2 -1];
 cons{8,4}='monomial';
 cons{8,5}=[1;0];
 A{8,1}=eye(2);
 b{8,1}=[0;0];
 
% adding EQ constraint
 cons{9,1}='EQ';
 cons{9,2}=[1];
 A{9,1}=[1 1];
 b{9,1}=1;
 
 c=[-1;-1];
 
 % profile on
 [x,y,info]=DDS(c,A,b,cons);
 % profile report
 
 