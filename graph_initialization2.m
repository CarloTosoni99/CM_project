% This method is used to generate the direct graph G = (N, A). this graph
% is used to outline the matrix E, which is the edge-node incidence matrix 
% of G. The function requires n the number of nodes of the directed graph, 
% e the number of edges, seed an integer to generate random number and c a
% boolean variable equal to true if the directed graph must be weakly
% connected or equal to false otherwise. Moreover, the variable wcon_dim
% can be used to divide the graph in length(wcon_dim) sub-graphs, while 
% wcon_dim(i) indicates how many nodes there are in the i-th sub-graph 
% (pass the empty vector [] if you don't want to divide the graph in 
% sub-graphs), please note that the sub-graphs may not be weakly connected.
% If you want that each sub-graph of G must be weakly connected, set c =
% true.
function G = graph_initialization2(n, e, seed, c, wcon_dim)

% n is the number of nodes of the graph, while e is the number of edges

% the rng determines how the rand, randi, randn and randperm functions
% produce a sequence of random numbers. Below the default generator was
% inserted, while the seed depends on the argument passed by the user
rng(seed, 'twister'); 

% initializing the tails and the heads of the edges of the directed graph
s = zeros(1, e);
t = zeros(1, e);

% vector that stores how many edges there are for each sub-graph
wcon_edges = zeros(1, length(wcon_dim) + 1);
% how many nodes there are in the last sub-graph (the variable is
% consistent only if sum(wcon_dim(i)) < n)
last_com = n;
% The edges e are divided among the sub-graphs such that every sub-graph
% has a number of edges proportional to its nodes squared.
total_sqr_nodes = 0;


% here we check if sum(wcon_dim(i)) is greater than n (the total number of
% the sub-graphs' nodes cannot be greater than the total number of nodes,
% i.e n).
node_counter = 0;
for i = 1:length(wcon_dim)
    node_counter = node_counter + wcon_dim(i);
    if node_counter > n
        wcon_dim(i) = 0;
    end
end

% computing how many edges there must be for each node squared
for i = 1:length(wcon_edges)
    if i <= length(wcon_dim)
        total_sqr_nodes = total_sqr_nodes + wcon_dim(i) * wcon_dim(i);
        last_com = last_com - wcon_dim(i);
    else
        total_sqr_nodes = total_sqr_nodes + last_com * last_com;
    end    
end

% number of edges for each node squared
edg_per_sqr = e / total_sqr_nodes;

% Now we can divide the edges among the sub-graphs, please note that if 
% wcon_dim = [] there is not any sub-graph in G, and so all the edges are
% randomly generated among G's nodes.
for i = 1:length(wcon_edges)
    if i <= length(wcon_dim)
        wcon_edges(i) = floor(edg_per_sqr * (wcon_dim(i) * wcon_dim(i)));
    elseif last_com > 0
        wcon_edges(i) = floor(edg_per_sqr * (last_com * last_com));
    end
end

% finally, we can generate the heads and the tails of the G's edges
node_num = 1;
for i = 1:length(wcon_edges)
    if i <= length(wcon_dim) && wcon_dim(i) > 0
        s(node_num:node_num + wcon_edges(i) - 1) = randi([node_num node_num+wcon_dim(i)-1], 1, wcon_edges(i));
        t(node_num:node_num + wcon_edges(i) - 1) = randi([node_num node_num+wcon_dim(i)-1], 1, wcon_edges(i));
        node_num = node_num + wcon_dim(i);
    elseif last_com > 0
        s(node_num:node_num + wcon_edges(i) - 1) = randi([node_num node_num+last_com-1], 1, wcon_edges(i));
        t(node_num:node_num + wcon_edges(i) - 1) = randi([node_num node_num+last_com-1], 1, wcon_edges(i));
    end
end


% deleting buckles (edges from and to the same node), we cannot generate 
% the incidence matrix of a graph with buckles, hence, we have to delete 
% them.
b = false(e);
for i = 1:e
    if s(i) == t(i) || s(i) == 0 || t(i) == 0
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

% if the user has specified that all the sub-graphs must be weakly 
% connected, then we add edges to the graph until this condition is 
% satisfied
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
fprintf('The resulting graph G has %d total edges rather than the specified %d. \n', size(G.Edges,1), e);