close all
clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Debug Flag
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dbf=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Paramaters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
smoothxy=0.01;
tortpar.k0=10;                     % scale factor
%tortpar.h=0.01;                   % hysteresis threshold: vene=0.01 
tortpar.h=0.03;                    % hysteresis threshold: arterie=0.03 
tortpar.passo=0.1;                 % resampling step (the smaller is better (era 0.5))
tortpar.lmin=1;                    % minimum distance between two breaking points

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load an user-chosen image and the relative manual density, contained in
%% the file Manualdensity.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[fn,pathdata]=uigetfiles('*.jpg','Load an Image');
titlewritten=0;
for ctim=1:length(fn)
    
    [s,chord,tc,tsc,ad,nc]=TORTothers(segs(ctim),dbf);
    seg_lpp=RETlpp(segs(ctim),tortpar.passo,dbf); 
    segs(ctim).t=TORTsegind(segs(ctim).ppx,segs(ctim).ppy,tortpar,dbf);
    T=segs(ctim).t;
    tindexes=TORTindex(s,chord,tc,tsc,T,dbf);
    tindexes=[tindexes,ad,nc];
    segs(ctim).t=tindexes;
    
end;
    