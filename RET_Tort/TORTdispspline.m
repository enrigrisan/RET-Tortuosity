%	--------------------------
%	-Function RETview-
%	--------------------------
%
% Visualize spline approximation of tracked barycenter 
%
% 
% Sintax:
%	
% ret_view(structure SEG,image_name, debug flag)
%

function RETdispspline(xroi,seg)

passo=.1;

dim_struttura  = length(seg);

sims(xroi);
hold on;

for cont = 1:dim_struttura,
    
    x = fnval(seg(cont).ppx,[seg(cont).ppx.breaks(1):passo:seg(cont).ppx.breaks(length(seg(cont).ppx.breaks))]);
    y = fnval(seg(cont).ppy,[seg(cont).ppy.breaks(1):passo:seg(cont).ppy.breaks(length(seg(cont).ppy.breaks))]);
    plot(x, y, 'g');
        
end;

set(gca,'Ydir','reverse');



