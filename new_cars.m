function [plaza, v, ncars] = new_cars(arrate, dt, plaza, v, vmax)
%
% new_cars   introduce new cars. Cars arrive at the toll plaza uniformly in
% time (the interarrival distribution is exponential with rate Arrival?). 
% "rush hour" phenomena can be consider by varying the arrival rate.
%
% USAGE: [plaza, v, number_cars] = new_cars(Arrival, dt, plaza, v, vmax)
%        arrate = the mean total number of cars that arrives 
%        dt = time step
%        plaza = plaza matrix
%                1 = car, 0 = empty, -1 = forbid, -3 = empty & booth
%        v = velocity matrix
%        vmax = max speed of car
%
% zhou lvwen: zhou.lv.wen@gmail.com

% Find the empty lanes of the entrance where a new car can be add.
unoccupied = find(plaza(1,:) == 0);
n = length(unoccupied); % number of available lanes
% The number of vehicles must be integer and not exceeding the number of
% available lanes
ncars = min( poissrnd(arrate*dt,1), n);
if ncars > 0
    x = randperm(n, ncars);
    plaza(1, unoccupied(x)) = 1;
    v(1, unoccupied(x)) = vmax;
end
