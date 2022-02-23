function [A, s] = system_assembly(D, E, b, c);

% This simple function is used to compute the system in the form Ax = s
% given the matrices D, E, b and c.


n = size(E, 1);
Z = zeros(n);
A = [D E'; E Z];
s = [b; c];