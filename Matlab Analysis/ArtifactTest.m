% artifact removal optimization
[sig, st, prm] = load_data;

[sig, st, prm] = ArtifactDetection(sig, st, prm);

% sampling rate of our EEG
fs = prm.SamplingRate.NumericValue;
% first, let's common average re-reference? (maybe try spatial laplacian
% instead?)
sig = sig - repmat( mean(sig,2),1,size(sig,2) );
% then filter between 1 and 30Hz with 8th order butterworth
h  = design( fdesign.bandpass('N,F3dB1,F3dB2', 8, 1, 30, fs), 'butter' );
sig= filter(h,sig);


% % ignore first and last 3 seconds of EEG clip (to drowsy at end, and the
% % signal is sometimes not stabilized at the beginning from amplifiers)
% ignore = 3;
% st.Artifact = st.Artifact( round(ignore*fs+1): round(end-ignore*fs),: );
% sig = sig( round(ignore*fs+1): round(end-ignore*fs),: );

%  plot(sig(:,6));
%  hold on;
%  plot(30*st.Artifact(:,6));