# DDS (Domain-Driven Solver)
Domain-Driven Solver (DDS) is a MATLAB-based software package for convex optimization problems in Domain-Driven form. The current version of DDS accepts every combination of the following function/set constraints: 
- Symmetric cones (LP, SOCP, and SDP)
- Quadratic constraints that are SOCP representable 
- Direct sums of an arbitrary collection of 2-dimensional convex sets defined as the epigraphs of univariate convex
functions (including as special cases geometric programming and entropy programming)
- Qeneralized power cone
- Epigraphs of matrix norms (including as a special case minimization of nuclear norm over a linear subspace)
- Vector relative entropy
- Quantum entropy and quantum relative entropy
- Hyperbolic polynomials

DDS is a practical implementation of the infeasible-start primal-dual algorithm designed and analyzed in \cite{karimi_arxiv}. 
