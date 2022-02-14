% This method is used to create the system required by the project. The
% system is outlined by the matrices D, E, b and c. The first two are
% respectively a diagonal matrix and a edge-node adjacency matrix of a
% given direct graph G = (N, A). The graph G = (N, A) is created by the
% method graph_initialization. Finally, b and c are two vectors that
% represent the solution of the system. The function requires also the
% argument s, which is the seed for the function rng. The user can also
% specify which must be the eigenvalues on the diagonal matrix D, through
% the parameters eig_val (i.e. the eigenvalues of the diagonal matrix) and
% dim (how many times an eigenvalue is a root of the characteristic
% polynomial), remeber that the eigenvalues must be strictly greater than 0
% because the matrix is positive-definite for definition

function [D, E, b, c] = system_initialization(G, eig_val, dim, s)

% firstly, we generate the adjacency matrix E, given the direct graph G
E = adjacency(G);


% the rng determines how the rand, randi, randn and randperm functions
% produce a sequence of random numbers. Below the default generator was
% inserted, while the seed depends on the argument passed by the user
rng(s, 'twister');

n = size(E, 1);

% Now we can intialize the vector fo the eigenvalues
d = nan(1,n);

% We insert the eigenvalues passed by the user in the vector d
j = 1;
for i = 1:length(eig_val)
    % the matrix D is positive definite, hence its eigenvalues must be > 0
    if (eig_val(i) > 0 & j+dim(i)-1 <= n) 
    d(j:j+dim(i)) = eig_val(i);
    j = j + dim(i);
    end
end

% The other eigenvalues not specified by the user are created randonmly in
% the range (0, 20].

if (j <= n)
    max = 20;
    min = 0.001;
    
    d(j:n) = (max-min)*rand(n-j+1,1) + min;
end

% now it is possible to generate the diagonal matrix
D = diag(d);

% The last step of the algorithm consists in the creation of the vectors b
% and c (they are created randomly).

max_b = 10;
min_b = -10;

max_c = 10;
min_c = -10;

b = (max_b-min_b)*rand(n, 1) + min_b;
c = (max_c-min_c)*rand(n, 1) + min_c;




