function [postMean_gammaTotal, y] = DBM(seqInRATotal, alpha, a, b, increment)
	[sub, trialNumber] = size(seqInRATotal);
	gamma0 = repmat(0.01:increment:0.99,sub,1);
	post_gamma_1 = betapdf(gamma0,a,b);
	% y(:,1) = (a/(a+b))*ones(sub,1);
	for i = 1:trialNumber
		[post_gamma_2,postMean_gammaTotal(:,i),y(:,i)] = DBM_sub(seqInRATotal(:,i),post_gamma_1,alpha,a,b,gamma0);
		post_gamma_1 = post_gamma_2;
	end
end
