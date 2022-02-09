
function [Q, H] = arnoldi_iter(A, b, n, Q, H)

w = A*Q(:, n);


H2 = zeros(n+1, 1);

if n-1 > 0
    m = n-1;
else
    m = 1;
end

for i = m:n
    H2(i, 1) = Q(:,i)'*w;
    w = w - Q(:,i)*H2(i,1);
end

H2(n+1, 1) = norm(w);
q = w / H2(n+1, 1);
Q = [Q q];

cols = size(H, 2);
Z = zeros(1, cols);

if H == 0
    H = H2;
else
    H = [[H; Z] H2];
end
