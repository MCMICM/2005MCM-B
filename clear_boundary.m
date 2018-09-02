function [plaza, v, time, nout, tout] = clear_boundary(plaza, v, time)
%
% clear_boundary  remove the cars of the exit cell
%
% USAGE: [plaza, v, time, ndept, tdept] = clear_boundary(plaza, v, time)
%        plaza = plaza matrix
%                1 = car, 0 = empty, -1 = forbid, -3 = empty&booth
%        v = velocity matrix
%        time = time matrix, to trace the time that the car cost to pass 
%               the plaza.
%        nout = departures count
%        tout = departures time
%
% zhou lvwen: zhou.lv.wen@gmail.com

[L,W] = size(plaza);
ind = find(plaza==1);
[row, col] = ind2sub([L,W], ind);

% Find out cars that their velocity >= their distance to the exit 
k = find(v(ind)>=L-row);
nout = length(k);

tout = time(ind(k));
plaza(ind(k)) = 0;
