%% lab09_task03_vary_d.m
% Plots the result of varying the derivative term.
% By      : Leomar Duran
% When    : 2023-04-21t22:26Q
% For     : ECE 3413 Classical Control Systems
%

% get the default values
clear
lab09_task00_initial_dc_motor_motor_params;

% initialize figures
vsTime = figure;
vsInput = figure;

% simulate the input signal
shouldPidBeOn = false
simin = sim('lab08_openloop_control_slx', StopTime)

% enable PID again
shouldPidBeOn = true

% initialize proportional term
P = 10
% initialize integral term
I = 1

% set up the derivative term
derivative_terms = 10.^(0:2)

% for each proportional term
for D=derivative_terms
    % run the simulation
    simout = sim('lab08_openloop_control_slx', StopTime)
    % plot the resulting time series
    figure(vsTime)
    hold on
    plot(simout.simout)
    hold off
    % plot against input
    figure(vsInput)
    hold on
    plot(simin.simout.Data, simout.simout.Data)
    hold off
end % next D

PID_format = (@(x) sprintf("P = %.4e, I = %.4e, D=%.4e", P, I, x));

% common labels
pidFormat = @(x) sprintf("D=%.4e", x);
figsLegend = arrayfun(pidFormat, derivative_terms);
figsTitleFormat = sprintf( ...
    ['PID control of angular velocity response with P=%.0f, I=%.0f, ' ...
        'vs %%s'], ...
    P, I);
figsYlabel = 'angular velocity response [rad/s]';

% label against input
figure(vsInput)
legend(figsLegend)
title(sprintf(figsTitleFormat, 'input signal'))
xlabel('input signal [rad/s]')
ylabel(figsYlabel)

% label against time
figure(vsTime)
legend(figsLegend)
title(sprintf(figsTitleFormat, 'time'))
xlabel('time [s]')
ylabel(figsYlabel)
