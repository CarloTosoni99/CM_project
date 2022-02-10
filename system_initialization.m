% This method is used to create the system required by the project. The
% system is outlined by the matrices D, E, b and c. The first two are
% respectively a diagonal matrix and a edge-node adjacency matrix of a
% given direct graph G = (N, A). The graph G = (N, A) is created by the
% method graph_initialization. Finally, b and c are two vectors that
% represent the solution of the system. The function requires also the
% argument s, which is the seed for the function rng.

function [D, E, b, c] = system_initialization(G, s)

% firstly, we generate the adjacency matrix E, given the direct graph G
E = adjacency(G);


% the rng determines how the rand, randi, randn and randperm functions
% produce a sequence of random numbers. Below the default generator was
% inserted, while the seed depends on the argument passed by the user
rng(s, 'twister');

n = size(E, 1);


% Generating n random numbers in the interval (-10, 10). These extremes of
% the interval can be changed. The vector generated will be the diagonal of
% the digonal matrix D. The diagonal matrix D is positive-definite, so its
% eigenvalues must be strictly greater than 0.
max = 20;
min = 0.001;

d = (max-min)*rand(n,1) + min;

% now it is possible to generate the diagonal matrix
D = diag(d);

% The last step of the algorithm consists in the creation of the vectors b
% and c

max_b = 10;
min_b = -10;

max_c = 10;
min_c = -10;

b = (max_b-min_b)*rand(n, 1) + min_b;
c = (max_c-min_c)*rand(n, 1) + min_c;




