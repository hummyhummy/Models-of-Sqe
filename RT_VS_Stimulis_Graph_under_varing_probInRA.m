function RT_VS_Stimulis_Graph_under_varing_probInRA(probName)
if ~isempty(probName)        
    trialNum = 240;
    subNum = 30;
    prob = [0.333,0.5,0.666];
    colorCode = {'*-b','*-r','*-k'};
    %paras in DDM
    z = log(0.95/0.05);
    m = 2*1.5*1.5;
    S = 4*1.5*1.5;
    % paras control figure
    
    %y-axis scale
    y_low = 0;%0.53;
    y_up = 1;%0.63;
    y_step = 0.05;
    % x1_stick adjust
    x1_adjust = -0.05;
    y1_adjust = -0.05;
    % x2_stick adjust
    x2_adjust = -0.2;
    y2_adjust = 0.05;
    
    figure;
    for i = 1:length(prob)
        seqInRATotal = [];
        seqInRATotal = binornd(1,prob(i),subNum,trialNum);
        p = [];
        if strcmp(probName,'FBM')
            [~, p] = FBM(seqInRATotal,1,1);
        end
        [previousS,currentS,~] = RA2AB(seqInRATotal,1);
        RT = [];
        RT = DDM(z,m,S,previousS,currentS,p);
        [~,meamTime,~] = getStasInNSeq(seqInRATotal,RT);
        errorbar(1:1:16,mean(meamTime),std(meamTime)/sqrt(subNum),colorCode{i});hold on;
    end
    
    %%  draw information
    x= 1:1:16;
    seqCondition = [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0;1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0;1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0;1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0];
    %let plot window max
    set(gcf,'outerposition',get(0,'screensize'));
    % draw stick
    ylim([y_low,y_up]);
    set(gca,'position',[0.2,0.2,0.6,0.6]);
    set(gca,'ytick',y_low:y_step:y_up,'fontsize',20);
    ylabel('mean RT','fontsize',20);
    %draw x1_stick
    [m,n] = size(seqCondition);
    for i = 1:m
        for j = 1:n
            if seqCondition(i,j) == 1
                text(j+x1_adjust,y_low+i*y1_adjust,'R','fontsize',20);
            else
                text(j+x1_adjust,y_low+i*y1_adjust,'A','fontsize',20);
            end
        end
    end
    
    [~,~,totalSqeInAB] = RA2AB(seqCondition',1);
    totalSqeInAB = totalSqeInAB';
    [m,n] = size(totalSqeInAB);
    for i = 1:m
        for j = 1:n
            if totalSqeInAB(i,j) == 1
                text(j+x2_adjust,y_up+(m-i+1)*y2_adjust,'1','fontsize',20);
            else
                text(j+x2_adjust,y_up+(m-i+1)*y2_adjust,'2','fontsize',20);
            end
        end
    end
    set(gca,'xtick',x,'xticklabel',[]);
    legend('0.333','0.5','0.666');
    title(probName,'fontSize',20);
else
    disp('empty probability function');
end
end