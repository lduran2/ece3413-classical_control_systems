%% lab01-intro/part02_transfer_function_params.m
% Parameters for exploring the effects of transfer functions on a step
% signal.

% H(s) = (ss + 10s + 24)/(s^4 + 26s^3 + 231ss + 766s + 560)
Hpoly = [0 0 1 10 24 ; 1 26 231 766 560]
H = tf(Hpoly(1,:), Hpoly(2,:))