%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate simulated curves and evaluate the tortuosity according to the various metrics described in
%% E. Grisan, M. Foracchia and A. Ruggeri, 
%% "A novel method for the automatic grading of retinal vessel tortuosity", 
%% IEEE Trans Med Imaging, 2008 Mar;27(3):310-9. doi: 10.1109/TMI.2007.904657.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('./RET_functions')

%% Setup legendas for the figures
legenda{1}='\tau';
legenda{2}='L_c/L_\chi-1';
legenda{3}='tc';
legenda{4}='tsc';
legenda{5}='tc/L_c';
legenda{6}='tsc/L_c';
legenda{7}='tc/L_\chi';
legenda{8}='tsc/L_\chi';
legenda{9}='MAC';
legenda{10}='TN';
legenda{11}='ICN';
legenda{12}='TD';

%% Set up tortuosity parameteres
tortpar.k0=1;       % scaling factor for tortuosity values
tortpar.h=0;        % curvature hysteresis threshold
tortpar.passo=0.1;  % interpolation step
tortpar.lmin=1;     % minimum chord length

smoothxy=0.05;      % smoothing spline constant 
dbf=0;              % debug flag: turns on additional figures and messaging
     
%% Amplitude modulation simulation 
F=pi;
Astart=0;
Aend=5;
Aspace=1;
tstart=0;
tend=6*pi;
tampl=TORTSimAmpl(F,Astart,Aend,Aspace,tstart,tend,tortpar,smoothxy,legenda,dbf);
campl=TORTcorr(tampl);

%% Frequency modulation simulation
fstart=0;
fend=pi/2;
fspace=pi/20;
A=2;
tfreq=TORTSimFreq(A,fstart,fend,fspace,tstart,tend,tortpar,smoothxy,legenda,dbf);
cfreq=TORTcorr(tfreq);

%% Amplitude simulation using constant curvature segments (half circles)
rarc=4;
maxarc=6;
tarc=TORTSimArc(rarc,maxarc,tortpar,smoothxy,legenda,dbf);
carc=TORTcorr(tarc);

%% Frequency simulation using constant curvature segments (half circles)
rarc=2;
nmaxarc=6;
tcurv=TORTSimFreqCirc(rarc,nmaxarc,tortpar,legenda,dbf);
ccurv=TORTcorr(tcurv);

call=all([carc,ccurv,cfreq,campl]==1,2);
