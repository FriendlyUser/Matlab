% David Li
% Graphs.m
% This program will plot and highlight a minimum spanning tree
s =       [ 3 2 4 2 8 7 7 6 5 6 7 1 1];
t =       [ 4 5 8 3 7 4 3 3 6 2 6 2 5];
weights = [ 6 2 7 5 3 5 4 5 1 2 3 6 1];
names = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H'};
G = graph(s,t,weights,names);
p = plot(G,'EdgeLabel',G.Edges.Weight);
[T,pred] = minspantree(G);
highlight(p,T)
