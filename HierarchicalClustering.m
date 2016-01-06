function [ clusterResult ] = HierarchicalClustering( Matrix, ClusterNumber )
%HIERARCHICALCLUSTERING Summary of this function goes here

Matrix=Matrix-diag(diag(Matrix)-diag(0)) ;
Y = pdist(Matrix) ;
% hierarchical clustering
% Some other cluster method also OK
Z = linkage(Y ,'average'); %single,average,centroid,complete,median,ward
%dendrogram(Z,0);
clusterResult = cluster(Z,ClusterNumber) ;

end

