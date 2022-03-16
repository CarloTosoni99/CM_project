
function [x, Q2, H, r] = myminres(A, b, n)

% first step of the algorithm, we have to compute the first vector of the
% orthonormal basis Q, this is actually easy to compute, indeed we have
% just to divide b by its norm. (in our code Q1 represents the matrix Q_{n}
% while Q2 represents the matrix Q_{n+1}.
Q1 = b / norm(b);
% now we can enter in the for loop and we can update at each step the
% matrices H and Q, at each step we will find a better approximation of the
% system
H = 0;
r = nan(1, n);
for i = 1:n
    [Q2, H] = arnoldi_iter(A, b, i, Q1, H);
    % now at each step we have to solve the system ||(Hy-e1||b||)||, finding
    % the best vector y to minimize the residual in R^n, after that, we can
    % compute the vector x in K_n(A,b) solving x = Qy.
    y = H \ (eye(i+1,1)*norm(b));
    x = Q1*y;
    % to study how faster the algorithm is converging to the solution of
    % the system, the function computes at each step the residual.
    r(i) = norm(A*x - b);

    Q1 = Q2;
end
