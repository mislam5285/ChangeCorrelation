% The main method of sythetic data experiment.

%Data Set 
GTFile = 'GroundTruth4' ;
DataFile = 'Subset4' ;
%GroundTruth = dlmread(GTFile);
%data = dlmread(DataFile);

WindowSize = 200;
syms TestDataIndex;
syms TestDataDimension;
DataSetType = 0

while DataSetType > -1

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


TopK = DataSize;
ListSize = 15 ;
Step = int16(TopK/ListSize) - 1;

PrecisionList = zeros(ListSize,7) ;
RecallList = zeros(ListSize,7) ;

i = 1;
k = 0;

for i = 1:ListSize
k = k + Step 
% Distance Type: 0. Minhash, 1. L1, 2. L2, 3. DTW, 4. Pearson, 5. Kendall tau rank Correlation, 6. Spearman Rank Correlation

QueryList = SearchFunction(QueryBit,Bitstream,k,0) ;
[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList) ;
X = sprintf('Hash Correlation: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;

PrecisionList(i,1) = precision;
RecallList(i,1) = recall;

%L1

QueryList = SearchFunction(QueryData,TestData,k,1) ;
[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList) ;
X = sprintf('L1 Measure: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;

PrecisionList(i,2) = precision;
RecallList(i,2) = recall;


%L2

QueryList = SearchFunction(QueryData,TestData,k,2) ;
[ precision1, recall1, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('L2 Measure: Precision: %f, Recall: %f, F1: %f',precision1,recall1,F1);
disp(X) ;

PrecisionList(i,3) = precision;
RecallList(i,3) = recall;

%DTW

QueryList = SearchFunction(QueryData,TestData,k,3) ;
[ precision1, recall1, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('DTW Measure: Precision: %f, Recall: %f, F1: %f',precision1,recall1,F1);
disp(X) ;

PrecisionList(i,4) = precision;
RecallList(i,4) = recall;

%Pearson

QueryList = SearchFunction(QueryData,TestData,k,4) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('Pearson: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;

PrecisionList(i,5) = precision;
RecallList(i,5) = recall;

%Kendall

QueryList = SearchFunction(QueryData,TestData,k,5) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('Kendall: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;

PrecisionList(i,6) = precision;
RecallList(i,6) = recall;

%Spearman

QueryList = SearchFunction(QueryData,TestData,k,6) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('Spearman: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;

PrecisionList(i,7) = precision;
RecallList(i,7) = recall;

end

str = int2str(DataSetType);
filename = strcat(str,'.mat');
save (filename,'PrecisionList','RecallList');
DataSetType = DataSetType - 1;
end