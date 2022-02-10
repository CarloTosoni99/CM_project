% Arnoldi algorithm
% this algorithm is used by GMRES to compute a good approximation of the
% system's solution

function [Q, H] = arnoldi(A, b, n)

% returns a matrix Q of size m x (n+1)
% whose columns are a basis of K_{n+1}(A,b)
% the algorthm return also the matrix H of the coefficients
% H is a matrix of dimension (n+1) x n

m = length(b); % number of rows of the matrix Q
Q = zeros(m, n+1); % initializing Q
H = zeros(n+1, n); % initializing H
Q(:,1) = b / norm(b); % First vector of the orthonormal basis
for j = 1:n
    % Computing the vector w to find an orthonormal basis for K_{i+1}(a,b)
    % Here the compute should provide a black box, or by simply define the
    % method to compute the product
    w = A*Q(:,j); % !!!!!
    for i = 1:j
        % at each step we compute the coefficient h_{j,i} and we 
        % substract the vector h_{j,i}q_{j} until only h_{j,j+1}q_{j+1}
        % remain. At this point, we can compute easily q_{j+1}
        % (by division) and store it, we store also all the coefficients in
        % the matrix h
        H(i,j) = Q(:,i)'*w;
        w = w - Q(:,i)*H(i,j);
    end
    H(j+1,j) = norm(w);
    Q(:,j+1) = w / H(j+1,j);
end