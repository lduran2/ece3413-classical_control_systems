%% Part 2 $-$ Laplace transforms

clear

%% 1. The Laplace transform
% Find the Laplace transform of
%
% $f(t) = 0.0075 - 0.00034e^{-2.5t}cos(22t) +
%    0.087e^{-2.5t}sin(22t) - 0.0072e^{-8t}.$

% make a symbol t
syms t
% the function f(t) represented by MATLAB
f_t = 0.0075 - 0.00034*exp(-2.5*t)*cos(22*t) + ...
    0.087*exp(-2.5*t)*sin(22*t) - 0.0072*exp(-8*t)

%%
% The Laplace transform of $f(t)$,

% make a symbol s
syms s
F = laplace(f_t, s)

%%
clear

%% 2. The inverse of the Laplace transform
% Find the inverse Laplace transform of
%

% the transfer function to find the inverse Laplace of
F = zpk(-[3 5 7], [0 8 roots([1 10 100])'], 2)

%%
% The inverse Laplace transform of $F(s)$,

% make symbol s t
syms s t
F_s_num = prod(s - F.z{1})/prod(s - F.p{1})*F.k(1);
f_t = ilaplace(F_s, t)
