function [ sig,st, prm ] = ArtifactRejection( sig,st,prm)

% check variance

threshold = 900;
st.Artifact = zeros( size(sig) );
prm.BadChannels = zeros ( 1, size(sig,2));

winSize = prm.SamplingRate.NumericValue / 2;   % window = 0.5 seconds
win = zeros ( winSize, size(sig , 2));

% vector containing starting indexes of windows 
begInd = 1 : winSize : size(sig,1);  
win = zeros ( winSize, size (sig,2));
a = 0;
for k = 1 : size(begInd, 2)-1
    win(:,:)  = sig( begInd(k) : begInd(k) + winSize - 1 , : );
    variance = var(win,1) ;
    ind = find ( (variance > threshold) | (variance < 10) );
    for l = 1 : length(ind)
        st.Artifact( begInd(k) : begInd(k) + winSize - 1, ind(l) ) = 1 ;
    end    
    a = a +1;
end


for i = 1 :  size (sig,2)
    l = length(find ( st.Artifact(:,i) == 1));
    if ( l > 0.50*size(sig,1))
        prm.BadChannels(1,i) = 1;
    end
end

    



