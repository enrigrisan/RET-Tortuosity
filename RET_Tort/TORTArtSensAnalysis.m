%% Artery
%% [corrval,tval]=TORTArtSensAnalysis(100,segs,0.005,0.001,clinsort_a,fsort,namesort,legenda,dbf);
%%
%% Vein
%% [corrval,tval]=TORTArtSensAnalysis(100,segs,0.005,0.001,clinsort_a,fsort ,namesort,legenda,dbf);

function [corrval,tval]=TORTArtSensAnalysis(nrep,segs,h,smoothxy,clinsort,fsort,namesort,legenda,dbf);

tortpar.h=h;                    % hysteresis threshold: arterie=0.03
tortpar.passo=0.1;                 % resampling step (the smaller is better (era 0.5))
tortpar.lmin=1;
tortpar.k0=10;

%smoothxy=0.01;
%     load(dataname);
%     fname=fn{1};
%     n=findstr(fname,'-');
%     if(~isempty(n))
%         for ctn=1:30,
%             fname=fn{ctn};
%             n=findstr(fname,'-');
%             fstr{ctn}=fname(n+1:end-4);
%         end;
%     else
%         for ctn=1:30,
%             fname=fn{ctn};
%             n=findstr(fname,'_');
%             fstr{ctn}=fname(1:n-1);
%         end;
%     end;
%
%
%     [fsort,namesort]=sort(fstr);


for ctrep=1:nrep
    disp(sprintf('Rep %i',ctrep));
    for ctseg=1:length(fsort),
        segm=segs(namesort(ctseg));
        rx=4*rand([1,length(segm.x)])-2;
        ry=4*rand([1,length(segm.x)])-2;
        segm.x=segm.x+rx;
        segm.y=segm.y+ry;
        segm=TORTspline(segm,smoothxy,dbf);

        [tort,x,y,k,indici]=TORTsegind(segm.ppx,segm.ppy,tortpar,dbf);
        [tval(ctseg,:),indici]=TORTind(x,y,k,tortpar.lmin,tortpar.h,tortpar.k0,tortpar.passo,dbf);
        %[s,chord,tc,tsc,ad,nc]=TORTothers(segm,dbf);
        %t=TORTsegind(segm.ppx,segm.ppy,tortpar,dbf);
        %tindexes=TORTindex(s,chord,tc,tsc,t,dbf);
        %[tpat] = TORTpatasius(segm.ppx,segm.ppy,tortpar,dbf);
        %[tbull] = TORTbullit(segm.ppx,segm.ppy,tortpar,dbf);
        
        %tindexes=[tindexes,ad,nc, tbull, tpat];
        %tval(ctseg,:)=tindexes;
    end;

    for ct=1:size(tval,2)
        temp=tval(:,ct);
        [tempsort,tortidx]=sort(temp);
        %cmat=corrcoef(sort(clinsort),clinsort(tortidx));
        %c(ct)=cmat(1,2);
        corrval(ctrep,ct)=corr(sort(clinsort)',clinsort(tortidx)','type','Spearman');
    end;
%     for ctc=1:size(tval,2)
%         temp=tval(:,ctc);
%         [tempsort,tortidx]=sort(temp);
%         cmat=corrcoef(sort(clinsort),clinsort(tortidx));
%         corrval(ctrep,ctc)=cmat(1,2);
%     end;
    disp(sprintf('Tort Corr %f',corrval(ctrep,1)));
end;

if (dbf)
    for ct=1:12
        subplot(4,3,ct);
        hist(corrval(:,ct));
        axis([0,0.98,0,30]);
        hold on;
        h=plot(ones(1,2)*median(corrval(:,1)),[0,30],'r');
        set(h,'LineWidth',2);
        h=plot(ones(1,2)*median(corrval(:,ct)),[0,30],'g');
        set(h,'LineWidth',2);
        title(legenda{ct});
    end;
end;
% for ct=1:10,
%     subplot(5,2,ct);
%     hist(corrval(:,ct));
%     axis([0.5,1,0,30]);
% end;