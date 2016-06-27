
clear; clc; close all;

% Dataset Root Location
mRootDir = 'C:\Users\Mike\Google Drive\EVMS\';

% 4 possible sessions for each subject:
% 1: Baseline
% 2: Session5
% 3: Session15
% 4: EndofTreatment

% 4 Runs within each session in this order:
% 1: Eyes open, basically resting eeg
% 2: Eyes closed, resting eeg
% 3: Oddball task 1
% 4: Oddball task 2

% Some sessions are really bad / corrupted!!!!!! So don't just use this as
% is. Also some subjects didn't get all the sessions in

% Patient Identification
kk=1;

Data(kk).pID = {'AMa'};
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 16 23 30 37 45 55 65 ];
Data(kk).Outcomes.BDI =  [ 40 24 14 15 16 14 16 15 ];
Data(kk).Outcomes.BAI =  [ 14 10  3  3  5  4  4  3 ];
Data(kk).Outcomes.EEGDay = [ 6 14 28 65 ];
kk=kk+1;

Data(kk).pID = {'AWa'};
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 45 53 59 66 73 81 93 ];
Data(kk).Outcomes.BDI =  [ 35 10 13  0  0  0  0  0 ];
Data(kk).Outcomes.BAI =  [ 14  4 10  1  3  1  1  0 ];
Data(kk).Outcomes.EEGDay = [ 39 45 56 93];
kk=kk+1;

Data(kk).pID = {'BKBr'};
Data(kk).Sessions=[ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1 63 70 78 85 92 101 121 ];
Data(kk).Outcomes.BDI =  [ 20 19  7 18 18  8   9   8 ];
Data(kk).Outcomes.BAI =  [  8  7  4  5  7  1   1   0 ];
Data(kk).Outcomes.EEGDay = [ 51 63 84 121 ];
kk=kk+1;

% Data(kk).pID = {'BPe'};         % needs updating
% Data(kk).Sessions=[ 1 2  ];
% Data(kk).Outcomes.Days = [  ];
% Data(kk).Outcomes.BDI =  [  ];
% Data(kk).Outcomes.BAI =  [  ];
% Data(kk).Outcomes.EEGDay = [  ];
% kk=kk+1;

Data(kk).pID = {'CMi'};         % session 3 and 4 were completely problematic 
Data(kk).Sessions=[ 1 2  ];
Data(kk).Outcomes.Days = [  1 14 21 28 35 42 50 64 ];
Data(kk).Outcomes.BDI =  [ 25  3  6  3  3  5  7  2 ];
Data(kk).Outcomes.BAI =  [ 19  5  5  2  2  3  2  2 ];
Data(kk).Outcomes.EEGDay = [ 7 20  ];
kk=kk+1;

% Data(kk).pID = {'EBa'};        % needs updating
% Data(kk).Sessions=[ ];
% Data(kk).Outcomes.Days = [ ];
% Data(kk).Outcomes.BDI =  [  ];
% Data(kk).Outcomes.BAI =  [ ];
% Data(kk).Outcomes.EEGDay = [  ];
% kk=kk+1;


Data(kk).pID = {'GMu'};
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 16 23 33 40 47 65 71 81 ]; 
Data(kk).Outcomes.BDI =  [ 38 17 11  9  8  4  3  2  1 ];
Data(kk).Outcomes.BAI =  [ 17  6  5  2  2  2  1  0  0 ];
Data(kk).Outcomes.EEGDay = [ 5 23 31 81 ];
kk=kk+1;

Data(kk).pID = {'HLu'};   % session 3 and 4 were completely problematic 
Data(kk).Sessions=[1 2 ];
Data(kk).Outcomes.Days = [ 1 58 66 72 84 91 101 114 ];
Data(kk).Outcomes.BDI = [ 29 29 21 24 28 18 12 11 ];
Data(kk).Outcomes.BAI = [ 4 5 3 2 4 2 1 2 ];
Data(kk).Outcomes.EEGDay = [ 51 60 ];
kk=kk+1;

Data(kk).pID = {'JCa'};  % session 2 and 4 were completely problematic 
Data(kk).Sessions=[1  3 ];
Data(kk).Outcomes.Days = [  1 24 31 54 61 71 78 93];
Data(kk).Outcomes.BDI =  [ 43 38 36 31 33 36 35 40 ];
Data(kk).Outcomes.BAI =  [ 45 37 35 40 30 39 43 42 ];
Data(kk).Outcomes.EEGDay = [ 10  51  ];
kk=kk+1;

Data(kk).pID = {'MPe'}; 
Data(kk).Sessions=[2 3]; % fix structure!!
Data(kk).Outcomes.Days = [  1 13 20 27 35 42 49 58 ];
Data(kk).Outcomes.BDI =  [ 33 31 26 36 37 40 40 44 ];
Data(kk).Outcomes.BAI =  [  9 11  7  8 11 15 13 15 ];
Data(kk).Outcomes.EEGDay = [ 13 26 ];
kk=kk+1;

% Data(kk).pID = {'Mru'};     % needs updating
% Data(kk).Sessions=[]; % fix structure!!
% Data(kk).Outcomes.Days = [   ];
% Data(kk).Outcomes.BDI =  [  ];
% Data(kk).Outcomes.BAI =  [ ];
% Data(kk).Outcomes.EEGDay = [  ];
% kk=kk+1;

% Data(kk).pID = {'MTa'};     % needs updating
% Data(kk).Sessions=[ ]; % fix structure!!
% Data(kk).Outcomes.Days = [  ];
% Data(kk).Outcomes.BDI =  [  ];
% Data(kk).Outcomes.BAI =  [   ];
% Data(kk).Outcomes.EEGDay = [  ];
% kk=kk+1;


% Data(kk).pID = {'MWh'};     % needs updating
% Data(kk).Sessions=[]; % fix structure!!
% Data(kk).Outcomes.Days = [   ];
% Data(kk).Outcomes.BDI =  [  ];
% Data(kk).Outcomes.BAI =  [   ];
% Data(kk).Outcomes.EEGDay = [  ];
% kk=kk+1;


Data(kk).pID = {'MWi'};
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 63 70 77 90 97 105 112 ];
Data(kk).Outcomes.BDI =  [ 38 32 22 14 14 11  11   6 ];
Data(kk).Outcomes.BAI =  [ 10  5  4  2  1  0   0   0 ];
Data(kk).Outcomes.EEGDay = [ 8 62 77 112 ];
kk=kk+1;

Data(kk).pID = {'NSt'};
Data(kk).Sessions=[ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1 66 74 81 92 99 106 117 ];
Data(kk).Outcomes.BDI =  [ 36 10  9  3  6  6   4   2 ];
Data(kk).Outcomes.BAI =  [ 20  8  5  4  4  9   4   3 ];
Data(kk).Outcomes.EEGDay = [ 43 58 80 117 ];
kk=kk+1;

Data(kk).pID = {'NTo'};
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 27 37 44 63 70 78 99 ];
Data(kk).Outcomes.BDI =  [ 41 25 32 15 18 15 12  8 ];
Data(kk).Outcomes.BAI =  [ 10 11 14  9  9  7  4  3 ];
Data(kk).Outcomes.EEGDay = [ 14 30 44 99 ];
kk=kk+1;

Data(kk).pID = {'PCi'};
Data(kk).Sessions=[ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1 22 29 36 43 50 57 72 ];
Data(kk).Outcomes.BDI =  [ 50 23 20 19 20 31 30 38 ];
Data(kk).Outcomes.BAI =  [ 39 24 20 17 16 19 19 26 ];
Data(kk).Outcomes.EEGDay = [ 1 22 36 72];
kk=kk+1;


Data(kk).pID = {'R-LGo'};
Data(kk).Sessions=[ 2 3 4];
Data(kk).Outcomes.Days = [  1 21 28 36 42 49 57 79 ];
Data(kk).Outcomes.BDI =  [ 46 26 10  4  2  2  2  1 ];
Data(kk).Outcomes.BAI =  [ 28 25 21 13  6  3  5  4 ];
Data(kk).Outcomes.EEGDay = [  17 36 79 ];
kk=kk+1;

% 
% Data(kk).pID = {'RMe'};     % needs updating
% Data(kk).Sessions=[  ];
% Data(kk).Outcomes.Days = [   ];
% Data(kk).Outcomes.BDI =  [  ];
% Data(kk).Outcomes.BAI =  [  ];
% Data(kk).Outcomes.EEGDay = [  ];
% kk=kk+1;

Data(kk).pID = {'SCo'};
Data(kk).Sessions=[ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1  3 16 27 44 52 70 79 93 ];
Data(kk).Outcomes.BDI =  [ 59 58 58 52 50 54 54 42 28 ];
Data(kk).Outcomes.BAI =  [ 55 54 47 38 41 37 35 25 18 ];
Data(kk).Outcomes.EEGDay = [ 9 14 41 93 ];
kk=kk+1;

Data(kk).pID = {'SHa'};
Data(kk).Sessions=[1 2 3];
Data(kk).Outcomes.Days = [  1 13 21 28 36 44 55 73 ];
Data(kk).Outcomes.BDI = [ 23 19 14 13 15  8 10  7 ];
Data(kk).Outcomes.BAI = [ 17 11  5  7  5  3  1  1 ];
Data(kk).Outcomes.EEGDay = [ 1 10 27 ];
kk=kk+1;



sub = [ 1 : 15 ]; % subjects to look at, since not all are complete, and since some have bad sessions (see excel spreadsheet) due to loose reference on cap2

%% FEATURE CONSTRUCTION
% Let's first construct features for each subject, we want to see how
% they vary over the course of the treatment, and if they vary in
% a manner which is predictable, or if they correlate with some
% measure of outcome (for instance, how depressed they are is BDI: 
% Beck's Depression Index ... or anxiety levels BAI)
% for i = 1:length(Data)
cntr=1;
for i = sub
    fprintf(1,'Creating features for subject %g',i);

    % directories for the 4 possible sessions
    mDirs{1} = [char(mRootDir) char(Data(i).pID) '\RegistrySubject' char(Data(i).pID) 'Baseline\'];
    mDirs{2} = [char(mRootDir) char(Data(i).pID) '\RegistrySubject' char(Data(i).pID) 'Session5\'];
    mDirs{3} = [char(mRootDir) char(Data(i).pID) '\RegistrySubject' char(Data(i).pID) 'Session15\'];
    mDirs{4} = [char(mRootDir) char(Data(i).pID) '\RegistrySubject' char(Data(i).pID) 'EndofTx\'];
     
    for j = 1:length(mDirs)
        if( ismember(j,Data(i).Sessions) )
            mDir = char(mDirs{j});
            mFiles = dir([mDir '\*.dat']);            
            [ sig,st,prm ] = load_bcidat( [char(mDir) char(mFiles(1).name)],'-calibrated' );
            [ sig,st,prm ] = ArtifactRejection( sig,st,prm );
            Features{cntr}.Open{j,1} = GetRestingFeatures( sig, st, prm );
            fprintf(1,'.');             
            [ sig,~,prm ] = load_bcidat( [char(mDir) char(mFiles(2).name)],'-calibrated' );
            [ sig,st,prm ] = ArtifactRejection( sig,st,prm );
            Features{cntr}.Closed{j,1} = GetRestingFeatures( sig, st, prm );
            fprintf(1,'.');            
            [ sig,st,prm ] = load_bcidat( [char(mDir) char(mFiles(3).name)],[char(mDir) char(mFiles(4).name)],'-calibrated' );            
            [ sig,st,prm ] = ArtifactRejection( sig,st,prm );
            Features{cntr}.P3{j,1} = GetP3Features( sig,st,prm,0 );
            fprintf(1,'.');
        end
    end        
    fprintf(1,'done\n');
    cntr=cntr+1;
end; clearvars -except Features Data mRootDir sub sig st prm;



%% FEATURE ORGANIZING
% Now we need to correlate these features with outcomes or see how they
% progress through time

% let's just stick these in order [open closed p3], so (43+43+15)=101
% measures over 4 sessions, still keep as cell arrays for subject?
% replace missing features with Not-a-Number


for i = 1:length(Features) % for each subject                           
    o = Features{i}.Open; % for eyes open
    mMaxSize = 0;
    for j = 1:length(Data(i).Sessions )
        if( j < length(o) )
            ms= length( cell2mat( o(j) ));
            if( ms > mMaxSize )
                mMaxSize = ms;
            end
        end        
    end
    for j = 1:length(Data(i).Sessions )
       if( j<=length(o) )
           if isempty( cell2mat( o(j) ) )
               o{j} = NaN(1,mMaxSize);
           end
       else
          o{j} = NaN(1,mMaxSize); 
       end        
    end
    o = cell2mat( o ); % for eyes closed                           
    c = Features{i}.Closed;
    mMaxSize = 0;
    for j = 1:length(Data(i).Sessions ) 
        if( j < length(c) )
            ms= length( cell2mat( c(j) ));
            if( ms > mMaxSize )
                mMaxSize = ms;
            end
        end        
    end
    for j = 1:length(Data(i).Sessions )
       if( j<=length(c) )
           if isempty( cell2mat( c(j) ) )
               c{j} = NaN(1,mMaxSize);
           end
       else
          c{j} = NaN(1,mMaxSize); 
       end        
    end
    c = cell2mat( c );                               
    p = Features{i}.P3; % for p300
    mMaxSize = 0;
    for j = 1:length(Data(i).Sessions )
        if( j < length(p) )
            ms= length( cell2mat( p(j) ));
            if( ms > mMaxSize )
                mMaxSize = ms;
            end
        end        
    end
    for j = 1:length(Data(i).Sessions )
       if( j<=length(p) )
           if isempty( cell2mat( p(j) ) )
               p{j} = NaN(1,mMaxSize);
           end
       else
          p{j} = NaN(1,mMaxSize); 
       end        
    end
    p = cell2mat( p );        
    features{i}=[ o c p ];
end; clearvars -except Features Data mRootDir features sub  sig st prm;
features = features';
features = cell2mat( features );


%% NOW SEE WHAT FEATURES FOLLOW TRENDS ACROSS SUBJECTS
%  E.G., CONSISTENTLY INCREASE OR DECREASE THROUGH TREATMENT SESSIONS

% we create vectors containing the BDI and BAI values 
BAI = [];
BDI = [];
for i = 1:length(sub)
    
    if (isfield(Data(sub(i)).Outcomes, 'EEGDay' ))
        c = Data(sub(i)).Outcomes.EEGDay(:) ;
        a = Data(sub(i)).Outcomes.Days(:);
        b1 = Data(sub(i)).Outcomes.BDI(:) ;
        b2 = Data(sub(i)).Outcomes.BAI(:) ;
        r1 = interp1(a, b1, c);
        r2 = interp1(a, b2, c);
    end          
        
    % vectors containing the BDI and BAI values on EEGDay 
    BDI = cat(1, BDI , r1);
    BAI = cat(1, BAI , r2);
        
end;  

features(isnan(features))=[];
features = reshape(features,length(BAI),[]);

%compute correlation
corr_BDI = zeros (1, size(features,2));  
corr_BAI = zeros (1, size(features,2));    

for i = 1 : size(features,2)
        corr_BDI(i) = corr( BDI , features(:,i));
        corr_BAI(i) = corr( BAI , features(:,i));
end


[BDI_corrValues BDI_corrInd] = sort(corr_BDI);
[BAI_corrValues BAI_corrInd] = sort(corr_BAI);

clearvars -except Features Data mRootDir features sub sig st prm BDI BAI d_corr_values d_corr_ind a_corr_values a_corr_ind; 






