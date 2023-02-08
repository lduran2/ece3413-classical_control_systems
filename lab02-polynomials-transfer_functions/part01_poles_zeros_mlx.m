%% Part 1 $-$ Poles and zeros

clear

%% 1ab. Roots
% Calculate the roots of the following polynomials
% $P_1(s) = s^6 + s^5 + 2s^4 + 8s^3 + 7s^2 + 15s + 12,$
% $P_2(s) = s^6 + s^5 + 4s^4 + 3s^3 + 7s^2 + 15s + 18.$
%
% Each polynomial is represented by each row of the matrix
P12 = [ 1 1 2 8 7 15 12 ; ...
        1 1 4 3 7 15 18 ]

% the number of polynomials
n_rows = size(P12, 1);

% allocate cell array of roots
P_roots = cell(1, n_rows);
% loop through the rows of P12
for k=1:n_rows
    % calculate the roots for each polynomial
    P_roots{k} = roots(P12(k,:));
end % next P

%%
% The roots for each polynomial are
P1_roots = P_roots{1}
P2_roots = P_roots{2}

%% 2. Polynomial form
% Calculate the polynomial form and roots of
% $P_3(s) = (s + 5)(s + 2)(s + 3)(s - 1)(s - 2)(s + 4).$
%
% The polynomial is represented by the row vector
P3 = poly(-[5 2 3 -1 -2 4])

%%
% The polynomial form is
syms s
P3_s = poly2sym(P3, s)

%%
% The roots of the polynomial are
P3_roots = roots(P3)

%% 3a. Converting to polynomial numerator and denominator.
% Represent
% $G_1(s) = \frac{9(s + 2)(s + 3)(s - 6)(s + 8)}
%                {s(s + 7)(s - 2)(s + 10)(s - 3)}$
% using polynomials in the numerator and denominator.
%
% In zero-pole-gain form, the transfer function
G1_zpk = zpk(-[2 3 -6 8], -[0 7 -2 10 -3], 9)

%%
% In polynomial numerator and denominator, the transfer function
G1_tf = tf(G1_zpk)

%% 3b. Converting to zero-pole-gain form.
% Represent 
% $G_2(s) = \frac{s^4 + 17s^3+ 99s^2 + 223s + 140}
%                {s^5 + 32s^4 + 363s^3 + 2092s^2 + 5052s + 4320}}$
% using factored forms of the polynomials in the numerator and
% denominator.
%
% In polynomial numerator and denominator form, the transfer function
G2_tf = tf([1 17 99 223 140], [1 32 363 2092 5052 4320])

%%
% In zero-pole-gain form, the transfer function
G2_zpk = zpk(G2_tf)
