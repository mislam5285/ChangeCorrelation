function [ flag ] = ChangeDetect( ts )
%Detect Change of time series s, 
%   Detailed explanation goes here

% alpha = 0.05, the threshold of the two sample test is 0.975
alpha = 0.975 ;

flag = 0;

%xi = 100 ;

length = size(ts,2) ;

%mean Change detect
meanFront = mean(ts(1:length/2)) ;
meanRear = mean(ts(length/2+1:length));
varFront = var(ts(1:length/2)) ;
varRear = var(ts(length/2+1:length)) ;

SampleSize = length/2 ;
T = (meanFront - meanRear)/ sqrt(varFront/SampleSize + varRear/SampleSize) ;

if abs(T) > alpha
    %disp('Mean Change');
	flag = 1 ;
end

%{
% Variance Change detect
varFront = var(ts(1:length/2)) ;
varRear = var(ts(length/2:length)) ;
varWhole = var(ts) ;
if (abs(varRear - varFront) > theta*varWhole)
%	disp('Var Change');
	flag = 1 ;
end


% Frequency Change detect
Fourier = abs(fft(ts)) ;
% Avoid first one.
% Symetric property

y = randsample(length/2,length/20);
generalVar = var(Fourier(y)) ;
generalMean = mean(Fourier(y)) ;

count = 0 ;
for i=2:length/2
	if (Fourier(i) - generalMean > xi*generalMean)
		count = count + 1;
	end
end
if count > 1
    disp('Frequency Change');
	flag = 1 ;
end

%}
end

