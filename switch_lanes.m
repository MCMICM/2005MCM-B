function [plaza, v, time] =  switch_lanes(plaza, v, time)
%
% switch_lanes  Merge to avoid obstacles.
%  
% The vehicle will attempt to merge if its forward path is obstructed. The 
% vehicle then randomly chooses an intended direction, right or left. If
% that intended direction is blocked, the car will move in the other 
% direction unless both directions are blocked (the car is surrounded). 
% 
% USAGE: [plaza, v, time] =  switch_lanes(plaza, v, time)
%        plaza = plaza matrix
%                1 = car, 0 = empty, -1 = forbid, -3 = empty&booth
%        v     = velocity matrix
%        time  = time matrix, to trace the time that the car cost to pass 
%               the plaza.
%
% zhou lvwen: zhou.lv.wen@gmail.com

booth_row = ceil( size(plaza, 1)/2 );
[row, col] = find(plaza==1);

for k = randperm(length(row))
    i = row(k); j = col(k);
    if plaza(i+1,j)==0 | j==booth_row; continue; end
    
    dj = randsample([-1,1], 1);
    
    if plaza(i,j+dj)==0 & plaza(i+1,j+dj)==0
        [plaza, v, time] = move(plaza, v, time, i, j, 0, +dj);
    elseif plaza(i,j-dj)==0 & plaza(i+1,j-dj)==0
        [plaza, v, time] = move(plaza, v, time, i, j, 0, -dj);
    end
end

% -------------------------------------------------------------------------

function [plaza, v, time] = move(plaza, v, time, i, j, di, dj)
% move vehicle from (i,j) to (i+di,j+dj)
plaza(i+di,j+dj) =         1;          plaza(i,j) = 0;
v(i+di,j+dj)     =    v(i,j);          v(i,j)     = 0;
time(i+di,j+dj)  = time(i,j);          time(i,j)  = 0;
