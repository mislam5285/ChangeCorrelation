% The main method of sythetic data experiment.

disp('Loading Data...');
GTFile = 'GroundTruth4' ;
DataFile = 'Subset4' ;
GroundTruth = dlmread(GTFile);
data = dlmread(DataFile);

% The window size in this method is 500
WindowSize = 200 ;
syms TestDataIndex;


syms TestDataDimension;

DataSetType = 3 ;

switch DataSetType
	case 0
		TestDataIndex = 1:10000;
		TestDataDimension = 1:5000;
	case 1
		TestDataIndex = 1:10000;
		TestDataDimension = 1:2000;
	case 2
		TestDataIndex = 1:10000;
		TestDataDimension = 1:800;
	case 3
		TestDataIndex = zeros(5000,1);
		TestDataIndex(1:1000,1) = 1:1000 ;
		TestDataIndex(1001:2000,1) = 2001:3000 ;
		TestDataIndex(2001:3000,1) = 4001:5000 ;
		TestDataIndex(3001:4000,1) = 6001:7000 ;
		TestDataIndex(4001:5000,1) = 8001:9000 ;

		TestDataDimension = 1:5000;
	case 4
		TestDataIndex = zeros(5000,1);
		TestDataIndex(1:1000,1) = 1:1000 ;
		TestDataIndex(1001:2000,1) = 2001:3000 ;
		TestDataIndex(2001:3000,1) = 4001:5000 ;
		TestDataIndex(3001:4000,1) = 6001:7000 ;
		TestDataIndex(4001:5000,1) = 8001:9000 ;

		TestDataDimension = 1:2000;
	case 5
		TestDataIndex = zeros(5000,1);
		TestDataIndex(1:1000,1) = 1:1000 ;
		TestDataIndex(1001:2000,1) = 2001:3000 ;
		TestDataIndex(2001:3000,1) = 4001:5000 ;
		TestDataIndex(3001:4000,1) = 6001:7000 ;
		TestDataIndex(4001:5000,1) = 8001:9000 ;

		TestDataDimension = 1:800;
	case 6
		TestDataIndex = zeros(1000,1);
		TestDataIndex(1:200,1) = 1:200 ;
		TestDataIndex(201:400,1) = 2001:2200 ;
		TestDataIndex(401:600,1) = 4001:4200 ;
		TestDataIndex(601:800,1) = 6001:6200 ;
		TestDataIndex(801:1000,1) = 8001:8200 ;

		TestDataDimension = 1:5000;
	case 7
		TestDataIndex = zeros(1000,1);
		TestDataIndex(1:200,1) = 1:200 ;
		TestDataIndex(201:400,1) = 2001:2200 ;
		TestDataIndex(401:600,1) = 4001:4200 ;
		TestDataIndex(601:800,1) = 6001:6200 ;
		TestDataIndex(801:1000,1) = 8001:8200 ;

		TestDataDimension = 1:2000;
	case 8
		TestDataIndex = zeros(1000,1);
		TestDataIndex(1:200,1) = 1:200 ;
		TestDataIndex(201:400,1) = 2001:2200 ;
		TestDataIndex(401:600,1) = 4001:4200 ;
		TestDataIndex(601:800,1) = 6001:6200 ;
		TestDataIndex(801:1000,1) = 8001:8200 ;

		TestDataDimension = 1:800;

	otherwise;
end

TestData = data(TestDataIndex,TestDataDimension);
TestGroundTruth = GroundTruth(TestDataIndex,:);

DataSize = size(TestData,1)
Length = size(TestData,2)

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
ClusterNumber = 5 ;

% Need to modify ground truth from 1 to clusterNumber
TestGroundTruth = TestGroundTruth + ones(size(TestGroundTruth,1),1) ;

disp('Do clustering using HashCorrelation.');
tic;
Matrix = SimilarityMatrix(Bitstream,0) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('HashCorrelation Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;

%L1
disp('Do clustering using L1.');
tic;
Matrix = SimilarityMatrix(TestData,1) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('L1 Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;


%L2
disp('Do clustering using L2.');
tic;
Matrix = SimilarityMatrix(TestData,2) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('L2 Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;


%DTW

%disp('Do clustering using DTW.');
%tic;
%Matrix = SimilarityMatrix(TestData,3) ;
%clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
%nmi = NMI(clusterResult', TestGroundTruth') ;
%[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
%X = sprintf('DTW Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
%disp(X) ;

%Pearson
disp('Do clustering using Pearson.');
tic;
Matrix = SimilarityMatrix(TestData,4) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('Pearson Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;

%Kendall
%disp('Do clustering using Kendall.');
%tic;
%Matrix = SimilarityMatrix(TestData,5) ;
%clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
%nmi = NMI(clusterResult', TestGroundTruth') ;
%[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
%X = sprintf('Kendall Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
%disp(X) ;


%Spearman
disp('Do clustering using Spearman.');
tic;
Matrix = SimilarityMatrix(TestData,6) ;
clusterResult = HierarchicalClustering( Matrix, ClusterNumber ) ;
nmi = NMI(clusterResult', TestGroundTruth') ;
[Acc,rand_index,match]=AccMeasure(clusterResult',TestGroundTruth') ;
X = sprintf('Spearman Measure: Accuracy: %f, NMI: %f. Running Time: %f',Acc,nmi,toc);
disp(X) ;

