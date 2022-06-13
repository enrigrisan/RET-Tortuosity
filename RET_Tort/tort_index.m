function [T, T1, T2 ,T3 ,T4 ,T5 ,T6 ,T7]=TORTindex(s,chord,tc,tsc,T,dbf)
% 
%   s     : arc length
%   chord : chord length
%   tc    : total curvature
%   tsc   : total squared curvature
%
%   calcolo dei diversi indici di tortuosità:
%   T  
%   T1 = s / chord - 1
%   T2 = tc
%   T3 = tsc
%   T4 = tc / s
%   T5 = tsc / s
%   T6 = tc / chord
%   T7 = tsc / chord
%
T1=s/chord-1;
T2=tc;
T3=tsc;
T4=tc/s;
T5=tsc/s;
T6=tc/chord;
T7=tsc/chord;
TT=[T T1 T2 T3 T4 T5 T6 T7];

if dbf==1
    disp(sprintf('T  = (n-1)/s*sum(si/chordi-1)= %f',T));
    disp(sprintf('T1 = s/chord-1 = %f',T1));
    disp(sprintf('T2 = tc = %f',T2));
    disp(sprintf('T3 = tsc = %f',T3));
    disp(sprintf('T4 = tc/s = %f',T4));
    disp(sprintf('T5 = tsc/s = %f',T5));
    disp(sprintf('T6 = tc/chord = %f',T6));
    disp(sprintf('T7 = tsc/chord = %f',T7));
end