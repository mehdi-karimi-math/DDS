This folder contains optimization problems in DDS format involving 
hyperbolic programming constraints.  

Each problem can be solved by the commands:

problem_name='...';
load(problem_name);
[x,y,info]=DDS(c,A,b,cons);

Copyright (c) 2020, by 
Mehdi Karimi
Levent Tuncel