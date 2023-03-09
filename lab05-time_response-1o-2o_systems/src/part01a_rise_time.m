%% part01a_rise_time.m

% Calculates the rise times Tr given the following transfer function
% denominator linear coefficients, a, and sinusoidal frequencys, w.
% By      : Leomar Duran
% When    : 2023-03-09t13:31
% For     : ECE 3413 Classical Control Systems
%
% CHANGELOG:
%       v1.4.0 - 2023-03-09t13:31
%           split from convpow
%
%       v1.3.0 - 2023-03-09t05:21
%           halfing Im part, t >= -1e-5 so it works
%
%       v1.2.0 - 2023-03-09t02:48
%           loop and table for multiple transfer functions
%
%       v1.1.0 - 2023-03-08t13:49
%           modeling G2
%
%       v1.0.0 - 2023-03-07t23:21
%           rise time script
%

clear

% Given the transfer function
%       G2(s) = ((a/2)^2 + w^2)/((s + a/2)^2 + w^2)
% s.t.

% linear coefficient of transfer function denominator
aVec = [4 8 4]';
% sinusoidal frequency
wVec = [sqrt(21) ; sqrt(21) ; sqrt(21)/2];

% set up time domain
syms t          % symbol for time [s]
% conditions for t: t must be non-negative
% We use -1e-5, rather than 0 because (4, sqrt(21)/2)aw does not find a
% t[.1f] when t >= 0. However, the t[.1f] found satisfies t >= 0.
assume(t >= -1e-5)

% number of transfer functions
nTfs = numel(aVec);
% allocate rise time limit matrix
TrLims = zeros(nTfs, 2);

for k=1:numel(aVec)
    % the transfer function
    a = aVec(k)
    w = wVec(k)
    G2 = tf((a/2)^2 + w^2, sum(convpow([1 1]', [1 a/2; 0 w], 2)) )
    
    % handle to function c(t)
    xC_t = @(t) 1 + (-cos(w*t) - a/(2*w) * sin(w*t))*exp(-a/2 * t);
    % handle to inverse function c<-(t)
    xT_c = @(c) solve(c == xC_t(t), t);
    
    % find the final value of the step response
    cf = limit(xC_t, t, inf)
    
    % apply c<-(t) to cf*[.1, .9]
    TrLims(k,:) = arrayfun(xT_c, cf*[.1 .9]);
end % next k

% find rise time Tr = -t(.1)c + t(.9)c
Tr = TrLims*[-1 1]';

% create a table from the results
Tr_table = table(aVec, wVec, TrLims, Tr)

disp("Done.")

%% end
