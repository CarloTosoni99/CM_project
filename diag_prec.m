% For linear system solutions x = A\b, the condition number of A is important for 
% accuracy and efficiency of the calculation. equilibrate can improve the condition 
% number of A by rescaling the basis vectors. This effectively forms a new coordinate
% system to express both b and x in.eigs
function [B,d,M,precB,precd] = diag_prec(A,s)

[P,R,C] = equilibrate(A);
B = R*P*A*C; 
% B is a diagonal matrix with entries of magnitude 1, and its off-diagonal entries 
% are not greater than 1 in magnitude.
d = R*B*s;

cA = condest(A);
cB = condest(B);

fprintf(['The original matrix A had condition number %d.\n' ...
    'The new      matrix B has condition number %d. \n'], cA, cB);

M = sparse(diag(diag(B)));
precB = M*B;
precd = M*d;