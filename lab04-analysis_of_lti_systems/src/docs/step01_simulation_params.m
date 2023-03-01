%% step01_simulation_params.m
% Sets the parameters for simulating a second order transfer function.
% By      : Leomar Duran
% When    : 2023-03-28t18:53
% For     : ECE 3413 Classical Control Systems
%

clear

% simulation parameters
TSTOP = 10.0    % [s]

% step function parameters
Tstep = 0       % [s]
stepFinal = 1   % [V]

% transfer function parameters
B = 2;
A = [1 5 9];
G = tf(B, A)
% indices expected in reverse order and normalized to A(1)
b = B(end:-1:1)/A(1)
% A(1) is thus unneeded
a = A(end:-1:2)/A(1)
