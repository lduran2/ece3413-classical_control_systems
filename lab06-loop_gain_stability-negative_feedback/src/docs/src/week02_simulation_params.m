%% week02_simulation_params.m
% Sets the parameters for simulating the second order transfer functions.
% By      : Leomar Duran
% When    : 2023-03-22t20:46
% For     : ECE 3413 Classical Control Systems
%

clear

% simulation parameters
TSTOP = 10.0    % [s]

% step function parameters
Tstep = 0       % [s]
stepFinal = 1   % [V]

% transfer function parameters
B = [     400 ;      900 ;      225 ;     625 ];
A = [1 12 400 ; 1 90 900 ; 1 30 225 ; 1 0 625 ];

% the feedback gain
H = 1

% count transfer function and terms
[tfCount, numTermCount] = size(B);
[~, denTermCount] = size(A);
% create transfer functions from these
G = tf( ...
    mat2cell(B, ones(1,tfCount), numTermCount), ...
    mat2cell(A, ones(1,tfCount), denTermCount))
% indices expected in reverse order and normalized to A(1)
b = B(:,end:-1:1)./A(:,1)
% A(1) is thus unneeded
a = A(:,end:-1:2)./A(:,1)
