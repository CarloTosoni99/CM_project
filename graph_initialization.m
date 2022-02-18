% This method is used to generate the direct graph G = (N, A). this graph
% is used to outline the matrix E, which is edge-node incidence matrix of
% G. The function requires n the number of nodes of the directed graph, e 
% the number of edges, seed an integer to generate random number and c a
% boolean variable equal to true if the directed graph must be weakly
% connected or equal to false otherwise.

function G = graph_initialization(n, e, seed, c)

% n is the number of nodes of the graph, while e is the number of edges

% the rng determines how the rand, randi, randn and randperm functions
% produce a sequence of random numbers. Below the default generator was
% inserted, while the seed depends on the argument passed by the user
rng(seed, 'twister'); 

% creating the tails of the edges of the direct graph
s = randi([1 n], 1, e);

% creating the heads of the edges of the direct graph
t = randi([1 n], 1, e);

% deleting buckles, we cannot generate the incidence matrix of a graph with
% bucles, hence we have to delete them.

b = false(e);
for i = 1:e
    if s(i) == t(i)
        b(i) = true;
    end
end

i = 1;
while i <= length(b)
    if b(i)
        s(i) = [];
        t(i) = [];
        b(i) = [];
    else
        i = i + 1;
    end
end

% now we delete all the duplicates among the pairs <s, t>
A = [s' t'];
A = unique(A, 'rows');
s = A(:, 1)';
t = A(:, 2)';

% finally we create the directed graph
G = digraph(s, t);

% if the user has specified that the graph must be weakly connected, then
% we add edges to the graph until this condition is satisfied
if c == true
    endLoop = false;
    while(~endLoop)
        weak_bins = conncomp(G, 'Type', 'weak');
        startEdge = 0;
        endEdge = 0;
        endLoop = true;
        for i = 1:length(weak_bins)
            if weak_bins(i) ~= 1
                endLoop = false;
            end
            if weak_bins(i) ~= startEdge && weak_bins(i) ~= endEdge
                if startEdge == 0
                    startEdge = i;
                else
                    endEdge = i;
                    G = addedge(G, startEdge, endEdge);
                    startEdge = 0;
                    endEdge = 0;
                end
            end
        end
    end
end