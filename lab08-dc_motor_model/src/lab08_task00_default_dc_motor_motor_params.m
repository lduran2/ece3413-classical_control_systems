%% lab08_task00_default_dc_motor_motor_params.m
% Sets the default parameters for the DC motor model.
% By      : Leomar Duran
% When    : 2023-04-12t10:42Q
% For     : ECE 3413 Classical Control Systems
%

clear

% moment of inertia of rotor [kg m^2]
J = 0.01
% damping ratio of mechanical system [N m*s]
b = 0.1
% armature torque gain [N m/A]
Kt = 0.01
% back EMF from motor [V s]
Ke = Kt
% voltage drop across the armature-resistance [ohm]
R = 1
% inductance [H]
L = 0.5