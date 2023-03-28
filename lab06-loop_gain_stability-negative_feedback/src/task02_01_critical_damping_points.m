%% Finding the critical damping points of the given negative feedback system.

% task02_01_critical_damping_points.m
% By      : Leomar Duran
% When    : 2023-03-28t13:25
% For     : ECE 3413 Classical Control Systems
%

clear

%% Symbolic representation of the system
% Given the negative feedback system with

% basic symbols:
% complex frequency, gain
syms s K

G_s = K/(s*(s + 2)^2)

H_s = 1

%%
% The equivalent transfer function

C_per_R_s = simplify(G_s/(1 + G_s*H_s))

%% The limit of K
% We start by solving for $K$ in terms of $s$.

% The transfer function is some polynomial function Den(s) s.t.
% (C/R)(s) = K/Den(s).
% Thus Den(s) = K/(C/R)(s)

Den_s = K/C_per_R_s

%%
% We find the K for characteristic equation $Den(s) = 0$.

K_0 = solve(Den_s == 0, K)

%%
% We next fix the derivative $\frac{dK_0}{ds} = 0$. So the points of
% inflection are at

s_0 = roots(sym2poly(diff(K_0, s)))

%%
% Finally, we find the non-zero values of K at these points of inflection,
% giving the critical damping point(s).

K_inflection = subs(K_0, s, s_0);
K_critical_damping = K_inflection(find(K_inflection))

%%
% Lower values will be overdamped.