% This method is used to generate the direct graph G = (N, A). this graph
% is used to outline the matrix E, which is edge-node adjacency matrix of
% G. The function requires only the number of nodes of the direct graph and
% the number of edges, then the direct graph is randomly generated

function G = graph_initialization(n, e, s)

% n is the number of nodes of the graph, while e is the number of edges

% the rng determines how the rand, randi, randn and randperm functions
% produce a sequence of random numbers. Below the default generator was
% inserted, while the seed depends on the argument passed by the user
rng(s, 'twister'); 

% creating the tails of the edges of the direct graph
s = randi([1 n], 1, e);

% creating the heads of the edges of the direct graph
t = randi([1 n], 1, e);

% now we can create the direct graph
G = digraph(s, t);

