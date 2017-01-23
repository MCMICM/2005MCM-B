% main.m
%
% This is a main script to simulate the approach, service, and departure of 
% vehicles passing through a toll plaza, , as governed by the parameters 
% defined below
%
%   iterations   =  the maximal iterations of simulation
%   B            =  number booths
%   L            =  number lanes in highway before and after plaza
%   arrate       =  the mean total number of cars that arrives 
%   plazalen     =  length of the plaza
%   srvrate      =  Service rate of booth
%   plaza        =  plaza matrix
%                   1 = car, 0 = empty, -1 = forbid, -3 = empty&booth
%   v            =  velocity matrix
%   vmax         =  max speed of car
%   time         =  time matrix, to trace the time that the car cost to
%                   pass the plaza.
%   dt           =  time step
%   ndept        =  number of cars that departure the plaza in the step
%   tdept        =  time cost of the departure cars
%   influx       =  influx vector
%   outflux      =  outflux vector
%   timecost     =  time cost of all car
%   h            =  handle of the graphics
%   
% zhou lvwen: zhou.lv.wen@gmail.com
% July 30, 2009
% January 24, 2017: revised


clear;clc
iterations = 5000; % the maximal iterations of simulation
B = 12;     % number booths
L = 6;      % number lanes in highway before and after plaza
arrate = 4; % the mean total number of cars that arrives 

plazalen = 101; % length of the plaza
[plaza, v, time] = create_plaza(B, L, plazalen);
h = show_plaza(plaza, NaN, 0.01);

srvrate = 0.8; % Service rate
dt = 0.2; % time step
vmax = 5; % max speed

timecost = [];
for i = 1:iterations
    % introduce new cars
    [plaza, v, ncars] = new_cars(arrate, dt, plaza, v, vmax);
    
    h = show_plaza(plaza, h, 0.1);

    % update rules for lanes: lane changes & move forward
    [plaza, v, time] = switch_lanes(plaza, v, time); 
    [plaza, v, time] = move_forward(plaza, v, time, vmax, srvrate); 
    [plaza, v, time, ndept, tdept] = clear_boundary(plaza, v, time);
    
    % flux calculations
    influx(i) = ncars;
    outflux(i) = ndept;
    timecost = [timecost, tdept];
end

h = show_plaza(plaza, h, 0.01);
xlabel({strcat('B = ',num2str(B)), ...
strcat('mean cost time = ', num2str(round(mean(timecost))))})
