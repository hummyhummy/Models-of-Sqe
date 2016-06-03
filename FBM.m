function [Mean_gammaTotal, y] = FBM(seqInRATotal,a,b)
%y is the MAP of posterior distribution after observed X, and also p(x_{t+1}|X)
	[sub,trialNumber]= size(seqInRATotal);
	y = zeros(sub,trialNumber);
	NumOfTrialTotal = repmat(1:1:trialNumber,sub,1);
	y = (cumsum(seqInRATotal')' + a)./(a+b+NumOfTrialTotal);
	Mean_gammaTotal = y;
end