%% simulation_analysis.m
% Sets the paraeters for a second order transfer function, then uses step
% analysis to characterize the system.
% By      : Leomar Duran
% When    : 2023-03-27t23:23
% For     : ECE 3413 Classical Control Systems
% Version : 0.0.1
%

% transfer function parameters
B = 2
A = [1 5 9]
SENTINEL = "yes";

% wait for simulation data
while (SENTINEL ~= input(sprintf( ...
        'Please type "%s" after simulation.\n> ', SENTINEL ...
        ), 's'))
end % while
