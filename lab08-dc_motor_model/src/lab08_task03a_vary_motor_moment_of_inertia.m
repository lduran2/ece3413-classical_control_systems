%% lab08_task01_vary_gain.m
% Plots the result of varying the gains : armature torque constant and
% back EMF.
% By      : Leomar Duran
% When    : 2023-04-12t21:50Q
% For     : ECE 3413 Classical Control Systems
%

% get the default values
clear
lab08_task00_default_dc_motor_motor_params;

moments_of_inertia = [0.1 1 5]
% for each moment of inertia
for J=moments_of_inertia
    % run the simulation
    simout = sim('lab08_openloop_control_slx', StopTime)
    % plot the resulting time series
    hold on
    plot(simout.simout)
    hold off
end % next J
legend(arrayfun((@(x) sprintf("J=%.4e", x)), moments_of_inertia))
title('angular velocity response, varying the moment of inertia')
xlabel('time [s]')
ylabel('angular velocity response [rad/s]')