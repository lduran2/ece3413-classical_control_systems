%% lab01-intro/part02_01_transfer_function_params.m
% Parameters for exploring the effects of transfer functions on a step
% signal.
% By      : Leomar Duran <https://github.com/lduran2>
% When    : 2023-02-01t07:28
% For     : ECE 3412 Classical Control Systems
% Version : 0.1.0

clear

% H(s) = (ss + 10s + 24)/(s^4 + 26s^3 + 231ss + 766s + 560)
Hpoly = [0 0 1 10 24 ; 1 26 231 766 560]; % [V^0]
H = tf(Hpoly(1,:), Hpoly(2,:))

% find the poles and zeros
H_poles = pole(H)
H_zeros = zero(H)

% parameters of step input
step_init = 1;  % [V]
step_final = 2; % [V]
step_time = 1;  % [s]

% copy size of Ipoly
Ipoly = zeros(size(Hpoly));
% find and negate the minimum magnitude pole
[~, i_negate] = min(abs(H_poles))
I_poles = H_poles;
I_poles(i_negate) = -I_poles(i_negate)
% copy Hpoly's numerator, but use new poles
Ipoly = [ Hpoly(1,:) ; poly(I_poles) ]
