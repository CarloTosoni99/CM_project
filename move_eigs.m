% this function is used to move the eigenvalues of the system [D E'; E 0][x
% ; y] = [b; c] to the right of the euclidian plane. This is important when
% we execute MINRES on this system because it tends to have a cluster of
% eigenvalues in the origin of the euclidian plane. Actuallly, as we have
% written in our relation, MINRES converges more slowly in the system has
% eigenvalues with a module close to zero. This function solves this
% problem by computing a matrix P in order to move toward right all the
% eigenvalues of the system Ax = b. MINRES converges faster in the system 
% PAx = Pb, please read the relation related to the project for more 
% details.

function P = move_eigs(A, pos)

n = size(A,1);
disp(n)

% We have computed PA such that PA = A + pos*eye(n) 
P = speye(n) + ((pos*speye(n))/A); 
