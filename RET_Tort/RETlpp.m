%	--------------------------------------------
%	- Function length of spline-approximated vessel segment for the whole network- 
%	--------------------------------------------
%
% Update seg-structure adding for every segment the length field L
%
% Sintax :
%
%	SEG = RETlpp(SEG,passo,flag debug)
%
%

function seg_out=RETlpp(seg_in,passo,dbf)

if dbf, disp('Inside RETlpp'); end;


num_segmenti=length(seg_in);

seg_out=seg_in;

for ct=1:num_segmenti,
    seg_out(ct).l=RETlpp_seg(seg_in(ct).ppx,seg_in(ct).ppy,passo,dbf);
end;


if dbf, disp('Finished RETlpp'); end;
