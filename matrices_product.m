function A = matrices_product(E, D, d)

% This simple function is used to compute the vector ED^{-1}E'd (required
% for the algorithm A1 (conjugate gradient).

A = E*(D \ E')*d;