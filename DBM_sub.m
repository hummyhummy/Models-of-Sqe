function [post_gamma_2,postMean_gamma,y] = DBM_sub(x,post_gamma_1,alpha,a,b,gamma0)
	%post_gamma_1 is the posterior distribution on gamma of last trial
	%post_gamma_2 is the posyerior distribution on gamma of current trial
	%the length of post_gamma_1&2 is assigned by global variable gammaLength
	%postMean_gamma is posterior mean value of gamma, y is p(x_{t+1}|X)
	%a,b is the parameter for prior_gamma_0
	% y is prediction
	[sub,len] = size(post_gamma_1);
	prior_gamma_2 = alpha*post_gamma_1 + (1-alpha)*betapdf(gamma0,a,b);
	post_gamma_2 = (repmat(x,1,len).*gamma0 + (1-repmat(x,1,len)).*(1-gamma0)).*prior_gamma_2; % (6)
	%post_gamma_2 = (x*gamma*x+(1-x)*(1-gamma)).*prior_gamma_2; % see fomula (6)
	%post_gamma_2 = len*post_gamma_2./repmat(sum(post_gamma_2,2),1,len);% normalization factor
	post_gamma_2 = len*post_gamma_2./repmat(sum(post_gamma_2,2),1,len);
	postMean_gamma = sum(gamma0.*post_gamma_2,2)/len; % sub*1
	%y = (1-alpha)*a/(a+b) + alpha*sum(gamma0.*prior_gamma_2,2)/len; % sub*1
	y = (1-alpha)*a/(a+b) + alpha*postMean_gamma; % sub*1
end