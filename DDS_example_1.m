%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% An example to check if DDS 2.1 is running properly.

%% Copyright (c) 2024, by
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 clearvars c A b cons;
 
 % adding LP constraints
 cons{1,1}='LP';
 cons{1,2}=[2];
 A{1,1}=eye(2);
 b{1,1}=[0;0];
 
 % adding SOCP constraints
 cons{2,1}='SOCP';
 cons{2,2}=[2];
 A{2,1}=[0 0; eye(2)];
 b{2,1}=[1;0;0];

% adding SDP constraints
 cons{3,1}='SDP';
 cons{3,2}=[2];
 A{3,1}=[sm2vec([1 0;0 0])  sm2vec([0 0;0 1])];
 b{3,1}=sm2vec([0 0;0 0]);
 
% adding QC constraints
 cons{4,1}='QC';
 cons{4,2}=[1];
 cons{4,3,1}=[1];
 A{4,1}=[0 0;1 1];
 b{4,1}=[-3;0];
 
 % adding MN constraints
 cons{5,1}='MN';
 cons{5,2}=[1 2];
 A{5,1}=[1 0; 0 1;0 0];
 b{5,1}=[0;0;5];
 
 % adding TD constraints
 cons{6,1}='TD';
 cons{6,2}={[1 1],[1]};
 A{6,1}=[0 0;1 1];
 b{6,1}=[-1;0];
 
 % adding RE constraints
 cons{7,1}='RE';
 cons{7,2}=[3];
 A{7,1}=[0 0;0 0;1 1];
 b{7,1}=[-1;1;0];
 
 % adding QE constraints
 cons{8,1}='QE';
 cons{8,2}=[2];
 A{8,1}=[0 0;sm2vec([1 0;0 0]) sm2vec([0 0;0 1])];
 b{8,1}=[1;0;0;0;0];
 
 
% adding redundant LP constraints
 cons{9,1}='LP';
 cons{9,2}=[100];
 A{9,1}=zeros(100,2);
 b{9,1}=rand(100,1);
 
 % adding redundant SDP constraints
 cons{10,1}='SDP';
 cons{10,2}=[5];
 A{10,1}=zeros(25,2);
 b{10,1}=sm2vec(eye(5));
 
 % objective function
 c=[-1;-1];
 
 [x,y,info]=DDS(c,A,b,cons);

 
 
