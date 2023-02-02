%% Part 1 $-$ Roots and corresponding phase angles of a polynomial
% Given the polynomial
% $P(s) = (s^2 + 10s + 24)(s^4 + 26s^3 + 231s^2 + 766s + 560),$
P = conv([1 10 24], [1 26 231 766 560])

%% 1. we find the roots of the resulting polynomial
P_roots = roots(P)

%% 2. and their corresponding phase angles
P_root_angles = rad2deg(angle(P_roots));
tab_P_root_angles = table(P_roots, P_root_angles)