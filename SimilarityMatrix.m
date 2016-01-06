function [ SimilarityMatrix ] = SimilarityMatrix( Data, DistanceType)
%   Convert From the Time Series to The Similarity Matrix

count = size(Data,1) ;
SimilarityMatrix = zeros(count,count) ;

for i=1:count 
	for j=1:count
		SimilarityMatrix(i,j) = -DistanceMeasure( Data(i,:), Data(j,:), DistanceType) ;
	end
end

end

