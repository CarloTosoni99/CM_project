function [x, r, d] = conjugate_gradient(E, D, b, c, f, n)

% this method is used to apply the conjugate gradient method to our system,
% the algorithm at each step computes three vectors. These are x, which is
% the vector belonging to K_{j}(A,b) that is the best approximation of the
% system's solution in the A norm, r is the residual of the system or the
% sign-changed gradient of the quadratic form associated to the system.
% Finally, d is the conjugate vector (or orthogonal wrt the inner product
% defined by A), d represents the direction where the algortihm moves at 
% each step.

m = size(E, 1);
% Initializing the matrices returned by the system
x = nan(m, n+1);
r = nan(m, n+1);
d = nan(m, n+1);

s = E*(D\b) - c;

x(:, 1) = zeros(m, 1); % that is the initial position of the algorithm, 
% we start from 0

r(:, 1) = s; % when the algorithm starts both r and d are equal to 0 (since 
d(:, 1) = s; % both are the sign-changed gradient of the system for x = 0) 

for i = 1:n
    % The product among matrices ED^{-1}E'd(:,i) is computed by the
    % callback function f, the result w is computed once and used for both
    % a and r
    w = f(E, D, d(:, i));
    a = (r(:, i)'*r(:, i))/(d(:, i)'*w);
    x(:, i+1) = x(:, i) + a*d(:, i);
    r(:, i+1) = r(:, i) - a*w;
    c = (r(:, i+1)'*r(:, i+1))/(r(:, i)'*r(:, i));
    d(:, i+1) = r(:, i+1) + c*d(:,i);
end

