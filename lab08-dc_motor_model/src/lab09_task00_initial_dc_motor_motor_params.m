%% lab09_task00_initial_dc_motor_motor_params.m
% Sets the initial parameters for the DC motor model for analysis of
% PID control.
% By      : Leomar Duran
% When    : 2023-04-19t21:30Q
% For     : ECE 3413 Classical Control Systems
%

clear

% simulation runtime [s]
StopTime = 10.0

% moment of inertia of rotor [kg m^2]
J = 0.01
% damping ratio of mechanical system [N m*s]
b = 0.006
% armature torque gain [N m/A]
Kt = 0.01
% back EMF from motor [V s]
Ke = Kt
% voltage drop across the armature-resistance [ohm]
R = 1
% inductance [H]
L = 0.5
