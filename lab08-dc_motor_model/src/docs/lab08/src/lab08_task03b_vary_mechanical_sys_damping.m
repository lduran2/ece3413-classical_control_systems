%% lab08_task03b_vary_mechanical_sys_damping.m
% Plots the result of varying the gains : armature torque constant and
% back EMF.
% By      : Leomar Duran
% When    : 2023-04-12t22:03Q
% For     : ECE 3413 Classical Control Systems
%

% get the default values
clear
lab08_task00_default_dc_motor_motor_params;

mechanical_sys_damping = [0.01 0.1 0.2]
% for each moment of inertia
for b=mechanical_sys_damping
    % run the simulation
    simout = sim('lab08_openloop_control_slx', StopTime)
    % plot the resulting time series
    hold on
    plot(simout.simout)
    hold off
end % next b
legend(arrayfun((@(x) sprintf("b=%.4e", x)), mechanical_sys_damping))
title("angular velocity response, varying the mechanical system's damping ratio")
xlabel('time [s]')
ylabel('angular velocity response [rad/s]')