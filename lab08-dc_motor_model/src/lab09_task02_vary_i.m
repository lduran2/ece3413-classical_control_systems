%% lab09_task02_vary_i.m
% Plots the result of varying the integral term.
% By      : Leomar Duran
% When    : 2023-04-19t22:22Q
% For     : ECE 3413 Classical Control Systems
%

% get the default values
clear
lab09_task00_initial_dc_motor_motor_params;

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
    hold on
    plot(simout.simout)
    hold off
end % next PI_Idx
legend(table2array(rowfun((@(I, P) sprintf("P=%.4e, I=%.4e", P, I)), PI)))
title('PID control of angular velocity response, varying PI terms')
xlabel('time [s]')
ylabel('angular velocity response [rad/s]')

