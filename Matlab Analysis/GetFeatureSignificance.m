function [p, Features] = GetFeatureSignificance (Data, mRootDir)

%% FEATURE CONSTRUCTION
% Let's first construct features for each subject, we want to see how
% they vary over the course of the treatment, and if they vary in
% a manner which is predictable, or if they correlate with some
% measure of outcome (for instance, how depressed they are is BDI: 
% Beck's Depression Index ... or anxiety levels BAI)

sub = [ 1 : size(Data,2)];
cntr=1;

for i = sub
    fprintf(1,'Creating features for subject %s', char(Data(i).pID));

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
            %rereference to Fz (channel 2)
            sig = sig-repmat(sig(:,2),1,size(sig,2));            
            [ sig,st,prm ] = ArtifactDetection( sig,st,prm );
%             Features{cntr}.Open{j,1} = GetRestingFeatures( sig, st, prm );
            Features{cntr}.Open{j,1} = RestingFeaturesKemp( sig, st, prm );

            fprintf(1,'.');             
            [ sig,~,prm ] = load_bcidat( [char(mDir) char(mFiles(2).name)],'-calibrated' );
            %rereference to Fz (channel 2)
            sig = sig-repmat(sig(:,2),1,size(sig,2));
            [ sig,st,prm ] = ArtifactDetection( sig,st,prm );
%             Features{cntr}.Closed{j,1} = GetRestingFeatures( sig, st, prm );
            Features{cntr}.Closed{j,1} = RestingFeaturesKemp( sig, st, prm );
            
            fprintf(1,'.'); 
            [ sig,st,prm ] = load_bcidat( [char(mDir) char(mFiles(3).name)],[char(mDir) char(mFiles(4).name)],'-calibrated' ); 
            %rereference to Fz (channel 2)
            sig = sig-repmat(sig(:,2),1,size(sig,2));
            [ sig,st,prm ] = ArtifactDetection( sig,st,prm );
%             Features{cntr}.P3{j,1} = GetP3Features( sig,st,prm,0 );
            Features{cntr}.P3{j,1} = RestingFeaturesKemp( sig, st, prm );
            fprintf(1,'.');
        end
    end        
    fprintf(1,'done\n');
    cntr=cntr+1;
end; clearvars -except Features Data mRootDir sub sig st prm;

% clear;
% [sig, st, prm] = load_data;
% [ sig,st,prm ] = ArtifactRejection( sig,st,prm );

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
    o = cell2mat( o ); 
    
    c = Features{i}.Closed;   % for eyes closed                           
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
% BAI = [];
% BDI = [];
% for i = 1:length(sub)
%     
%     if (isfield(Data(sub(i)).Outcomes, 'EEGDay' ))
%         c = Data(sub(i)).Outcomes.EEGDay(:) ;
%         a = Data(sub(i)).Outcomes.Days(:);
%         b1 = Data(sub(i)).Outcomes.BDI(:) ;
%         b2 = Data(sub(i)).Outcomes.BAI(:) ;
%         r1 = interp1(a, b1, c);
%         r2 = interp1(a, b2, c);
%     end          
%         
%     % vectors containing the BDI and BAI values on EEGDay 
%     BDI = cat(1, BDI , r1);
%     BAI = cat(1, BAI , r2);
%         
% end;  
% 
% features(isnan(features))=[];
% features = reshape(features,length(BAI),[]);
% 
% %compute correlation
% corr_BDI = zeros (1, size(features,2));  
% corr_BAI = zeros (1, size(features,2));    
% 
% for i = 1 : size(features,2)
%         corr_BDI(i) = corr( BDI , features(:,i));
%         corr_BAI(i) = corr( BAI , features(:,i));
% end
% 
% 
% [BDI_corrValues BDI_corrInd] = sort(corr_BDI);
% [BAI_corrValues BAI_corrInd] = sort(corr_BAI);
% 
% clearvars -except Features Data mRootDir features sub sig st prm BDI BAI d_corr_values d_corr_ind a_corr_values a_corr_ind; 



before = zeros( size(Features,2) , size(features,2) );
after =  zeros( size(Features,2) , size(features,2) );


for i = 1 : size(Features,2)
    k = 1;
    if isempty(Features{i}.Open{1})
        k = 2;
    end
    before(i,:) = [ Features{i}.Open{k}  Features{i}.Closed{k}  Features{i}.P3{k} ];  
    after(i,:) = [ Features{i}.Open{end}   Features{i}.Closed{end}  Features{i}.P3{end} ];
end


for i = 1 : size(before,2)
    p(i) = signrank( before(:,i), after(:,i) );
end
