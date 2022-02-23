% This method is used to create the system required by the project. The
% system is outlined by the matrices D, E, b and c. The first two are
% respectively a diagonal matrix and a edge-node adjacency matrix of a
% given direct graph G = (N, A). The graph G = (N, A) is created by the
% method graph_initialization. Finally, b and c are two vectors that
% represent the solution of the system. The function requires also the
% argument seed, which is the seed for the function rng. The user can also
% specify which must be the eigenvalues on the diagonal matrix D, through
% the parameters eig_val (i.e. the eigenvalues of the diagonal matrix) and
% dim (how many times an eigenvalue is a root of the characteristic
% polynomial), remeber that the eigenvalues must be strictly greater than 0
% because the matrix is positive-definite for definition. The other
% eigenvalues not directly specified by the user are created between
% range(0) and range(1). The argument lin_dep (linear dependency) is a 
% boolean variable, if it is equal to true the vector c will be created 
% such that then the system Ex = c will admit solution (sum of c's 
% components equal to zero for each weakly connected components of G), 
% otherwise the system will not admit any solution. Finally del_row is
% another boolean variable, if it is equal to true the function will remove
% a row of E and c for each weakly connected component of G restoring the
% linear independence

function [D, E, b, c] = system_initialization(G, eig_val, dim, range, lin_dip, del_row, seed)

% firstly, we generate the incidence matrix E, given the direct graph G
E = incidence(G);


% the rng determines how the rand, randi, randn and randperm functions
% produce a sequence of random numbers. Below the default generator was
% inserted, while the seed depends on the argument passed by the user
rng(seed, 'twister');

n = size(E, 1); % number of nodes
m = size(E, 2); % number of edges

% Now we can intialize the vector fo the eigenvalues
d = nan(1,m);

% We insert the eigenvalues passed by the user in the vector d
j = 1;
for i = 1:length(eig_val)
    % the matrix D is positive definite, hence its eigenvalues must be > 0
    if (eig_val(i) > 0 && j+dim(i)-1 <= m)
        d(j:j+dim(i)-1) = eig_val(i);
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
% and c. Firstly, the vector b is created randomly

max_b = 10;
min_b = -10;

b = (max_b-min_b)*rand(m, 1) + min_b;

% If lin_dip == true, the vector c is created such that the sum of its 
% components is equal to zero for each connected components of G. In this 
% way the system Ex = c admits solutions for the Rouché-Capelli theorem.

max_c = 5;
min_c = -5;
c = zeros(n, 1);

if (lin_dip)
    weak_bins = conncomp(G, 'Type', 'weak');
    num_conncomp = 0;
    for i = 1:n
        if weak_bins(i) > num_conncomp
            num_conncomp = weak_bins(i);
        end
    end
    
    num_nodes = zeros(1,num_conncomp);
    for i = 1:n
        num_nodes(weak_bins(i)) = num_nodes(weak_bins(i)) + 1;
    end
    
    sum = zeros(1, num_conncomp);
    for i = 1:n
        if num_nodes(weak_bins(i)) > 1
            c(i) = (max_c-min_c)*rand() + min_c;
            sum(weak_bins(i)) = sum(weak_bins(i)) + c(i);
            num_nodes(weak_bins(i)) = num_nodes(weak_bins(i)) - 1;
        else
            c(i) = -sum(weak_bins(i));
        end
    end

else
% if lin_dip == false, the vector c is randomly created.
    c = (max_c-min_c)*rand(n, 1) + min_c;

end


% if del_row = true, k rows will be eliminated from E and c in order to
% restore the linear independence of their rows (k is the number of weakly
% connected components of E).
if (del_row)
    weak_bins = conncomp(G, 'Type', 'weak');
    num_conncomp = 0;
    for i = 1:n
        if weak_bins(i) > num_conncomp
            num_conncomp = weak_bins(i);
        end
    end

    deleted = false(1, num_conncomp);
    i = 1;
    j = 1;
    while(i <= size(E, 1))
        if(~deleted(weak_bins(j)))
            deleted(weak_bins(j)) = ~deleted(weak_bins(j));
            E(i,:) = [];
            c(i) = [];
        else
            i = i + 1;
        end
        j = j + 1;
    end
end