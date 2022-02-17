% This method is used to generate the direct graph G = (N, A), which will then be
% used to outline the matrix E, which is its incidency matrix.
% The function requires only the number of nodes (n) of the direct graph,
% the number of edges (e) and a random seed (for replicability purposes), then the direct
% graph is randomly generated.

function G = graph_creation(n, e, s)

% a connected graph has at most n to the power of 2 edges, where n is the number of
% nodes
if e > n^2
    disp('The number of arcs is too high')
    return            
end

% as mentioned before, the rng determines how the randi function produces a sequence 
% of random numbers. Below the default generator was inserted, while the seed depends 
% on the argument passed by the user
rng(s, 'twister'); 

% we define the iterators for n and e
i=1;
j=1;

% we start with a definite graph of a node connected with itself
G = digraph([1]);

% then we fill the number of nodes required
while i<n

    % to define a new arc, we take a node at random from those we already have and...
    arcStarts = randi(i,1);

    % ... we generate a new node
    newNode = i+1;
    
    % then we create the arc
    G = addedge(G,arcStarts,newNode,1);
    
    i=i+1;
    j=j+1;
end

% now that we have a connected graph, we can add arcs at random
while j<e
    % we select two nodes
    startingNode = randi(i,1);
    arrivingNode = randi(i,1);
    
    % we don't want to add more than one directed arc between any two nodes
    if findedge(G, [startingNode], [arrivingNode])==0
        G = addedge(G,startingNode,arrivingNode,1);
        j=j+1;
    end
end
