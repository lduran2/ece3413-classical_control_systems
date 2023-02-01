%% lab01-intro/part02_transfer_function_params.m
% Parameters for exploring the effects of transfer functions on a step
% signal.
% By      : Leomar Duran <https://github.com/lduran2>
% When    : 2023-02-01t07:28
% For     : ECE 3412 Classical Control Systems
% Version : 0.1.0

clear

% H(s) = (ss + 10s + 24)/(s^4 + 26s^3 + 231ss + 766s + 560)
Hpoly = [0 0 1 10 24 ; 1 26 231 766 560];
H = tf(Hpoly(1,:), Hpoly(2,:))

% find the poles and zeros
H_poles = pole(H)
H_zeros = zero(H)

% parameters of step input
step_init = 1;
step_final = 2;
