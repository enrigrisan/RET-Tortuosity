function [xz,yz,index]=TORTreg(x,y,k,h,dbf)

statevec=(k>h)-(k<-h);

brkpoints=[];
prevstate=0;
prevcase=0;
zerostart=1;
zeroend=2;
ct2=0;

if(dbf)
    figure
    plot(statevec);
end;

temp=statevec;
for ct=1:length(statevec),
    switch(statevec(ct))
        case 1,
            if (prevstate==1)
                statevec(zerostart:zeroend)=1;
            else
                statevec(zerostart:fix(0.5*(zeroend+zerostart)))=-1;
                statevec(fix(0.5*(zeroend+zerostart)):zeroend)=1;
                zerostart=ct;
                zeroend=ct;
                ct2=ct2+1;
                brkpoints(ct2)=fix(0.5*(zeroend+zerostart));
            end;
            prevstate=1;
            prevcase=1;
        case 0,
            if(prevcase==0)
                zeroend=ct;
            else
                zerostart=ct;
                zeroend=ct;
                prevcase=0;
            end;
            %pause
        case -1,
            if (prevstate==-1)
                statevec(zerostart:zeroend)=-1;
            else
                statevec(zerostart:fix(0.5*(zeroend+zerostart)))=1;
                statevec(fix(0.5*(zeroend+zerostart)):zeroend)=-1;
                zerostart=ct;
                zeroend=ct;
                ct2=ct2+1;
                brkpoints(ct2)=fix(0.5*(zeroend+zerostart));
                %disp([zerostart, zeroend, fix(0.5*(zeroend+zerostart))])
            end;
            prevstate=-1;
            prevcase=1;
    end;

    if(dbf)
        hold off
        plot(temp,'b');
        hold on
        plot(ct,statevec(ct),'ok');
        plot(statevec,'r');
        disp([prevstate, prevcase,zerostart,zeroend])
        drawnow
    end
end;

index=[1,brkpoints,length(k)];
xz=x(index);
yz=y(index);
