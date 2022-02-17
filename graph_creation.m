function G = graph_creation(n, e, s)

if e > n^2
    disp('The number of arcs is too high')
    return            
end

rng(s, 'twister'); 

i=1;
j=1;

G = digraph([1]);

while i<n

    newNode = i+1;
    arcStarts = randi(i,1);
    
    G = addedge(G,arcStarts,newNode,1);
    
    i=i+1;
    j=j+1;
end

while j<e
    
    startingNode = randi(i,1);
    arrivingNode = randi(i,1);

    if findedge(G, [startingNode], [arrivingNode])==0
        G = addedge(G,startingNode,arrivingNode,1);
        j=j+1;
    end
end
