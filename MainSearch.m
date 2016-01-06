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

% Choose the Query data, it is the Regular data
QueryNodeIndex = 5040 ;
QueryData = data(QueryNodeIndex,:) ;
QueryTruth = GroundTruth(QueryNodeIndex,:) ;

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

QueryBit = zeros(1,Length/WindowSize) ;
for j=1:Length/WindowSize
	startI = (j-1)*WindowSize + 1 ;
	endI = j*WindowSize ;
	QueryBit(j) = ChangeDetect(QueryData(startI:endI)) ;
end


% Show Result of HashCorrelation
TopK = 60 ;
% Distance Type: 0. Minhash, 1. L1, 2. L2, 3. DTW, 4. Pearson, 5. Kendall tau rank Correlation, 6. Spearman Rank Correlation

QueryList = SearchFunction(QueryBit,Bitstream,TopK,0) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('Hash Correlation: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;


%L1

QueryList = SearchFunction(QueryData,TestData,TopK,1) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('L1 Measure: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;

%L2

QueryList = SearchFunction(QueryData,TestData,TopK,2) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('L2 Measure: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;

%DTW

%QueryList = SearchFunction(QueryData,TestData,TopK,3) ;

%[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
%X = sprintf('DTW Distance: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
%disp(X) ;

%Pearson

QueryList = SearchFunction(QueryData,TestData,TopK,4) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('Pearson: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;

%Kendall

QueryList = SearchFunction(QueryData,TestData,TopK,5) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('Kendall: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;

%Spearman

QueryList = SearchFunction(QueryData,TestData,TopK,6) ;

[ precision, recall, F1 ] = Evaluation( GroundTruth(QueryNodeIndex), TestGroundTruth, QueryList ) ;
X = sprintf('Spearman: Precision: %f, Recall: %f, F1: %f',precision,recall,F1);
disp(X) ;

