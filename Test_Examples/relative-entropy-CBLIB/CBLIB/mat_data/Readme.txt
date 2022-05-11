This folder contains optimization problems in DDS format from the
CBLIB - The Conic Benchmark Library (https://cblib.zib.de/). 
These problems involve EXP cone constraints. The EXP constraints 
can be translated to either relative entropy (RE) or 2-dim convex
sets (TD) in the DDS format.

Each problem can be solved by the commands:

problem_name='...';
load(problem_name);
[x,y,info]=DDS(c,A,b,cons);

Copyright (c) 2022, by 
Mehdi Karimi
Levent Tuncel
