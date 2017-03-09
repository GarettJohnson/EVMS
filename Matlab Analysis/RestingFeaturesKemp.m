function features = RestingFeaturesKemp( sig, st, prm )

%% INITIALIZATIONS

% groupings are based on eloc32.txt
% frontalLeft =  [1 2 17 19 21 22]; % maybe ignore 2, which is Fz???
% frontalRight = [2 3 18 20 23 24]; % maybe ignore 2, which is Fz???
% CentCPar =     [5 6 7 9 10 25];
% ParOcc =       [12 13 14 15 16 26 27 28 29 30 31 32];
groupings = [{[1 17 19 21 22]};
             {[3 18 20 23 24]};
             {[12 13 14 15 16 26 27 28 29 30 31 32]};];

% 4 bands used ( delta, theta, alpha, beta)
bands = [1.5 3.5; 4 7.5; 8 13; 14.5 30];

% sampling rate of our EEG
fs = prm.SamplingRate.NumericValue;


%% ARTIFACT REMOVAL

% filter between 1 and 30Hz with 8th order butterworth
h  = design( fdesign.bandpass('N,F3dB1,F3dB2', 8, 1, 30, fs), 'butter' );
sig= filter(h,sig);


% ignore first and last 3 seconds of EEG clip (to drowsy at end, and the
% signal is sometimes not stabilized at the beginning from amplifiers)
ignore = 3;
st.Artifact = st.Artifact( round(ignore*fs+1): round(end-ignore*fs),: );
sig = sig( round(ignore*fs+1): round(end-ignore*fs),: );

% remove bad channels
ind = find (prm.BadChannels == 0);
smArt = st.Artifact(:,ind);
smSig = sig(:,ind);


% sum of st.Artifact across all channels.
% checks to see if there is bad signal at a specific time 
% point in the signal
artSum = zeros(size(sig, 1),1);
artSum = sum (smArt , 2);

% if artSum is 0, that means the signal is clean

% all points where artSum changes
ind = find ( diff (artSum) ~= 0) + 1 ; 

%all change points where value is zero 
zp = find ( artSum (ind) == 0);

% starting point of clean chunks of signal
chStart = ind (zp);

zp = zp + 1;
    
% ending point of clean chunks of signal
if (zp (end) > size(ind) )
    zp(end) =  size(ind,1) ;
end
chEnd = ind (zp) - 1 ;
if( chStart(end) == ind(end))
    chEnd(end) = size(smSig , 1);
end

% only keep chunks that are greater than 1 second
ind = find( (chEnd - chStart) < fs );
chStart (ind) = [];
chEnd (ind) = [];

badCh = find( prm.BadChannels == 1) ; 
for i = 1 : size(groupings, 1)
    ind = ismember ( groupings{i} , badCh ) ;
    groupings{i}(ind == 1) = [];
end


%% FEATURES

% creating cube (dimensions: num of chunks  x  channels in grouping  x  bands ) 
Group1 = zeros( length(chStart), length(groupings{1}), size(bands,1));
Group2 = zeros( length(chStart), length(groupings{2}), size(bands,1));
bpOcc = zeros ( length(chStart), length(groupings{3}), size(bands,1));
noOcc = 0;

for  k = 1 : length(chStart)
    
    for i = 1 : size(bands,1)
        Group1(k,:,i) = log( bandpower( sig(chStart(k) : chEnd(k),groupings{1}), fs, bands(i,:)) );
        Group2(k,:,i) = log( bandpower( sig(chStart(k) : chEnd(k),groupings{2}), fs, bands(i,:)) );
        if ~isempty(groupings{3})
            bpOcc(k,:,i)  = log( bandpower( sig(chStart(k) : chEnd(k),groupings{3}), fs, bands(i,:)) );
        else
            noOcc=1;
        end
    end
    
end

% find the mean across all chunks
Group1 = squeeze (mean( Group1, 1));
Group2 = squeeze (mean( Group2, 1));
if( ~noOcc )
    bpOcc  = reshape ((mean( bpOcc, 1)),[ length(groupings{3})  size(bands,1)]);
end

groupingAvrg = zeros( 2, size(bands, 1) );

% find the mean across all channels
groupingAvrg(1,:) =  mean(Group1,1) ;
groupingAvrg(2,:) =  mean(Group2,1) ;
if( ~noOcc)
    bpOcc  = mean ( bpOcc, 1);
else
    bpOcc = NaN(1,4);
end


FAI = zeros(size(bands, 1),1);

for cnt = 1 : size(bands, 1)
    FAI(cnt,:) = groupingAvrg(2,cnt) - groupingAvrg(1,cnt) ;
end

features = [ FAI'  bpOcc ];