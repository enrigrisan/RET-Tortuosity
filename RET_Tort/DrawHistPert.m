stitle{1}='\tau';
stitle{2}='L_c/L_\chi';
stitle{3}='tc';
stitle{4}='tsc';
stitle{5}='tc/L_c';
stitle{6}='tsc/L_c';
stitle{7}='tc/L_\chi';
stitle{8}='tsc/L_chi';
stitle{9}='ad';
stitle{10}='nt';
mco=median(corrval(:,1));
for ct=1:10,
    figure;
    hist(corrval(:,ct));
    hold on;
    h=plot(ones(1,2)*mco,[0,nrep/3],'r--');
    set(h,'LineWidth',2);
    if(ct>1)
        h=plot(ones(1,2)*median(corrval(:,ct)),[0,nrep/3],'g');
        set(h,'LineWidth',2);
    end;
    axis([0.4,0.95,0,nrep/3]);
    xlabel('Spearman Correlation')
    title(stitle{ct});
    print(gcf,'-deps',sprintf('%s%i','PertVei2_',ct));
end;