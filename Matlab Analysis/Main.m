clear; clc; close all;

% Dataset Root Location
mRootDir = 'C:\Users\Mike\Google Drive\EVMS\';

%{
-4 possible sessions for each subject:
    1: Baseline
    2: Session5
    3: Session15
    4: EndofTreatment

-4 Runs within each session in this order:
    1: Eyes open, basically resting eeg
    2: Eyes closed, resting eeg
    3: Oddball task 1
    4: Oddball task 2

-BDI levels:
    0�9: indicates minimal depression
    10�18: indicates mild depression
    19�29: indicates moderate depression
    30�63: indicates severe depression.

* Some sessions are really bad / corrupted!!!!!! So don't just use this as
  is. Also some subjects didn't get all the sessions in


List of patients added:
    ACo-Pa  AMa     AWa     BKBr    BKn
    BPe     CMi     EBa     EGr     GMu 
    GMe     HLu     JCa     JGr     JJo
    JLa     MaWi    MDe     MMc     MPe     
    MRu     MTa     MWh     MWi     NKo     
    NMi     NSt     NTo     PCi     R-LGo   
    RMe     SCo     SHa     VMc     WCu
%}

% Patient Identification
kk=1;

Data(kk).pID = {'ACo-Pa'};     %improved 2 levels ( severe to mild )
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 21 29 36 43 50 57 83 ];
Data(kk).Outcomes.BDI =  [ 44 32 38 29 13 15 13 10 ];
Data(kk).Outcomes.BAI =  [ 37 35 30 27 16 19 16 27 ];
Data(kk).Outcomes.EEGDay = [ 15 20 34 83 ];
Data(kk).Improved = [ 2 ];
kk=kk+1;

% Data(kk).pID = {'AMa'};     %improved 2 levels ( severe to mild )
% Data(kk).Sessions=[1 2 3 4];
% Data(kk).Outcomes.Days = [  1 16 23 30 37 45 55 65 ];
% Data(kk).Outcomes.BDI =  [ 40 24 14 15 16 14 16 15 ];
% Data(kk).Outcomes.BAI =  [ 14 10  3  3  5  4  4  3 ];
% Data(kk).Outcomes.EEGDay = [ 6 14 28 65 ];
% Data(kk).Improved = [ 2 ];
% kk=kk+1;

Data(kk).pID = {'AWa'};    %improved 3 levels (severe to minimal)
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 45 53 59 66 73 81 93 ];
Data(kk).Outcomes.BDI =  [ 35 10 13  0  0  0  0  0 ];
Data(kk).Outcomes.BAI =  [ 14  4 10  1  3  1  1  0 ];
Data(kk).Outcomes.EEGDay = [ 39 45 56 93];
Data(kk).Improved = [ 3 ];
kk=kk+1;

Data(kk).pID = {'BKBr'}; % improved 2 levels (moderate - minimal)
Data(kk).Sessions=[ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1 63 70 78 85 92 101 121 ];
Data(kk).Outcomes.BDI =  [ 20 19  7 18 18  8   9   8 ];
Data(kk).Outcomes.BAI =  [  8  7  4  5  7  1   1   0 ];
Data(kk).Outcomes.EEGDay = [ 51 63 84 121 ];
Data(kk).Improved = [ 2 ];
kk=kk+1;

Data(kk).pID = {'BKBr'}; % improved 2 levels (moderate - minimal)
Data(kk).Sessions=[ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1 63 70 78 85 92 101 121 ];
Data(kk).Outcomes.BDI =  [ 20 19  7 18 18  8   9   8 ];
Data(kk).Outcomes.BAI =  [  8  7  4  5  7  1   1   0 ];
Data(kk).Outcomes.EEGDay = [ 51 63 84 121 ];
Data(kk).Improved = [ 2 ];
kk=kk+1;

Data(kk).pID = {'BKn'};         
Data(kk).Sessions = [ 1 2 3 4 ];
Data(kk).Outcomes.Days = [ 1 109 116 123 133 140 147 162 ];
Data(kk).Outcomes.BDI =  [ 53 33  45  52  50  61  44  17 ];
Data(kk).Outcomes.BAI =  [ 22 22  29  18  16  36  11  14 ];
Data(kk).Outcomes.EEGDay = [ 100 108 123 162 ];
Data(kk).Improved = [ 2 ];
kk=kk+1;

Data(kk).pID = {'EGr'};     % did not improve      
Data(kk).Sessions = [ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1 61 73 82 88 96 103 115 135 ];
Data(kk).Outcomes.BDI =  [ 36 35 35 29 25 21  34  33  46 ];
Data(kk).Outcomes.BAI =  [ 30 28 36 28 30 28  27  27  30 ];
Data(kk).Outcomes.EEGDay = [ 58 82 99 135 ];
Data(kk).Improved = [ 0 ];
kk=kk+1;

% Data(kk).pID = {'CMi'};         % session 3 and 4 were completely problematic 
% Data(kk).Sessions=[ 1  2  ];
% Data(kk).Outcomes.Days = [  1 14 21 28 35 42 50 64 ];
% Data(kk).Outcomes.BDI =  [ 25  3  6  3  3  5  7  2 ];
% Data(kk).Outcomes.BAI =  [ 19  5  5  2  2  3  2  2 ];
% Data(kk).Outcomes.EEGDay = [ 7 20  ];
% kk=kk+1;

% Data(kk).pID = {'EBa'};        % needs updating
% Data(kk).Sessions=[ ];
% Data(kk).Outcomes.Days = [ ];
% Data(kk).Outcomes.BDI =  [  ];
% Data(kk).Outcomes.BAI =  [ ];
% Data(kk).Outcomes.EEGDay = [  ];
% kk=kk+1;


Data(kk).pID = {'GMe'};   
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 24 30 71 78 91 100 113 ]; 
Data(kk).Outcomes.BDI =  [ 23 28 21 13  6 10   9   5 ];
Data(kk).Outcomes.BAI =  [  2  5  5  1  1  3   5   3 ];
Data(kk).Outcomes.EEGDay = [ 16 22 69 113 ];
Data(kk).Improved = [ 2 ];
kk=kk+1;



Data(kk).pID = {'GMu'};   %improved 3 levels (severe to minimal)
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 16 23 33 40 47 65 71 81 ]; 
Data(kk).Outcomes.BDI =  [ 38 17 11  9  8  4  3  2  1 ];
Data(kk).Outcomes.BAI =  [ 17  6  5  2  2  2  1  0  0 ];
Data(kk).Outcomes.EEGDay = [ 5 23 31 81 ];
Data(kk).Improved = [ 3 ];
kk=kk+1;

Data(kk).pID = {'JJo'};   
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 66 74 84 91 98 107 129 ];
Data(kk).Outcomes.BDI =  [ 15 10  8  4  3  4   4   6 ];
Data(kk).Outcomes.BAI =  [ 16  3  5  4  4  2   6   2 ];
Data(kk).Outcomes.EEGDay = [ 58 66 80 129 ];
Data(kk).Improved = [ 1 ];
kk=kk+1;

Data(kk).pID = {'JLa'};   
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 52 60 72 80 93 102 131 ];
Data(kk).Outcomes.BDI =  [ 33 22 25 22 15 16  14  25 ];
Data(kk).Outcomes.BAI =  [ 11  5  5  2  1  2   2   9 ];
Data(kk).Outcomes.EEGDay = [ 36 53 65 131 ];
Data(kk).Improved = [ 1 ];
kk=kk+1;

Data(kk).pID = {'JGr'};   
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 63 75 79 89 98 110 128 ];
Data(kk).Outcomes.BDI =  [ 25 23 21 21 17 15  18  14 ];
Data(kk).Outcomes.BAI =  [ 11 16 12 11 13  9  10   9 ];
Data(kk).Outcomes.EEGDay = [ 54 61 77 128 ];
Data(kk).Improved = [ 1 ];
kk=kk+1;

% Data(kk).pID = {'HLu'};   % session 3 and 4 were completely problematic 
% Data(kk).Sessions=[1 2 ];
% Data(kk).Outcomes.Days = [ 1 58 66 72 84 91 101 114 ];
% Data(kk).Outcomes.BDI = [ 29 29 21 24 28 18 12 11 ];
% Data(kk).Outcomes.BAI = [ 4 5 3 2 4 2 1 2 ];
% Data(kk).Outcomes.EEGDay = [ 51 60 ];
% kk=kk+1;

% Data(kk).pID = {'JCa'};  % session 2 and 4 were completely problematic 
% Data(kk).Sessions=[1  3 ];
% Data(kk).Outcomes.Days = [  1 24 31 54 61 71 78 93];
% Data(kk).Outcomes.BDI =  [ 43 38 36 31 33 36 35 40 ];
% Data(kk).Outcomes.BAI =  [ 45 37 35 40 30 39 43 42 ];
% Data(kk).Outcomes.EEGDay = [ 10  51  ];
% kk=kk+1;

Data(kk).pID = {'MWi'};     
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [ 1  25 32 39 46 53 60 82 ];
Data(kk).Outcomes.BDI =  [ 44 34 34 27 26 24 24 20 ];
Data(kk).Outcomes.BAI =  [ 24 21 15 10 10  7  6  8 ];
Data(kk).Outcomes.EEGDay = [ 7 25 40 82 ];
Data(kk).Improved = [ 1 ];
kk=kk+1;

% Data(kk).pID = {'MPe'}; 
% Data(kk).Sessions=[2 3]; % fix structure!!
% Data(kk).Outcomes.Days = [  1 13 20 27 35 42 49 58 ];
% Data(kk).Outcomes.BDI =  [ 33 31 26 36 37 40 40 44 ];
% Data(kk).Outcomes.BAI =  [  9 11  7  8 11 15 13 15 ];
% Data(kk).Outcomes.EEGDay = [ 13 26 ];
% kk=kk+1;

% Data(kk).pID = {'MRu'};     % sessions 1 and 4 are compromised
% Data(kk).Sessions = [ 1 2 3 4 ]; 
% Data(kk).Outcomes.Days = [  1 14 20 27 35 42 49 69 ];
% Data(kk).Outcomes.BDI =  [ 25 23 21 22 14 19 14 12 ];
% Data(kk).Outcomes.BAI =  [ 25 24 18 19 12 24 16 17 ];
% Data(kk).Outcomes.EEGDay = [ 6 15 28 69 ];
% Data(kk).Improved = [ 1 ];
% kk=kk+1;

Data(kk).pID = {'MDe'};   
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 20 26 34 41 49 56 69 ];
Data(kk).Outcomes.BDI =  [ 38 31 30 26 22 26 24 24 ];
Data(kk).Outcomes.BAI =  [ 24 16 14 10 10 11 13 10 ];
Data(kk).Outcomes.EEGDay = [ 12 21 30 69 ];
Data(kk).Improved = [ 1 ];
kk=kk+1;

Data(kk).pID = {'MMc'};     
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 30 37 49 57 64 78 92 ];
Data(kk).Outcomes.BDI =  [ 24  5  7 10  8  2  3  5 ];
Data(kk).Outcomes.BAI =  [ 14  9  3  6  3  3  4  2 ];
Data(kk).Outcomes.EEGDay = [ 23 29 46 92 ];
Data(kk).Improved = [ 2 ];
kk=kk+1;

Data(kk).pID = {'MTa'};     
Data(kk).Sessions=[ 1 2 3 4 ]; 
Data(kk).Outcomes.Days = [  1 13 20 27 34 41 52 70 ];
Data(kk).Outcomes.BDI =  [ 28 26 21 20 21 21 15 25 ];
Data(kk).Outcomes.BAI =  [ 13 12  7  9  7  9  6  7 ];
Data(kk).Outcomes.EEGDay = [ 6 10 24 84 ];
Data(kk).Improved = [ 0 ];
kk=kk+1;

% Data bad for at least 3 sesions
% Data(kk).pID = {'MWh'};     
% Data(kk).Sessions=[ 1 2 3 4 ]; 
% Data(kk).Outcomes.Days = [  1 16 23 32 40 50 57 68 ];
% Data(kk).Outcomes.BDI =  [ 37 33 25 27 20 20 20 15 ];
% Data(kk).Outcomes.BAI =  [ 20 25 21 15 15 30 22 24 ];
% Data(kk).Outcomes.EEGDay = [ 9 16 37 68 ];
% Data(kk).Improved = [ 2 ];
% kk=kk+1;


Data(kk).pID = {'MWi'};     %improved 3 levels (severe to minimal)
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 63 70 77 90 97 105 112 ];
Data(kk).Outcomes.BDI =  [ 38 32 22 14 14 11  11   6 ];
Data(kk).Outcomes.BAI =  [ 10  5  4  2  1  0   0   0 ];
Data(kk).Outcomes.EEGDay = [ 8 62 77 112 ];
Data(kk).Improved = [ 3 ];
kk=kk+1;

Data(kk).pID = {'NKo'};     
Data(kk).Sessions=[ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1 49 58 69 79 86 96 118 ];
Data(kk).Outcomes.BDI =  [ 31 12 15  9  3  8  9  12 ];
Data(kk).Outcomes.BAI =  [ 11  6 16  7  8  8  4  10 ];
Data(kk).Outcomes.EEGDay = [ 40 55 64 118 ];
Data(kk).Improved = [ 2 ];
kk=kk+1;

Data(kk).pID = {'NMi'};     %improved 3 levels (severe to minimal)
Data(kk).Sessions=[ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1 16 24 36 51 64 79 91 ];
Data(kk).Outcomes.BDI =  [ 21 20 12  9  8  6  6  4 ];
Data(kk).Outcomes.BAI =  [ 11 13  4  4  4  3  4  2 ];
Data(kk).Outcomes.EEGDay = [ 9 18 29 91 ];
Data(kk).Improved = [ 2 ];
kk=kk+1;

% Data(kk).pID = {'NSt'};     %improved 3 levels (severe to minimal)
% Data(kk).Sessions=[ 1 2 3 4 ];
% Data(kk).Outcomes.Days = [  1 66 74 81 92 99 106 117 ];
% Data(kk).Outcomes.BDI =  [ 36 10  9  3  6  6   4   2 ];
% Data(kk).Outcomes.BAI =  [ 20  8  5  4  4  9   4   3 ];
% Data(kk).Outcomes.EEGDay = [ 43 58 80 117 ];
% Data(kk).Improved = [ 3 ];
% kk=kk+1;

Data(kk).pID = {'NTo'};     %improved 3 levels (severe to minimal)
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 27 37 44 63 70 78 99 ];
Data(kk).Outcomes.BDI =  [ 41 25 32 15 18 15 12  8 ];
Data(kk).Outcomes.BAI =  [ 10 11 14  9  9  7  4  3 ];
Data(kk).Outcomes.EEGDay = [ 14 30 44 99 ];
Data(kk).Improved = [ 3 ];
kk=kk+1;

Data(kk).pID = {'PCi'};     % not improved (severe - severe)
Data(kk).Sessions=[ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1 22 29 36 43 50 57 72 ];
Data(kk).Outcomes.BDI =  [ 50 23 20 19 20 31 30 38 ];
Data(kk).Outcomes.BAI =  [ 39 24 20 17 16 19 19 26 ];
Data(kk).Outcomes.EEGDay = [ 1 22 36 72];
Data(kk).Improved = [ 0 ];
kk=kk+1;


Data(kk).pID = {'R-LGo'};       %improved 3 levels (severe to minimal)
Data(kk).Sessions=[ 2 3 4];
Data(kk).Outcomes.Days = [  1 21 28 36 42 49 57 79 ];
Data(kk).Outcomes.BDI =  [ 46 26 10  4  2  2  2  1 ];
Data(kk).Outcomes.BAI =  [ 28 25 21 13  6  3  5  4 ];
Data(kk).Outcomes.EEGDay = [  17 36 79 ];
Data(kk).Improved = [ 3 ];
kk=kk+1;

% 
% Data(kk).pID = {'RMe'};     % needs updating
% Data(kk).Sessions=[  ];
% Data(kk).Outcomes.Days = [   ];
% Data(kk).Outcomes.BDI =  [  ];
% Data(kk).Outcomes.BAI =  [  ];
% Data(kk).Outcomes.EEGDay = [  ];
% kk=kk+1;

Data(kk).pID = {'SCo'};     %improved 1 level (severe to moderate)
Data(kk).Sessions=[ 1 2 3 4 ];
Data(kk).Outcomes.Days = [  1  3 16 27 44 52 70 79 93 ];
Data(kk).Outcomes.BDI =  [ 59 58 58 52 50 54 54 42 28 ];
Data(kk).Outcomes.BAI =  [ 55 54 47 38 41 37 35 25 18 ];
Data(kk).Outcomes.EEGDay = [ 9 14 41 93 ];
Data(kk).Improved = [ 1 ];
kk=kk+1;

% Data(kk).pID = {'SHa'};    %improved 1 level (moderate to mild)
% Data(kk).Sessions=[1 2 3];
% Data(kk).Outcomes.Days = [  1 13 21 28 36 44 55 73 ];
% Data(kk).Outcomes.BDI = [ 23 19 14 13 15  8 10  7 ];
% Data(kk).Outcomes.BAI = [ 17 11  5  7  5  3  1  1 ];
% Data(kk).Outcomes.EEGDay = [ 1 10 27 ];
% Data(kk).Improved = [ 1 ];
% kk=kk+1;

Data(kk).pID = {'VMc'};    
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 37 44 56 63 77 92 113 ];
Data(kk).Outcomes.BDI =  [ 36 29 26 37 27 16 22  24 ];
Data(kk).Outcomes.BAI =  [ 32 42 40 51 52 41 40  40 ];
Data(kk).Outcomes.EEGDay = [ 28 37 53 113 ];
Data(kk).Improved = [ 1 ];
kk=kk+1;

% missing last BDI and BAI values( repeated last known value)
Data(kk).pID = {'WCu'};    %improved 3 levels (severe to minimal)
Data(kk).Sessions=[1 2 3 4];
Data(kk).Outcomes.Days = [  1 13 20 28 35 43 50 63 ];
Data(kk).Outcomes.BDI =  [ 45 35 27 16  8  8  7  12 ];
Data(kk).Outcomes.BAI =  [ 33 13 18 13  9  9  6  5 ];
Data(kk).Outcomes.EEGDay = [ 1 10 27 ];
Data(kk).Improved = [ 1 ];
kk=kk+1;


% subjects that improved
sub = find([Data.Improved] >= 2 ); 
[impGT2,Features1] = GetFeatureSignificance(Data(sub), mRootDir);

fprintf(1,'\n');
%subjects that didn't improve
sub = find([Data.Improved] < 2 ); 
[impLT2,Features2] = GetFeatureSignificance(Data(sub), mRootDir);




