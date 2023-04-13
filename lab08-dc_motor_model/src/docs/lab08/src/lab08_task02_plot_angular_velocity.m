%% lab08_task02_plot_angular_velocity.m
% Plots the angular velocity from the default parameters.
% By      : Leomar Duran
% When    : 2023-04-12t21:58Q
% For     : ECE 3413 Classical Control Systems
%

% get the default values
clear
lab08_task00_default_dc_motor_motor_params;

% run the simulation
simout = sim('lab08_openloop_control_slx', StopTime)
% plot the resulting time series
plot(simout.simout)
title('angular velocity vs time')
xlabel('time [s]')
ylabel('angular velocity response [rad/s]')