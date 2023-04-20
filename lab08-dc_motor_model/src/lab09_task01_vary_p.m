%% lab09_task01_vary_p.m
% Plots the result of proportional term.
% By      : Leomar Duran
% When    : 2023-04-19t21:47Q
% For     : ECE 3413 Classical Control Systems
%

% get the default values
clear
lab09_task00_initial_dc_motor_motor_params;

% reset integral and derivative
I = 0, D = I

proportional_terms = 10.^(0:3)
% for each proportional term
for P=proportional_terms
    % run the simulation
    simout = sim('lab08_openloop_control_slx', StopTime)
    % plot the resulting time series
    hold on
    plot(simout.simout)
    hold off
end % next K
legend(arrayfun((@(x) sprintf("P=%.4e", x)), proportional_terms))
title('PID control of angular velocity response, varying proportional term')
xlabel('time [s]')
ylabel('angular velocity response [rad/s]')
