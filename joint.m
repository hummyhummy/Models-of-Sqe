function out=joint(theta, stim, include, dataset)

%outputs predictions of joint-learning model for Experiment 1
%prediction parallels empirical RT analysis:
%compute mean RTs for 5-deep histories, then average to 4-deep histories

%stim is sequence of stimuli as {0,1} (first-degree representation)
stim = 2*stim-1; %convert to {-1,1}

%include indicates which trials to include in predictions (i.e. which trials were included in RT analysis) 

%theta is parameter vector, defined as follows:
beta0 = theta(1); %RT intercept
beta = theta([2 4]); %magnitudes of first- and second-degree effects
eps = theta([3 5]); %first- and second-degree learning rates

profile5 = zeros(32,2); %predicted mean RT by 5-deep history
count = zeros(32,1); %number of occurrences of each sequence

w = [0 0]; %first- and second-degree association weights
hist = [0 0 0 0 0]; %second-degree representation of stimuli (n-4):n; 1 for repetitions, -1 for alternations
for trial = 2:length(stim) %loop through trials
    hist = [hist(2:5) stim(trial-1)*stim(trial)]; %update history with second-degree representation of current stimulus
    pred = w * [1;stim(trial-1)]; %prediction for outcome of this trial
    if include(trial)==1 %track model predictions only on included trials
        count(num(hist)) = count(num(hist))+1; %increment count of current history
        profile5(num(hist),:) = profile5(num(hist),:) - beta.*w.*[1 stim(trial-1)]*stim(trial); %tracking total predicted 1st- and 2nd-degree effects for included trials for this history
    end
    w = w + eps.*[1 stim(trial-1)]*(stim(trial)-pred); %update weights by gradient descent on (stim-pred)^2/2
end

switch dataset
    case 1 %follow analysis for Experiment 1: compute mean RTs for 5-deep histories, then average to 4-deep histories
        out = beta0 + ((profile5(1:2:31,:)./repmat(count(1:2:31),1,2)+profile5(2:2:32,:)./repmat(count(2:2:32),1,2))/2)*[1;1]; %baseine plus 1st- and 2nd-degree effects
    case 'sLRP' %for predicting sLPR: use 2nd-degree effects and collapse to 3-deep histories before averaging
        out = sum(vec2mat(profile5(:,2),4),2)./sum(vec2mat(count,4),2); %2nd-degree effects only
    case 'LRPr' %for predicting LPRr: use 1st-degree effects and collapse to 3-deep histories before averaging
        out = sum(vec2mat(profile5(:,1),4),2)./sum(vec2mat(count,4),2); %1st-degree effects only
    case 'P100' %for predicting P100: use 2nd-degree effects and collapse to 3-deep histories before averaging
        out = -sum(vec2mat(profile5(:,2),4),2)./sum(vec2mat(count,4),2); %2nd-degree effect, in opposite direction
    case 2 %Experiment 2: compute means for 4-deep histories directly
        out = beta0 + ((profile5(1:2:31,:)+profile5(2:2:32,:))./(repmat(count(1:2:31),1,2)+repmat(count(2:2:32),1,2)))*[1;1]; %baseine plus 1st- and 2nd-degree effects
end

function n = num(hist) %converts history to number in 1:32
n = -hist*[1;2;4;8;16]/2+16.5;