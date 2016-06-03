function [previousSeqInAB,currentSeqInAB,seqInRA] = AB2RA(seqInABTotal)
[~, trialNumber] = size(seqInABTotal);
previousSeqInAB = seqInABTotal(:,1:trialNumber-1);
currentSeqInAB = seqInABTotal(:,2:trialNumber);
seqInRA = previousSeqInAB == currentSeqInAB;
end