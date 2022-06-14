%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Evaluate a sample of 30 retinal veins with manually identifies centerlines, 
%% calcuating their tortuosity according to the various metrics described in:
%% E. Grisan, M. Foracchia and A. Ruggeri, 
%% "A novel method for the automatic grading of retinal vessel tortuosity", 
%% IEEE Trans Med Imaging, 2008 Mar;27(3):310-9. doi: 10.1109/TMI.2007.904657.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('./RET_Tort')

load('./data/Vein_Data.mat')

%% Match name ordering in the vessel structure with name ordering for manual grading
for ct=1:30,
    fname=fn{ct};
    n=findstr(fname,'-');
    fstr{ct}=fname(n+1:end-4);
end;

[fsort,namesort]=sort(fstr);

%% Manual tortuosity ranking
clinsort_v=[10,4,1,19,8,23,22,13,9,17,21,11,12,20,14,7,5,27,26,25,15,3,24,16,18,28,29,2,6,30];
clinsort=clinsort_v;

%% Evaluating tortuosity indeces
tortpar.k0    = 10;
tortpar.h     =  0.03;
tortpar.passo = 0.1;
tortpar.lmin  = 1;

t=[];
for ct=1:length(fsort),
    [tort,x,y,k,indici]=TORTsegind(segs(namesort(ct)).ppx,segs(namesort(ct)).ppy,tortpar,dbf);
    [t(ct,:),indici]=TORTind(x,y,k,tortpar.lmin,tortpar.h,tortpar.k0,tortpar.passo,dbf);
end;

%% Evaluate correlation between each tortuosity metric and the manual ranking
tsort=zeros(size(t));
for ct=1:size(t,2)
    temp=t(:,ct);
    [tempsort,tortidx]=sort(temp);
    c(ct)=corr(sort(clinsort)',clinsort(tortidx)','type','Spearman');
end;
    
