function [ dist ] = DistanceMeasure( A, B, type )
% Given two time series A, and B
% Distance Type: 0. Minhash, 1. L1, 2. L2, 3. DTW, 4. Pearson, 5. Kendall tau rank Correlation, 6. Spearman Rank Correlation

dist = 0 ;

switch type
   case 0
	  AB = 0.0;
	  A_B = 0.0;
      for i=1:length(A)
      	if A(i) == 1 & B(i) == 1
			   AB = AB + 1 ;
		   end
		   if A(i) == 1 | B(i) == 1
			   A_B = A_B + 1;
		   end
      end
      % Some strategy here
      if sum(A) == 0 & sum(B) == 0
	      dist = 1 ;
      elseif sum(A) == 0 | sum(B) == 0
         dist = 0;
      else
	      dist = AB/A_B ;
      end
      
      % From similarity to distance
	   dist = - dist;
   case 1
      for i=1:length(A)
      	dist = dist + abs(A(i)-B(i)) ;
      end
   case 2
      for i=1:length(A)
      	dist = dist + (A(i)-B(i))*(A(i)-B(i)) ;
      end
      dist = sqrt(dist) ;
   case 3
      dist=dtw(A,B);
   case 4
      dist = -corr(A',B','Type','Pearson');	
   case 5
      dist = -corr(A',B','Type','Kendall');
   case 6
      dist = -corr(A',B','Type','Spearman');	
   otherwise
end

end
 
