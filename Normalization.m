function [ X_norm ] = Normalization( X )
%NORMALIZATION Summary of this function goes here
%   Detailed explanation goes here

X_mean = mean(X);
X_std = std(X);
X_norm = (X - (ones(size(X))*X_mean)) ./X_std ;

end

