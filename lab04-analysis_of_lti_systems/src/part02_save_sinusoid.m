function part02_save_sinusoid()
%% part02_save_sinusoid.m
% Creates and saves a sinusoidal function for simulation
% By      : Leomar Duran
% When    : 2023-03-28t19:07
% For     : ECE 3413 Classical Control Systems
%
    t = linspace(0,10,1000)
    y = 0.5*cos(t) - 0.3
    y_ts = timeseries(y, t)

    save input.mat -v7.3 y_ts
end % function part02_save_sinusoid()
