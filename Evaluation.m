function [ precision, recall, F1 ] = Evaluation( QueryGroundTruth, DataGroundTruth, QueryResult )
%EVALUATION Summary of this function goes here
%   Detailed explanation goes here

%Precision
QuerySize = length(QueryResult) ;
QueryPrecision = 0 ;
Result = DataGroundTruth(QueryResult) ;

for i=1:QuerySize
   if QueryGroundTruth == Result(i)
      QueryPrecision = QueryPrecision + 1 ;
   end
end

precision = QueryPrecision/ QuerySize ;

% Recall
RecallSize = 0 ;

QueryRecall = 0 ;
Result = DataGroundTruth(QueryResult) ;

for i=1:length(DataGroundTruth)
   if DataGroundTruth(i) == QueryGroundTruth
      RecallSize = RecallSize + 1 ;
   end
end

for i=1:QuerySize
   if QueryGroundTruth == Result(i)
      QueryRecall = QueryRecall + 1 ;
   end
end
recall = QueryRecall/RecallSize ;

%F1 Measure

F1 = 2*(precision*recall)/(precision+recall) ;
end

