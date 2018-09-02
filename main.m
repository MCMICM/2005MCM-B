% main.m
%
% This is a main script to simulate the approach, service, and departure of 
% vehicles passing through a toll plaza, , as governed by the parameters 
% defined below
%
%   tmax         =  the maximal iterations of simulation
%   B            =  number booths
%   N            =  number lanes in highway before and after plaza
%   arrate       =  the mean total number of cars that arrives 
%   L            =  length of the plaza
%   W            =  B+2, width of the plaza
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
%   flux         =  influx and outflux
%   cost         =  time cost of all car
%   h            =  handle of the graphics
%   
% zhou lvwen: zhou.lv.wen@gmail.com
% July 30, 2009
% Septemer 1, 2018: revised

clear;clc
tmax = 5000;     % the maximal iterations of simulation
B = 16;          % number booths
N = 8;           % number lanes in highway before and after plaza
arrate = 4;      % the mean total number of cars that arrives 
srvrate = 0.8;   % Service rate per booth
dt = 0.2;        % time step
vmax = 5;        % max speed
L = 101;         % length of the plaza

[plaza, v, time] = create_plaza(B, N, L);
h = show_plaza(plaza, NaN, 0.01);

cost = []; flux = zeros(tmax, 2);
for i = 1:tmax
    % introduce new cars
    [plaza, v, nin] = new_cars(arrate, dt, plaza, v, vmax);
    
    % plot plaza
    h = show_plaza(plaza, h, 0);

    % boundary condition
    [plaza, v, time, nout, tout] = clear_boundary(plaza, v, time);
    
    % update rules for lanes: lane changes & move forward
    [plaza, v, time] = switch_lanes(plaza, v, time); 
    [plaza, v, time] = move_forward(plaza, v, time, vmax, srvrate); 
    
    % flux calculations
    flux(i,:) = [nin, nout]; % [influx, outflux]
    cost = [cost; tout];
end

h = show_plaza(plaza, h, 0.01);
xlabel(['mean cost time = ', num2str(round(mean(cost)))])
