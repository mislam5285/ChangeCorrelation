% The main method of sythetic data experiment.

%Data Set 
GTFile = 'GroundTruth5' ;
DataFile = 'Subset5' ;
%GroundTruth = dlmread(GTFile);
%data = dlmread(DataFile);


syms TestDataIndex;
syms TestDataDimension;
Size = 100
index = 1;
TimeList = zeros(10,7);
SizeList = zeros(10,1);

while Size < 1001

TestDataIndex = 1:1000;
TestDataDimension = 1:600;
SizeList(index,1) = Size ;

TestData = data(TestDataIndex,TestDataDimension);
TestGroundTruth = GroundTruth(TestDataIndex,:);

DataSize = size(TestData,1)
Length = size(TestData,2)
WindowSize = Length/2 ;

Bitstream = zeros(size(TestData,1),Length/WindowSize);

% Choose the Query data, it is the Regular data
%QueryNodeIndexList = [8015,8016,8018,8020,8025,8115,8215,5015,6015,7015] ;


QueryNodeIndex = 2015 ;
QueryData = data(QueryNodeIndex,TestDataDimension) ;
QueryTruth = GroundTruth(QueryNodeIndex,:) ;

% Mapping to bit stream
for i=1:size(TestData,1)
	% Do normalization to data
	ts = Normalization(TestData(i,:)) ;
	for j=1:Length/WindowSize
		startI = (j-1)*WindowSize + 1 ;
		endI = j*WindowSize ;
		Bitstream(i,j) = ChangeDetect(ts(startI:endI)) ;
	end
end

QueryBit = zeros(1,Length/WindowSize) ;

for j=1:Length/WindowSize
	startI = (j-1)*WindowSize + 1 ;
	endI = j*WindowSize ;
	QueryBit(j) = ChangeDetect(QueryData(startI:endI)) ;
end


TopK = Size;
k=TopK;
% Distance Type: 0. Minhash, 1. L1, 2. L2, 3. DTW, 4. Pearson, 5. Kendall tau rank Correlation, 6. Spearman Rank Correlation

tic;
QueryList = SearchFunction(QueryBit,Bitstream,k,0) ;
[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList) ;
X = sprintf('Hash Correlation: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;
TimeList(index,1) = toc;
%L1

tic;
QueryList = SearchFunction(QueryData,TestData,k,1) ;
[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList) ;
X = sprintf('L1 Measure: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;
TimeList(index,2) = toc;

%L2

tic;
QueryList = SearchFunction(QueryData,TestData,k,2) ;
[ precision1, recall1, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('L2 Measure: Precision: %f, Recall: %f, F1: %f',precision1,recall1,F1);
disp(X) ;
TimeList(index,3) = toc;
%DTW

tic;
QueryList = SearchFunction(QueryData,TestData,k,3) ;
[ precision1, recall1, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('DTW Measure: Precision: %f, Recall: %f, F1: %f',precision1,recall1,F1);
disp(X) ;
TimeList(index,4) = toc;
%Pearson

tic;
QueryList = SearchFunction(QueryData,TestData,k,4) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('Pearson: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;
TimeList(index,5) = toc;

%Kendall

tic;
QueryList = SearchFunction(QueryData,TestData,k,5) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('Kendall: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;
TimeList(index,6) = toc;
%Spearman

tic;
QueryList = SearchFunction(QueryData,TestData,k,6) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('Spearman: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;
TimeList(index,7) = toc;


Size = Size + 100;
index=index+1;
end

save ('VarDataTopK','TimeList','SizeList');
disp('Saving Done!');