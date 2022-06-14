%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Evaluate a sample of 30 retinal arteries with manually identifies centerlines, 
%% calcuating their tortuosity according to the various metrics described in:
%% E. Grisan, M. Foracchia and A. Ruggeri, 
%% "A novel method for the automatic grading of retinal vessel tortuosity", 
%% IEEE Trans Med Imaging, 2008 Mar;27(3):310-9. doi: 10.1109/TMI.2007.904657.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('./RET_Tort')

load('./data/Artery_Data.mat')

%% Match name ordering in the vessel structure with name ordering for manual grading
for ct=1:30,
    fname=fn{ct};
    n=findstr(fname,'-');
    fstr{ct}=fname(n+1:end-4);
end;

[fsort,namesort]=sort(fstr);

%% Manual tortuosity ranking
clinsort_a=[12,26,2,24,8,15,29,7,28,10,14,22,27,6,20,3,11,5,1,16,21,25,13,19,17,18,23,4,9,30];
clinsort=clinsort_a;

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
    
