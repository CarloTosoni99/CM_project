function [r2, r3] = compute_norm(E, D, b, c, x, r)

% This function was created to study how the norm (r2) and the A norm (r3)
% of the conjugate gradient decreases at each step. Thanks to the best
% approximation property of the conjugate gradient, we know that at each
% step the algorithm finds the vector x belonging to K_{j}(A,b) that
% best approximates the solution in the A norm. 

d = E*(D\b) - c;
A = E*(D \ E');

s = A \ d;
n = size(x, 2);

r2 = zeros(1, n);
r3 = zeros(1, n);

for i = 1:n
    r2(i) = norm(r(:,i));
    r3(i) = (s - x(:, i))'*A*(s -x(:, i));
end
