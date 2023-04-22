%% lab09_task02_vary_i.m
% Plots the result of varying the integral term.
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

% reset derivative term
D = 0

% set up the proportional and integral terms
PI = table();
PI.I = [0.1, 0.5, 1 1]';
PI.P = [100 100 100 10]';
PI

% for each proportional term
for PI_Idx=1:height(PI)
    P = PI(PI_Idx,:).P;
    I = PI(PI_Idx,:).I;
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
end % next PI_Idx

% common labels
piFormat = @(I, P) sprintf("P=%.4e, I=%.4e", P, I);
figsLegend = table2array(rowfun(piFormat, PI));
figsTitleFormat = 'PI control of angular velocity response vs %s';
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
