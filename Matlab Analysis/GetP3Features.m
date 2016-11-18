<<<<<<< HEAD
function features = GetP3Features( sig,st,prm,toPlot )

mWindow = [ 0 800 ]; % time to gather waveform (in milliseconds)
mChans = [ 6 12 29 ]; % channels of interest for p300 attributes: Cz, Pz, POz
% mChans = 12; % only look at Pz, it has biggest p300 response
p300win = [276 600]; % millisecond range to find p3 peak
n200win = [200 350]; % millisecond range to find n2 minumum
fs = prm.SamplingRate.NumericValue; %  sampling rate of our EEG
decFact = round(fs/20); % for filtering and downsampling reasons (to 20hz)
thresh2Ignore = 50; % if amplitude goes above or below this (uV), toss out that trial
reRefCh = 1:32; % re-reference to mean of these channels (1:32 for CAR)

% filter the signal, zero-phase
sig2 = filter( ones(decFact,1)/decFact,1,sig );
sig2 = flipud(sig2);
sig2 = filter( ones(decFact,1)/decFact,1,sig2 );
sig2 = flipud(sig2);

% % let's re-reference to something other than mastoid
% sig2 = sig2 - repmat( nanmean(sig2(:,reRefCh),2),1,size(sig2,2) ); % nope, use all channels to re-ref
sig2 = sig2(:,mChans);
mWin = round(mWindow*fs/1000);

st.Artifact = st.Artifact(:,mChans);
sig2(st.Artifact==1)=NaN;
        
%find where the oddball stimuli start, the oddball is when stimcode is 2
ind = find(st.StimulusCode == 2 & [0; diff(double(st.StimulusCode)==2)]);
dataCube = zeros( mWin(2)-mWin(1),size(sig2,2),length(ind) );
for i = 1:length(ind)
    % extract (and detrend?) each observation of the P300
    dataCube(:,:,i)=detrend( sig2( (ind(i)+mWin(1)):(ind(i)+mWin(2)-1),: ) );
end
% find where the common stimuli start, the common is when stimcode is 1
ind = find(st.StimulusCode == 1 & [0; diff(double(st.StimulusCode)==1)]);
dataCubeC = zeros( mWin(2)-mWin(1),size(sig2,2),length(ind) );
for i = 1:length(ind)
    % extract (amd detrend?) each observation fo the common stimulus
    dataCubeC(:,:,i)=detrend( sig2( (ind(i)+mWin(1)):(ind(i)+mWin(2)-1),: ) ); 
end


% simplistic artifact removal (maybe the subject sneezed / moved greatly?)
% eliminate trials with amplitudes that exceed some threshold in uV
for i = 1:size(dataCube,2)
    [~,ind] = find( squeeze(abs(dataCube(:,i,:)))>=thresh2Ignore );
    dataCube(:,i,unique(ind))=NaN(size(dataCube,1),length(unique(ind)));
end
% eliminate trials with amplitudes that exceed threshold in common
for i = 1:size(dataCubeC,2)
    [~,ind] = find( squeeze(abs(dataCubeC(:,i,:)))>=thresh2Ignore );
    dataCubeC(:,i,unique(ind))=NaN(size(dataCubeC,1),length(unique(ind)));
end
% average waveforms across all the observations
dataCube = squeeze(nanmean(dataCube,3)); % p300 cube is now matrix
dataCubeC = squeeze(nanmean(dataCubeC,3)); % common cube is now matrix
mData=  dataCube - dataCubeC; % subtract these to get waveform

% lets look at P300 latency & amplitude, N200 latency & amplitude
time=(0:1/fs:(size(mData,1)-1)/fs)*1000;
if(toPlot==1)
    plot(time,mData(:,2)); % plot Pz waveform (fix this number to match!)
end

% % find the p300 latency
p3samp=round(p300win*fs/1000);
n2samp=round(n200win*fs/1000);


% this shit is retarderd? rather than just using max and stuff, use
% some more intelligent method? (mid-point between zero crossings? who 
% knows), find some literature to support how we choose the latencies and
% amplitudes

p3latency = zeros(1,size(mData,2));
for ii = 1:size(mData,2)
    p3latency(ii) = round(time( mData(:,ii) == max( mData(p3samp(1):p3samp(2),ii)) ));
end
p3amplitude = zeros(1,size(mData,2));
for ii = 1:size(mData,2)
    p3amplitude(ii) = mData(( mData(:,ii) == max( mData(p3samp(1):p3samp(2),ii)) ),ii);
end
n2latency = zeros(1,size(mData,2));
for ii = 1:size(mData,2)
    n2latency(ii) = round(time( mData(:,ii) == min( mData(n2samp(1):n2samp(2),ii)) ));
end
n2amplitude = zeros(1,size(mData,2));
for ii = 1:size(mData,2)
    n2amplitude(ii) = mData(( mData(:,ii) == min( mData(n2samp(1):n2samp(2),ii)) ),ii);
end

% arrange and vectorize these features
features = [p3latency; p3amplitude; n2latency; n2amplitude];
features = features(:);
features = features';


% maybe add some frontal hemispheric differneces also??? EVMS wants to show
% increased 'symmetry' in activity from before to after treatment, so let's
% look at that somehow? specifically in teh frontal areas

% so let's treat these sessions similar to the resting/baseline EEG ones
ignore = 3; % ignore the first and last 3 seconds of the trials, but remember there are two runs concatenated!!
mInd = 1:size(sig,1);
mInd = mInd( (ignore*fs+1) : (end-ignore*fs) );
mInd( (round(length(mInd)/2)-3*fs):(round(length(mInd)/2)+3*fs) ) = [];
chLeft = [1 17 19 21 22];
chRight = [3 18 20 23 24];
% just average the left and right frontal electrodes?
sigL = nanmean( sig( mInd,chLeft ),2 );
sigR = nanmean( sig( mInd,chRight ),2 );

% calculate the correlation between the two
r = corr( sigL, sigR );
features = [features r];

% screw it, let's also add MI stuff as well?
cd('.\MutualInformationICA\');
mi = MIhigherdim( [sigL';sigR'] );
cd('..\');
% normalize MI by dividing by sqrt of product of entropies
miNorm = mi/ sqrt( entropy(sigL',[],[],2)*entropy(sigR',[],[],2) );
features = [features mi miNorm];





% KEEP THIS UP TO DATE WHENEVER YOU CHANGE THIS FILE SO YOU CAN TELL WHAT
% THE FEATURES ACTUALLY REFER TO WHEN LOOKING TO SEE WHATS IMPORTANT /
% CORRELATED WITH TREATMENT OUTCOMES!!!!!

% as it stands 15 features are:
%     [Cz, Pz, POz, R, MI, MI_normalized]
% where each of the first 3 have 4 measures (p3latency; p3amplitude; n2latency; n2amplitude)















=======
function features = GetP3Features( sig,st,prm,toPlot )

mWindow = [ 0 800 ]; % time to gather waveform (in milliseconds)
mChans = [ 6 12 29 ]; % channels of interest for p300 attributes: Cz, Pz, POz
% mChans = 12; % only look at Pz, it has biggest p300 response
p300win = [276 600]; % millisecond range to find p3 peak
n200win = [200 350]; % millisecond range to find n2 minumum
fs = prm.SamplingRate.NumericValue; %  sampling rate of our EEG
decFact = round(fs/20); % for filtering and downsampling reasons (to 20hz)
thresh2Ignore = 50; % if amplitude goes above or below this (uV), toss out that trial
reRefCh = 1:32; % re-reference to mean of these channels (1:32 for CAR)

% filter the signal, zero-phase
sig2 = filter( ones(decFact,1)/decFact,1,sig );
sig2 = flipud(sig2);
sig2 = filter( ones(decFact,1)/decFact,1,sig2 );
sig2 = flipud(sig2);

% % let's re-reference to something other than mastoid
sig2 = sig2 - repmat( nanmean(sig2(:,reRefCh),2),1,size(sig2,2) ); % nope, use all channels to re-ref
sig2 = sig2(:,mChans);
mWin = round(mWindow*fs/1000);

st.Artifact = st.Artifact(:,mChans);
% for i = 1:size(st.Artifact, 2)
%     for j = 1:size(st.Artifact, 1)
%         if st.Artifact(j,i) == 1
%             sig2(j,i) = NaN;
%         end
%     end
% end
sig2(st.Artifact==1)=NaN;
        
%find where the oddball stimuli start, the oddball is when stimcode is 2
ind = find(st.StimulusCode == 2 & [0; diff(double(st.StimulusCode)==2)]);
dataCube = zeros( mWin(2)-mWin(1),size(sig2,2),length(ind) );
for i = 1:length(ind)
    % extract (and detrend?) each observation of the P300
    dataCube(:,:,i)=detrend( sig2( (ind(i)+mWin(1)):(ind(i)+mWin(2)-1),: ) );
end
% find where the common stimuli start, the common is when stimcode is 1
ind = find(st.StimulusCode == 1 & [0; diff(double(st.StimulusCode)==1)]);
dataCubeC = zeros( mWin(2)-mWin(1),size(sig2,2),length(ind) );
for i = 1:length(ind)
    % extract (amd detrend?) each observation fo the common stimulus
    dataCubeC(:,:,i)=detrend( sig2( (ind(i)+mWin(1)):(ind(i)+mWin(2)-1),: ) ); 
end


% simplistic artifact removal (maybe the subject sneezed / moved greatly?)
% eliminate trials with amplitudes that exceed some threshold in uV
for i = 1:size(dataCube,2)
    [~,ind] = find( squeeze(abs(dataCube(:,i,:)))>=thresh2Ignore );
    dataCube(:,i,unique(ind))=NaN(size(dataCube,1),length(unique(ind)));
end
% eliminate trials with amplitudes that exceed threshold in common
for i = 1:size(dataCubeC,2)
    [~,ind] = find( squeeze(abs(dataCubeC(:,i,:)))>=thresh2Ignore );
    dataCubeC(:,i,unique(ind))=NaN(size(dataCubeC,1),length(unique(ind)));
end
% average waveforms across all the observations
dataCube = squeeze(nanmean(dataCube,3)); % p300 cube is now matrix
dataCubeC = squeeze(nanmean(dataCubeC,3)); % common cube is now matrix
mData=  dataCube - dataCubeC; % subtract these to get waveform

% lets look at P300 latency & amplitude, N200 latency & amplitude
time=(0:1/fs:(size(mData,1)-1)/fs)*1000;
if(toPlot==1)
    plot(time,mData(:,2)); % plot Pz waveform (fix this number to match!)
end

% % find the p300 latency
p3samp=round(p300win*fs/1000);
n2samp=round(n200win*fs/1000);


% this shit is retarderd? rather than just using max and stuff, use
% some more intelligent method? (mid-point between zero crossings? who 
% knows), find some literature to support how we choose the latencies and
% amplitudes

p3latency = zeros(1,size(mData,2));
for ii = 1:size(mData,2)
    p3latency(ii) = round(time( mData(:,ii) == max( mData(p3samp(1):p3samp(2),ii)) ));
end
p3amplitude = zeros(1,size(mData,2));
for ii = 1:size(mData,2)
    p3amplitude(ii) = mData(( mData(:,ii) == max( mData(p3samp(1):p3samp(2),ii)) ),ii);
end
n2latency = zeros(1,size(mData,2));
for ii = 1:size(mData,2)
    n2latency(ii) = round(time( mData(:,ii) == min( mData(n2samp(1):n2samp(2),ii)) ));
end
n2amplitude = zeros(1,size(mData,2));
for ii = 1:size(mData,2)
    n2amplitude(ii) = mData(( mData(:,ii) == min( mData(n2samp(1):n2samp(2),ii)) ),ii);
end

% arrange and vectorize these features
features = [p3latency; p3amplitude; n2latency; n2amplitude];
features = features(:);
features = features';


% maybe add some frontal hemispheric differneces also??? EVMS wants to show
% increased 'symmetry' in activity from before to after treatment, so let's
% look at that somehow? specifically in teh frontal areas

% so let's treat these sessions similar to the resting/baseline EEG ones
ignore = 3; % ignore the first and last 3 seconds of the trials, but remember there are two runs concatenated!!
mInd = 1:size(sig,1);
mInd = mInd( (ignore*fs+1) : (end-ignore*fs) );
mInd( (round(length(mInd)/2)-3*fs):(round(length(mInd)/2)+3*fs) ) = [];
chLeft = [1 17 19 21 22];
chRight = [3 18 20 23 24];
% just average the left and right frontal electrodes?
sigL = nanmean( sig( mInd,chLeft ),2 );
sigR = nanmean( sig( mInd,chRight ),2 );

% calculate the correlation between the two
r = corr( sigL, sigR );
features = [features r];

% screw it, let's also add MI stuff as well?
cd('.\MutualInformationICA\');
mi = MIhigherdim( [sigL';sigR'] );
cd('..\');
% normalize MI by dividing by sqrt of product of entropies
miNorm = mi/ sqrt( entropy(sigL',[],[],2)*entropy(sigR',[],[],2) );
features = [features mi miNorm];





% KEEP THIS UP TO DATE WHENEVER YOU CHANGE THIS FILE SO YOU CAN TELL WHAT
% THE FEATURES ACTUALLY REFER TO WHEN LOOKING TO SEE WHATS IMPORTANT /
% CORRELATED WITH TREATMENT OUTCOMES!!!!!

% as it stands 15 features are:
%     [Cz, Pz, POz, R, MI, MI_normalized]
% where each of the first 3 have 4 measures (p3latency; p3amplitude; n2latency; n2amplitude)















>>>>>>> origin/master
