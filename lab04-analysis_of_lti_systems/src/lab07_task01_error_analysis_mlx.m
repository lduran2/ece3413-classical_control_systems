%% Task 01 Error Analysis

% lab07_task01_error_analysis_mlx.m
% Performs error analysis on the negative feedback systems given by the
% transfer functions.
% By      : Leomar Duran
% When    : 2023-04-05t21:34
% For     : ECE 3413 Classical Control Systems
%

clear

%% Setup

% gains
syms k real
% frequency domain
syms s
% time domain
syms t real

%% Systems
% We have the systems with each of the forward branches
% forward branch
G_s = (k*(s + 6)/poly2sym(poly(-[4 7 9 12]), s)) * ...
    [
        1; ...
        (s + 8) * [1; (s + 1)]
    ]
%%
% and each of the backward branches
H_s = ones(size(G_s))

%%
% being equivalent to the transfer functions
G_CL_s = ((G_s.*H_s).^-1 + 1).^-1

%% Static error constants
% Next we calculate the static error constants for position, velocity and
% acceleration, respectively 
%
% $$ K_p = \lim_{s\to0} G(s) $$
%
% $$ K_v = \lim_{s\to0} s G(s) $$
%
% $$ K_a = \lim_{s\to0} s^2 G(s) $$

% calculate the static error constants
derivativeNo = (0:2)'
staticErrorConstants = limit(s.^(derivativeNo)*G_s', s, 0)

%% Steady-state errors
% Next we calculate the steady-state errors. These are
%
% For step:
% $e_{ss} = \frac1{1 + K_p}$
%
% For ramp:
% $e_{ss} = \frac1{K_v}$
%
% For parabola:
% $e_{ss} = \frac1{K_a}$

ess = 1./([1 0 0]' + staticErrorConstants)

%% System types
% The system's type is the number of ZERO poles.
%
% We find the number of zeroes for each transfer function
G_s
%%
% to be

% function to find the roots of a polynomial on s
% (or zeros of a rational expression of s)
findZeros = @(R_s) solve(R_s == 0, s);
% function to count the number of zeros equal to ZERO
countZeros = @(z) sum(logical(z == 0));

% apply it to each transfer function (solve normally treats function
% vectors as systems of functions, which is not desired)
warning off symbolic:solve:SolutionsDependOnConditions
poles_G_s = arrayfun(findZeros, 1./G_s, 'UniformOutput', false);
warning on symbolic:solve:SolutionsDependOnConditions
% count the number of ZERO poles
type = cellfun(countZeros, poles_G_s)

