function [plaza, v, time] = create_plaza(B, N, L)
%
% create_plaza    create the empty plaza matrix( no car ). 
%                 1 = car, 0 = empty, -1 = forbid, -3 = empty & booth
%
% USAGE: [plaza, v, time] = create_plaza(B, L, plazalength)
%        B = number booths
%        N = number lanes in highway before and after plaza
%        L = length of the plaza
%
% zhou lvwen: zhou.lv.wen@gmail.com

if nargin==0; B = 8; N = 4; L = 29; end

W = B + 2; booth_row = ceil(L/2);

% v, time: velocity and cost time of automata (i,j), if it exists
[plaza, v, time] = deal( zeros(L,W) );
plaza(:, [1,end]) = -1;
plaza(booth_row, 2:W-1) = -3;

nf = @(deg,col) 1 : (booth_row-1)-floor(tan(deg) * (col-1));

%left: angle of width decline for boundaries
top = 1.3;  btm = 1.2;
for col = 2:ceil(B/2-N/2) + 1
    plaza([nf(top,col), L+1-nf(btm,col)], col) = -1;
end

fac = ceil(B/2-N/2)/floor(B/2-N/2);
%right: angle of width decline for boundaries
top = atan(fac*tan(top)); btm = atan(fac*tan(btm));
for col = 2:floor(B/2-N/2) + 1
    plaza([nf(top,col), L+1-nf(btm,col)], W+1-col) = -1;
end

if nargin==0; show_plaza(plaza, NaN, 0); end
