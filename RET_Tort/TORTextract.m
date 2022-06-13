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
    fname=fn{ctim};
    disp(sprintf('Evaluation Image %s : %i of %i', fname,ctim, length(fn)));
    xo=im2double(imread([pathdata,fname]));
    xroi=xo(:,:,2);
    sx=size(xo,1);
    sy=size(xo,2);
    
    [vx,vy]=TORTInteractiveSamples(xroi,dbf);
    
    seg(ctim).x=vx;
    seg(ctim).y=vy;
    seg(ctim).imagename=fname;
    seg(ctim).dir=[];
    seg(ctim).ppx=[];
    seg(ctim).ppy=[];
    seg(ctim).t=[];
    
    segs(ctim)=TORTspline(seg(ctim),smoothxy,dbf);
    
    [s,chord,tc,tsc,ad,nc]=TORTothers(segs(ctim),dbf);
    seg_lpp=RETlpp(segs(ctim),tortpar.passo,dbf); 
    segs(ctim).t=TORTsegind(segs(ctim).ppx,segs(ctim).ppy,tortpar,dbf);
    T=segs(ctim).t;
    tindexes=TORTindex(s,chord,tc,tsc,T,dbf);
    tindexes=[tindexes,ad,nc];
    segs(ctim).t=tindexes;
    
    F=fopen([pathdata,'\TortIndex.txt'],'a+');
    if(titlewritten==0)
        fprintf(F,'Image Name, Tortuosity, s/chord-1, tc, tsc, tc/s, tsc/s, tc/chord, tsc/chord, chandrinos, goh\n');
        titlewritten=1;
    end;
    
    fprintf(F,'%s',fname);
    for ctt=1:length(tindexes);
        fprintf(F,',%f',tindexes(ctt));
    end;
    fprintf(F,'\n');
    fclose(F);
end;
    