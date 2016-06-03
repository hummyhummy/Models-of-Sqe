function [previousSqeInAB,currentSqeInAB,totalSqeInAB] = RA2AB(seqInRA,p)
	%Covert R/A coder to S1/S2 or A/B coder
	% In R/A coder, 1 is for R and 0 is for A. In S1/S2 coder, 1 is for S1 and 0 is for S2
	%previousSqeInAB is stimulis of 1-back trial in A/B code, currentSqeInAB is stimulis of current trial in A/B code
	%totalSqeInAB is longer than seqInRA with 1 trial, it is the total sequence of stimulis in A/B code
	[sub, trialNumber] = size(seqInRA);
	% R/A in 1/0 -> 1/-1
	% assum the first stimulis is always s1 = 1 (in AB code)
	% geberate A/B code, then coverted in to 1/0 as A/B
	tmp = zeros(sub, trialNumber+1);
	%first with probability p to be 1
    tmp(:,1) = binornd(1,p,sub,1);
    tmp(:,1) = 2*tmp(:,1) - ones(sub,1);
	tmp(:,2:trialNumber+1) = 2*seqInRA - ones(sub,trialNumber);
	totalSqeInAB = cumprod(tmp,2) > 0;
	previousSqeInAB = totalSqeInAB(:,1:trialNumber);
	currentSqeInAB = totalSqeInAB(:,2:(trialNumber + 1));
end