function [ queryResult ] = SearchFunction(query, querySet, querySize, queryType)
% query: the query keyword
% querySet: The set for query
% querySize: The returned length of query
% queryType: 0. Minhash, 1. L1, 2. L2, 3. DTW, 4. Pearson
% queryResult: the Query Result

queryResult = zeros(querySize,1) ;
queryDistance = ones(querySize,1)*flintmax ;

for i=1:size(querySet,1)
   ts = querySet(i,:) ;
   distance = DistanceMeasure(query,ts,queryType) ;
   for j=1:querySize
      if distance < queryDistance(j)
         if j < querySize
            k = querySize ;
	    while k > j
		queryDistance(k) = queryDistance(k-1) ;
		queryResult(k) = queryResult(k-1);
                k = k - 1;
            end
          end
	  queryDistance(j) = distance ;
	  queryResult(j) = i ;
	  break ;
       end            
    end
end


end

