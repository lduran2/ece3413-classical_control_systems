%% lab09_task01_vary_p.m
% Plots the result of proportional term.
% By      : Leomar Duran
% When    : 2023-04-21t20:12Q
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

% reset integral and derivative
I = 0, D = I

proportional_terms = 10.^(0:3)
% for each proportional term
for P=proportional_terms
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
end % next P

% common labels
figsLegend = arrayfun((@(x) sprintf("P=%.4e", x)), proportional_terms);
figsTitleFormat = 'proportional control of angular velocity response vs %s';
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
