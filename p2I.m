function I = p2I(H,y)
	%H = 1 for H_1 is true for previous trial, 0 for other wise
%	len = length(y);
%	for i=1:len
%		I(i) = power(-1,H(i)+1)*log(y(i))-log(1-y(i));
%	end
	I = (2*H-1).*(log(y) - log(1-y));
end