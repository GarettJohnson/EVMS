function [ sig,st, prm ] = ArtifactRejection( sig,st,prm )


Hd= LPF(prm.SamplingRate.NumericValue);
sigF=  zeros(size(sig));
for i = 1:size(sig,2)
    sigF(:,i)=filtfilt(Hd.Numerator,1,abs(sig(:,i)));
end


threshold = 80;
st.Artifact = zeros( size(sig) );
prm.BadChannels = zeros ( 1, size(sig,2));

winSize = round(prm.SamplingRate.NumericValue / 3);   % window = 0.33 seconds
win = zeros ( winSize, size(sig , 2));

% vector containing starting indexes of windows 
begInd = 1 : winSize : size(sig,1);  
win = zeros ( winSize, size (sig,2));
 
for k = 1 : size(begInd, 2)-1
    
    % update window
    win(:,:)  = sigF( begInd(k) : begInd(k) + winSize - 1 , : );
    
    % for all channels
    for l = 1 : size (win,2)
        check  = find (abs(win(:,l)) > threshold,1 );
        
        if (~isempty(check))
            st.Artifact( begInd(k) : begInd(k) + winSize - 1, l) = 1 ;
        end
    end
end

for i = 1 :  size (sig,2)
    l = length(find ( st.Artifact(:,i) == 1));
    if ( l > 0.5 *size(sig,1))
        prm.BadChannels(1,i) = 1;
    end
end

%  plot(abs(sig(:,6)));
%  hold on;
%  plot(30*st.Artifact(:,6));
%  plot(sigF(:,6));
