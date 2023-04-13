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

K_values = [0.01 0.02 0.3 0.4 1 2]
% for each K value
for K=K_values
    % setting the armature torque constant, back EMF accordingly
    Kt = K
    Ke = K
    % run the simulation
    simout = sim('lab08_openloop_control_slx', StopTime)
    % plot the resulting time series
    hold on
    plot(simout.simout)
    hold off
end % next K
legend(arrayfun((@(x) sprintf("K=%.4e", x)), K_values))
title('angular velocity response, varying the gains')
xlabel('time [s]')
ylabel('angular velocity response [rad/s]')