function y = p2CurrentS(previousS,p)
	% PreviousS is previous stimulis in 1/2 code
	% p is the probability of repetition
	% y is the prediction of current stimulis in 1/2 code in 1/-1
	p_cut = p > 0.5; % cut p in to 1 & 0 for repetition and alteration with threshold = 0.5
	y = previousS.*p_cut + (1-previousS).*(1-p_cut);
	y = 2*y - 1; % covert 1/2 stimulis code as 1/0 to 1/-1
end