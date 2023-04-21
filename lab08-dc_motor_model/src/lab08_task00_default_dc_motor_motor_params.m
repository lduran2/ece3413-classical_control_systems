%% lab08_task00_default_dc_motor_motor_params.m
% Sets the default parameters for the DC motor model.
% By      : Leomar Duran
% Version : v2.0.0
% For     : ECE 3413 Classical Control Systems
%
% CHANGELOG:
%       v2.0.0 - 2023-04-21t19:12Q
%           added support for PID controllers, sampling frequency for
%           lab 09
% 
%       v1.0.0 - 2023-04-12t10:42Q
%           complete parameters for lab 08
% 

clear

% simulation runtime (start) [s]
StartTime = 0.0
% simulation runtime (finish) [s]
StopTime = 10.0

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

% disable PID
shouldPidBeOn = false
% reset all other PID parameters (don't care since PID is disabled)
P = 0;
I = 0;
D = 0;

% sampling frequency [Hz]
Fs = 0.001
