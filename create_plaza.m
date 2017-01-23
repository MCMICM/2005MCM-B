function [plaza, v, time] = create_plaza(B, L, plazalen)
%
% create_plaza    create the empty plaza matrix( no car ). 
%                 1 = car, 0 = empty, -1 = forbid, -3 = empty & booth
%
% USAGE: [plaza, v, time] = create_plaza(B, L, plazalength)
%        B = number booths
%        L = number lanes in highway before and after plaza
%        plazalen = length of the plaza
%
% zhou lvwen: zhou.lv.wen@gmail.com


plaza = zeros(plazalen, B+2);
v = zeros(plazalen, B+2);    % velocity of automata (i,j), if it exists
time = zeros(plazalen, B+2); % cost time of automata (i,j) if it exists

plaza(1:plazalen, [1,2+B]) = -1;
plaza(ceil(plazalen/2),[2:1+B]) = -3;
%left: angle of width decline for boundaries
top = 1.3;  btm = 1.2;

for col = 2:ceil(B/2-L/2) + 1
    for row = 1:(plazalen-1)/2 - floor(tan(top) * (col-1))
        plaza(row, col) = -1;
    end
    for row = 1:(plazalen-1)/2 - floor(tan(btm) * (col-1))
        plaza(plazalen+1-row, col) = -1;
    end
end

fac = ceil(B/2-L/2)/floor(B/2-L/2);
%right: angle of width decline for boundaries
top = atan(fac*tan(top));
btm = atan(fac*tan(btm));

for col = 2:floor(B/2-L/2) + 1
    for row = 1:(plazalen-1)/2 - floor(tan(top) * (col-1))
        plaza(row,B+3-col) = -1;
    end
    for row = 1:(plazalen-1)/2 - floor(tan(btm) * (col-1))
        plaza(plazalen+1-row,B+3-col) = -1;
    end
end
