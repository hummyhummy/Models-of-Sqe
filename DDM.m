function y = DDM(z,m,S,previousS,currentS,p)
	%y = f(z,A,c^2,x0) = f(z,m,s^2,I0), in whihc z,x0 is equal to observed
	%S = c^2
	% z is threshold, m is the mean of distribution of srift rate, 
	%S is c square, H is previous stimulis in 1/2 code, y is the probability of repetition in this trial
	I0 = p2I(previousS,p);
	currentS_hat = 2*currentS - 1;%p2CurrentS(previousS,p); % predictied current stimulis in 1/2 code in 1/-1
	[sub, trialNumber] = size(p);
	A = m*currentS_hat;
	z1 = z*ones(sub,trialNumber)./A;
    %z1 = z*ones(sub,trialNumber)/m;
	a1 = m^2/S;
	x0 = I0./A;
	y = z1.*tanh(a1*z1) + (2*z1 - 2*z1.*exp(-2*a1*x0))./(exp(2*a1*z1) - exp(-2*a1*z1)) - x0;
end