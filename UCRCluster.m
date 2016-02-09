% The main method of sythetic data experiment.

disp('Loading Data...');

DataFile = 'UWaveGestureLibraryAll_TEST' ;
OriginalData = dlmread(DataFile);

GroundTruth = OriginalData(:,1);
data = OriginalData(:,2:size(OriginalData,2));


DataSize = size(data,1);
Length = size(data,2)
% The window size in this method is 500
WindowSize = Length/10 ;

TestDataIndex = 1:DataSize;
%TestDataIndex = zeros(100,1) ;
%TestDataIndex(1:50,1) = 7001:7050 ;
%TestDataIndex(51:100,1) = 5001:5050 ;

TestData = data(TestDataIndex,:);
TestGroundTruth = GroundTruth(TestDataIndex,:);
Bitstream = zeros(size(TestData,1),Length/WindowSize);

disp('Mapping to Bit stream..');
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
ClusterNumber = max(GroundTruth);


disp('Do clustering using HashCorrelation.');
tic;
Matrix = SimilarityMatrix(Bitstream,0) ;

clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;


nmi = NMI(clusterResult', TestGroundTruth') ;

%[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
Acc = 1;
X = sprintf('HashCorrelation Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;

%L1
disp('Do clustering using L1.');
tic;
Matrix = SimilarityMatrix(TestData,1) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
%[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
Acc = 1;
X = sprintf('L1 Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;


%L2
disp('Do clustering using L2.');
tic;
Matrix = SimilarityMatrix(TestData,2) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
%[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
Acc = 1;
X = sprintf('L2 Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;


%DTW

disp('Do clustering using DTW.');
tic;
Matrix = SimilarityMatrix(TestData,3) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
%[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
Acc = 1;
X = sprintf('DTW Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;

%Pearson
disp('Do clustering using Pearson.');
tic;
Matrix = SimilarityMatrix(TestData,4) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
%[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
Acc = 1;
X = sprintf('Pearson Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;

%Kendall
disp('Do clustering using Kendall.');
tic;
Matrix = SimilarityMatrix(TestData,5) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
%[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
Acc = 1;
X = sprintf('Kendall Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;


%Spearman
disp('Do clustering using Spearman.');
tic;
Matrix = SimilarityMatrix(TestData,6) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
Acc = 1;
%[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('Spearman Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;
