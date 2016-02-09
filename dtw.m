function [Dist]=dtw(s,t)
%Dynamic Time Warping Algorithm
%Dist is unnormalized distance between s and t
%w is Locality Constraint

n = length(s) ;
m = length(t) ;
%w = floor(log(min(m,n))) ;
w = 1;

DTW = ones(n,m)*Inf ;

w = max(w,abs(m-n));

DTW(1,1) = 0.0;

for i= 2:m
  for j= max(2,i-w):min(m,i+w)
    cost = abs(s(i) - t(j));
    DTW(i,j) = cost + min (min(DTW(i-1,j),DTW(i,j-1)),DTW(i-1,j-1));
  end
end

Dist = DTW(n,m) ;
