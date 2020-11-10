
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This file contains the lines of code for solving some problems from
%% the Dimacs LP-SOCP-SDP library. 
%% DDS has a built-in function read_sedumi_DDS to read problems in sedumi
%% input format. You can use either of the following commands based on the
%% sedumi format file

%%  [c,A,b,cons]=read_sedumi_DDS(At,b,c,K);
%%  [c,A,b,cons]=read_sedumi_DDS(A,b,c,K);

%% Copyright (c) 2020, by 
%% Mehdi Karimi
%% Levent Tuncel
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load copo14.mat
fprintf('\n  ..... Problem: copo14  \n');
[c,A,b,cons]=read_sedumi_DDS(A,b,c,K);
[x,y,info]=DDS(c,A,b,cons);


load cphil10.mat
fprintf('\n  ..... Problem: cphil10  \n');
[c,A,b,cons]=read_sedumi_DDS(At,b,c,K);
[x,y,info]=DDS(c,A,b,cons);


load copo23.mat
fprintf('\n  ..... Problem: copo23  \n');
[c,A,b,cons]=read_sedumi_DDS(A,b,c,K);
[x,y,info]=DDS(c,A,b,cons);


load nb_L2.mat
fprintf('\n  ..... Problem: nb_L2  \n');
[c,A,b,cons]=read_sedumi_DDS(At,b,c,K);
[x,y,info]=DDS(c,A,b,cons);


load toruspm3-8-50.mat
fprintf('\n  ..... Problem: toruspm3-8-50  \n');
[c,A,b,cons]=read_sedumi_DDS(A,b,c,K);
[x,y,info]=DDS(c,A,b,cons);

