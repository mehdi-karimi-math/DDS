# DDS (Domain-Driven Solver) version 3.0
Previous version DDS 2.1 [![DOI](https://zenodo.org/badge/302381874.svg)](https://zenodo.org/badge/latestdoi/302381874)

Domain-Driven Solver (DDS) is a MATLAB-based software package for convex optimization problems in Domain-Driven form. The current version of DDS accepts every combination of the following function/set constraints: 
- Symmetric cones (LP, SOCP, and SDP)
- Quadratic constraints that are SOCP representable 
- Direct sums of an arbitrary collection of 2-dimensional convex sets defined as the epigraphs of univariate convex
functions (including as special cases geometric programming and entropy programming)
- Generalized power cone
- Epigraphs of matrix norms (including as a special case minimization of nuclear norm over a linear subspace)
- Vector relative entropy
- Quantum entropy and quantum relative entropy
- Hyperbolic polynomials

DDS is a practical implementation of the infeasible-start primal-dual algorithm designed and analyzed in [this paper](https://arxiv.org/abs/1804.06925). 

## Updates
- **DDS 3.0**, released in **January 2026**, includes a fundamental update for solving **hyperbolic programming** problems, enabling efficient handling of polynomials represented as **straight-line programs (SLPs)**.
- **DDS 2.2** is released in Dec 2023, with extensive update for **quantum relative entropy (QRE) programming**. The current version can solve much larger instances of QRE programming. Please see [this paper](https://arxiv.org/abs/2312.07438).

## Installation 
To use DDS, the user can follow these steps:

- run MATLAB in the directory DDS;
- run the m-file `DDS_startup.m`.
-  (optional) run the prepared small examples `DDS_example_1.m` and `DDS_example_2.m`.

The prepared examples contain many set constraints accepted by DDS and running them without error indicates that DDS is ready to use. There is a directory `Text_Examples` in the DDS package which includes many examples on different classes of convex optimization problems. 

## How to use DDS

The command in MATLAB that calls DDS is 
```
[x,y,info]=DDS(c,A,b,cons,OPTIONS);
``` 

**Input Arguments:**
- `cons`:  A cell array that contains the information about the type of constraints. 
- `c,A,b`: Input data for DDS: `A` is the coefficient matrix, `c` is the objective vector, `b` is the RHS vector (i.e., the shift in the definition of the convex domain D). 
- `OPTIONS` (optional): An array which contains information about the tolerance  and initial points.  

**Output Arguments:**
- `x`: Primal point. 
- `y`: Dual point which is a cell array. Each cell contains the dual solution for the constraints in the corresponding cell  in `A`. 
- `info`: A structure array containing performance information such as `info.time`, which returns the CPU time for solving the problem. 

To see how to define `c,A,b,cons` and how to add different types of set/function constraints, please see the [users' guide](DDS_users_guide_V2.1.pdf). 

## Citing
To cite DDS software package in your work, you can cite [this paper](https://arxiv.org/abs/1908.03075v2).

To cite DDS 2.2 for solving quantum relative entorpy (QRE), please additionally cite [this paper](https://arxiv.org/abs/2312.07438).
