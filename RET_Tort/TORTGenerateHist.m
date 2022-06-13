for ct=1:12
    hist(corrval(:,ct));
    h(1) = findobj(gca,'Type','patch');
    set(h(1),'FaceColor',[0.6 0.6 0.6],'EdgeColor','k')
    axis([0.3,1,0,30]);
    hold on;
    h(2)=plot(ones(1,2)*mean(corrval(:,1)),[0,30],'--k');
    set(h(2),'LineWidth',3);
    h(3)=plot(ones(1,2)*mean(corrval(:,ct)),[0,30],'k');
    set(h(3),'LineWidth',3);
    h(4)=xlabel('Spearman Correlation');
    set(h(4),'FontSize',20);
    set(gca,'FontSize',20);

    %hf=gcf;
    %units=get(hf,'units');
    %set(hf,'units','normalized','Position',[0 0 1 1]);
    %set(hf,'units',units);
    %orient landscape
    s=sprintf('PertArt2_%i.eps',ct);
    print('-deps',s);
    close
end;