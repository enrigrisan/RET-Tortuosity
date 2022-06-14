close all
clear all

addpath('./RET_Tort')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Debug Flag
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dbf=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Paramaters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
smoothxy=0.01;
tortpar.k0=10;                     % scale factor
%tortpar.h=0.01;                   % hysteresis threshold: veins=0.01 
tortpar.h=0.03;                    % hysteresis threshold: arteries=0.03 
tortpar.passo=0.1;                 % resampling step (the smaller is better (era 0.5))
tortpar.lmin=1;                    % minimum distance between two breaking points

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load a set of user-chosen images, manually define vessels by clicking on
%% vessel centerline, and evaluate tortuosities
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[fn,pathdata]=uigetfile('*.jpg','Load an Image','MultiSelect','on');

titlewritten=0;
for ctim=1:length(fn)

    % Load image
    fname=fn{ctim};
    disp(sprintf('Evaluation Image %s : %i of %i', fname,ctim, length(fn)));
    xo=im2double(imread([pathdata,fname]));
    xroi=xo(:,:,2);
    sx=size(xo,1);
    sy=size(xo,2);

    % Display image and draw centerline
    imagesc(xroi)
    %[vy,vx]=getpts();
    h=drawpolyline();
    vy=h.Position(:,1);
    vx=h.Position(:,2);
    close all

    % Build vessel structure
    seg(ctim).x=vx;
    seg(ctim).y=vy;
    seg(ctim).imagename=fname;
    seg(ctim).dir=[];
    seg(ctim).ppx=[];
    seg(ctim).ppy=[];
    seg(ctim).t=[];
    
    % Create smoothed spline version of vessel centerline
    segs(ctim)=TORTspline(seg(ctim),smoothxy,dbf);
    
    % Evaluate tortuosity metrics
    [s,chord,tc,tsc,ad,nc]=TORTothers(segs(ctim),dbf);
    seg_lpp=RETlpp(segs(ctim),tortpar.passo,dbf); 
    segs(ctim).t=TORTsegind(segs(ctim).ppx,segs(ctim).ppy,tortpar,dbf);
    T=segs(ctim).t;
    tindexes=TORTindex(s,chord,tc,tsc,T,dbf);
    tindexes=[tindexes,ad,nc];
    segs(ctim).t=tindexes;
    
    % Save values in a txt files
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
    