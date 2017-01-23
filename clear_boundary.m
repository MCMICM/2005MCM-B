function [plaza, v, time, ndept, tdept] = clear_boundary(plaza, v, time)
%
% clear_boundary  remove the cars of the exit cell
%
% USAGE: [plaza, v, time, ndept, tdept] = clear_boundary(plaza, v, time)
%        plaza = plaza matrix
%                1 = car, 0 = empty, -1 = forbid, -3 = empty&booth
%        v = velocity matrix
%        time = time matrix, to trace the time that the car cost to pass 
%               the plaza.
%        ndept = departures count
%        tdept = departures time
%
% zhou lvwen: zhou.lv.wen@gmail.com

dept = plaza(end, :)>0;

ndept = sum(dept);
tdept = time(end, dept);

plaza(end, dept) = 0;
v(end, dept) = 0;
time(end, dept) = 0;
