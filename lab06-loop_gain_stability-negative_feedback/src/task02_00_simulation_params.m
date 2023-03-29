%% task02_00_simulation_params.m
% Sets the parameters for symbolically modelling a negative feedback
% system.
% By      : Leomar Duran
% When    : 2023-03-29t01:38
% For     : ECE 3413 Classical Control Systems
%

clear

% basic symbols:
% complex frequency, gain
syms s K

%plant
G_s = K/(s*(s + 2)^2)

%controller
H_s = 1
