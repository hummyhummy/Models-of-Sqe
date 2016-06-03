function [count_cr,meanValue_cr,meanErr_cr] = getStasInNSeq(seqInRATotal,RT)
	seqCondition = [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0;1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0;1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0;1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0];
	[sub,trialNumber] = size(seqInRATotal);
	[n,len] = size(seqCondition);
    keyToSqeOrder = [16,8,12,4,14,6,10,2,15,7,11,3,13,5,9,1];
	if trialNumber > n % check length of sequence
		%initial variables
		count = zeros(sub,len);
		meanValue = zeros(sub,len);
		meanErr = zeros(sub,len);
		keys = {};
		for i = 1:len
			%keys{i} = num2str(seqCondition(:,len-i+1));
            keys{i} = num2str(seqCondition(:,i));
		end
		for i = 1:sub
			%initial map
			values = num2cell(zeros(1,len));
			count_each = containers.Map(keys,values);
			meanValue_each = containers.Map(keys,values);
			meanErr_each = containers.Map(keys,values);
			%get Stas in map
			for j = 1:trialNumber-n+1
				seq = num2str(seqInRATotal(i,j:j+n-1)');
				if RT(i,j+n-1) > 0
					count_each(seq) = count_each(seq) + 1;
					meanValue_each(seq) = meanValue_each(seq) + RT(i,j+n-1);
					meanErr_each(seq) = meanErr_each(seq) + RT(i,j+n-1)^2;
				end
            end
            count(i,:) = cell2mat(count_each.values);
			%countDenominator: change any zeros to 1
			countDenominator = count(i,:);
			countDenominator(find(~countDenominator)) = 1;
			meanValue(i,:) = cell2mat(meanValue_each.values)./countDenominator;
			%meanErr(i,:) = sqrt(cell2mat(meanErr_each.values)./countUse-1)-countUse./(countUse-1).*(meanValue(i,:).^2)./sqrt(countUse);
			meanErr(i,:) = sqrt(cell2mat(meanErr_each.values)./countDenominator - meanValue(i,:).^2)./sqrt(countDenominator);            
        end
        %correct order
        for j = 1:len
            count_cr(:,keyToSqeOrder(j)) = count(:,j);
            meanValue_cr(:,keyToSqeOrder(j)) = meanValue(:,j);
            meanErr_cr(:,keyToSqeOrder(j)) = meanErr(:,j);
        end
	else
		disp('not enough length of stimulis sequence to analysis');
		return;
	end
end
