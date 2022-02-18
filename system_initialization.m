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
% because the matrix is positive-definite for definition. The other
% eigenvalues not directly specified by the user are ctreated between
% range(0) and range(1).

function [D, E, b, c] = system_initialization(G, eig_val, dim, range, s)

% firstly, we generate the incidence matrix E, given the direct graph G
E = incidence(G);


% the rng determines how the rand, randi, randn and randperm functions
% produce a sequence of random numbers. Below the default generator was
% inserted, while the seed depends on the argument passed by the user
rng(s, 'twister');

n = size(E, 1); % number of nodes
m = size(E, 2); % number of edges

% Now we can intialize the vector fo the eigenvalues
d = nan(1,m);

% We insert the eigenvalues passed by the user in the vector d
j = 1;
for i = 1:length(eig_val)
    % the matrix D is positive definite, hence its eigenvalues must be > 0
    if (eig_val(i) > 0 & j+dim(i)-1 <= m)
        d(j:j+dim(i)) = eig_val(i);
        j = j + dim(i);
    end
end

% The other eigenvalues not specified by the user are randomly created in
% the range from range(1) to range(2) (range is a varibale passed by the
% user). if the user has not passed this variable to the function, the
% eigenvalues are created between (0, 20].

if (j <= m)
    max = 20;
    min = 0.001;
    if ~isnan(range)
        if range(1) > 0
            min = range(1);
        end
        if range(2) > 0 && range(2) > min
            max = range(2);
        elseif range(2) > 0 && range(2) <= min
            max = min + 20;
        end
    end
    
    d(j:m) = (max-min)*rand(m-j+1,1) + min;
end

% now it is possible to generate the diagonal matrix
D = diag(d);

% The last step of the algorithm consists in the creation of the vectors b
% and c (the vector b is created randomly while c for simplicity is the
% null vector).

max_b = 10;
min_b = -10;

max_c = 0;
min_c = 0;

b = (max_b-min_b)*rand(m, 1) + min_b;
c = (max_c-min_c)*rand(n, 1) + min_c;




