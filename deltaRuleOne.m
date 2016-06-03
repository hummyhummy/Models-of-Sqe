function [Mean_gammaTotal, y] = deltaRuleOne(seqInRATotal,eta)
	[sub, trialNumber] = size(seqInRATotal);
	y = zeros(sub, trialNumber+1); % prediction on x_t = R
	y(:,1) = 0.5*ones(sub,1);
	for i=1:trialNumber
		y(:,i+1) = y(:,i) + eta*(seqInRATotal(:,i)-y(:,i));
	end
	y(:,trialNumber+1) = [];
	Mean_gammaTotal = y;
end