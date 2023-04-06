%% lab07_task01_error_analysis.m
% Performs error analysis on the negative feedback systems given by the
% transfer functions.
% By      : Leomar Duran
% When    : 2023-04-05t21:34
% For     : ECE 3413 Classical Control Systems
%

clear

% gains
syms k real
% input
syms s

% systems
% forward branch
G_s = (k*(s + 6)/poly2sym(poly(-[4 7 9 12]), s)) * ...
    [
        1, ...
        (s + 8) * [1, (s + 1)]
    ]'
% backward branch
H_s = ones(size(G_s))

% equivalent transfer function
G_CL_s = ((G_s.*H_s).^-1 + 1).^-1

% calculate the static error constants
derivativeNo = (0:2)'
staticErrorConstants = limit(s.^(derivativeNo)*G_s', s, 0)