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
% this seems to be the best we can do although it just gives the sum of
% rational expressions instead of a rational expression of polynomials
% because you cannot convert symbol to transfer function
F = laplace(f_t, s)

%%
clear

%% 2. The inverse of the Laplace transform
% Find the inverse Laplace transform of
%

% the transfer function to find the inverse Laplace of
F = zpk(-[3 5 7], [0 8 roots([1 10 100])'], 2)

%%
% We can represent the transfer function in Matlab from its roots

% make a symbol s
syms s

% get zeros and poles
F_z = F.z{1};
F_p = F.p{1};
% zeroes and poles that are purely real
F_zr = F_z(imag(F_z) == 0);
F_pr = F_p(imag(F_p) == 0);
% zeroes and poles with negative impaginary part
F_zmi = F_z(imag(F_z) < 0);
F_pmi = F_p(imag(F_p) < 0);
% we don't need the positive imaginary parts because these are just the
% conjugates of the negative ones, and we can get them from the
% negative ones

% multiply the real zeroes/real poles (all linear polynomials)
F_linear = prod(s - F_zr)/prod(s - F_pr);
% multiply in the complex ones (all quadratic polynomials)
F_quadratic = prod(factorFromComplexRoot(F_zmi, s))/...
                    prod(factorFromComplexRoot(F_pmi, s));
% multiply linear, quadratic and gain
F_s = F_linear * F_quadratic * F.k(1)

%%
% Then, the inverse Laplace transform of $F(s)$,
% make a symbol t
syms t
f_t = ilaplace(F_s, t)

function factor = factorFromComplexRoot(complexRoot, s)
%% factorFromComplexRoot(complexRoot, s)
% Returns the polynomial factor $P(s)$ that when fixed to 0, gives the
% given *complexRoot* for polynomial variable *s*.
%
%% Input Arguments
% *complexRoot* : double = root for which to find the polynomial
%
%% Output Arguments
% *factor* : the factor polynomial $P(s)$ that equals 0 at *s ==
% complexRoot*
%

    factor = ((s - real(complexRoot)).^2 + imag(complexRoot).^2);
end % function factorFromComplexRoot(complexRoot, s)
