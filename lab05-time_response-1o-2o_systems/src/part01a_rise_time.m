%% part01a_rise_time.m
% Calculates the rise time Tr given the following transfer function
% denominator linear coefficient, a, and sinusoidal frequency, w.
% By      : Leomar Duran
% When    : 2023-03-07t23:21
% For     : ECE 3413 Classical Control Systems
%

clear

% Given the transfer function
%       G2(s) = ((a/2)^2 + w^2)/((s + a/2)^2 + w^2)
% s.t.
a = 4           % linear coefficient of transfer function denominator
w = sqrt(21)    % sinusoidal frequency

% set up time domain
syms t          % symbol for time [s]
% conditions for t: t must be non-negative
assume(t >= 0)

% handle to function c(t)
xC_t = @(t) 1 + (-cos(w*t) - a/(2*w) * sin(w*t))*exp(-a/2 * t);
% handle to inverse function c<-(t)
xT_c = @(c) solve(c == xC_t(t), t);

% find the final value of the step response
cf = limit(xC_t, t, inf)

% apply c<-(t) to cf*[.1, .9]
TrLims = arrayfun(xT_c, cf*[.1 .9])

% find rise time Tr = -t(.1)c + t(.9)c
Tr = TrLims*[-1 1]'
