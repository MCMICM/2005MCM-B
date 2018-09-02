function [plaza, v, nin] = new_cars(arrate, dt, plaza, v, vmax)
%
% new_cars   introduce new cars. Cars arrive at the toll plaza uniformly in
% time (the interarrival distribution is exponential with rate Arrival?). 
% "rush hour" phenomena can be consider by varying the arrival rate.
%
% USAGE: [plaza, v, nins] = new_cars(arrate, dt, plaza, v, vmax)
%        arrate = the mean total number of cars that arrives 
%        dt = time step
%        plaza = plaza matrix
%                1 = car, 0 = empty, -1 = forbid, -3 = empty & booth
%        v = velocity matrix
%        vmax = max speed of car
%        nin  = Number of cars entering
%
% zhou lvwen: zhou.lv.wen@gmail.com

if nargin==0 
    arrate = 10; dt = 0.2; vmax = 5; [plaza, v] = create_plaza(8, 4, 29);
end

% Find the empty lanes of the entrance where a new car can be add.
unoccupied = find(plaza(1,:) == 0);
n = length(unoccupied); % number of available lanes
% The number of vehicles must be integer and not exceeding the number of
% available lanes
nin = min( poissrnd(arrate*dt,1), n);
x = randperm(n, nin);
plaza(1, unoccupied(x)) = 1;
v(1, unoccupied(x)) = vmax;

if nargin==0; show_plaza(plaza, NaN, 0); end
