function [x, r, d, r_norm, ra_norm] = conjugate_gradient(A, b, n)

m = size(A, 1);

x = nan(m, n+1);
r = nan(m, n+1);
d = nan(m, n+1);

x(:, 1) = zeros(m, 1);
r(:, 1) = b;
d(:, 1) = b; 

for i = 1:n
    w = A*d(:,i);
    a = (r(:, i)'*r(:, i))/(d(:, i)'*w);
    x(:, i+1) = x(:, i) + a*d(:, i);
    r(:, i+1) = r(:, i) - a*w;
    c = (r(:, i+1)'*r(:, i+1))/(r(:, i)'*r(:, i));
    d(:, i+1) = r(:, i+1) + c*d(:,i);
end

s = A \ b;

r_norm = zeros(1, n);
ra_norm = zeros(1, n);

for i = 1:n+1
    r_norm(i) = norm(r(:,i));
    ra_norm(i) = (s - x(:, i))'*A*(s -x(:, i));
end
