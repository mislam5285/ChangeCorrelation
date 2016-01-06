% The main method of sythetic data experiment.

GTFile = 'GroundTruth1' ;
DataFile = 'Subset1' ;

%{
GroundTruth = dlmread(GTFile);
data = dlmread(DataFile);
%}

DataSize = size(data,1);
Length = size(data,2);
% The window size in this method is 500
WindowSize = 1000 ;
 
TestDataIndex = zeros(100,1) ;
TestDataIndex(1:50,1) = 1:50 ;
TestDataIndex(51:100,1) = 5001:5050 ;

TestData = data(TestDataIndex,:);
TestGroundTruth = GroundTruth(TestDataIndex,:);
Bitstream = zeros(size(TestData,1),Length/WindowSize);

% Mapping to bit stream
for i=1:size(TestData,1)
%    i = 100 ;
	ts = TestData(i,:) ;
	%disp(i) ;
	for j=1:Length/WindowSize
%   j = 3
		startI = (j-1)*WindowSize + 1 ;
		endI = j*WindowSize ;
		Bitstream(i,j) = ChangeDetect(ts(startI:endI)) ;
	end
end

% Do Clustering
% Distance Type: 0. Minhash, 1. L1, 2. L2, 3. DTW, 4. Pearson, 5. Kendall tau rank Correlation, 6. Spearman Rank Correlation
ClusterNumber = 2 ;
TestGroundTruth = TestGroundTruth + ones(size(TestGroundTruth,1),1) ;


Matrix = SimilarityMatrix(Bitstream,0) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('HashCorrelation Measure: Accuracy: %f, NMI: %f',Acc,nmi);
disp(X) ;

%L1

Matrix = SimilarityMatrix(TestData,1) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('L1 Measure: Accuracy: %f, NMI: %f',Acc,nmi);
disp(X) ;


%L2
Matrix = SimilarityMatrix(TestData,2) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('L2 Measure: Accuracy: %f, NMI: %f',Acc,nmi);
disp(X) ;


%DTW

%QueryList = SearchFunction(QueryData,TestData,TopK,3) ;

%[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
%X = sprintf('DTW Distance: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
%disp(X) ;

%Pearson

Matrix = SimilarityMatrix(TestData,4) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('Pearson Measure: Accuracy: %f, NMI: %f',Acc,nmi);
disp(X) ;

%Kendall

Matrix = SimilarityMatrix(TestData,5) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('Kendall Measure: Accuracy: %f, NMI: %f',Acc,nmi);
disp(X) ;


%Spearman

Matrix = SimilarityMatrix(TestData,6) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') 
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('Spearman Measure: Accuracy: %f, NMI: %f',Acc,nmi);
disp(X) ;

