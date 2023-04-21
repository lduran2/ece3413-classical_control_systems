%% lab09_task03_vary_d.m
% Plots the result of varying the derivative term.
% By      : Leomar Duran
% When    : 2023-04-19t22:22Q
% For     : ECE 3413 Classical Control Systems
%

% get the default values
clear
lab09_task00_initial_dc_motor_motor_params;

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
    hold on
    plot(simout.simout)
    hold off
end % next D
PID_format = (@(x) sprintf("P = %.4e, I = %.4e, D=%.4e", P, I, x));
legend(arrayfun(PID_format, derivative_terms))
title('PID control of angular velocity response, varying PID terms')
xlabel('time [s]')
ylabel('angular velocity response [rad/s]')

