function [Mean_gammaTotal, y] = deltaRuleTwo(seqInRATotal,eta_re,eta_pi)
    %eta_re is for recency effect
    %eta_pi is for primacy effect
	[sub, trialNumber] = size(seqInRATotal);
	y = zeros(sub, trialNumber+1); % prediction on x_t = R
% 	y(:,1) = 0.5*ones(sub,1);
    w_pi = eta_pi;
    w_re = eta_re;
	for i=1:trialNumber
% 		y(:,i+1) = y(:,i) + eta_re*(seqInRATotal(:,i)-y(:,i));
        y(:,i) = seqInRATotal(:,1:i)*w_pi/(sum(w_pi)+sum(w_re))+seqInRATotal(:,1:i)*w_re/(sum(w_pi)+sum(w_re));
        w_pi = [w_pi;power(eta_pi,i+1)];        
        w_re = [power(eta_re,i+1);w_re];
	end
	y(:,trialNumber+1) = [];
	Mean_gammaTotal = y;
end