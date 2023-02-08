%% Part 1 $-$ Poles and zeros

clear

%% 1ab. Roots
% Calculate the roots of each of the following polynomials

% Each polynomial is represented by each row of the matrix
P12 = [ 1 1 2 8 7 15 12 ; ...
        1 1 4 3 7 15 18 ];

% the number of polynomials
n_rows = size(P12, 1);
    
% print the polynominal forms of each in turns of s
syms P [1 2], syms s
for k=1:n_rows
    disp(P(k) == poly2sym(P12(k,:), s))
end % next k

%%

% allocate cell array of roots
P_roots = cell(1, n_rows);
% loop through the rows of P12
for k=1:n_rows
    % calculate the roots for each polynomial
    P_roots{k} = roots(P12(k,:));
end % next k

%%
% The roots for each polynomial are
P1_roots = P_roots{1}
P2_roots = P_roots{2}

%% 2. Polynomial form
% Calculate the polynomial form and roots of

% the polynomial
P3_poly = poly(-[5 2 3 -1 -2 4]);

% display factored out in terms of s
syms P3 s
disp(P3 == prod(factor(poly2sym(P3_poly, s))))

%%
% The polynomial form is
syms s
P3_s = poly2sym(P3_poly, s)

%%
% The roots of the polynomial are
P3_roots = roots(P3_poly)

%% 3a. Converting to polynomial numerator and denominator.
% Represent

% the transfer function in zero-pole-gain form
G1 = zpk(-[2 3 -6 8], -[0 7 -2 10 -3], 9)

%%
% using polynomials in the numerator and denominator.

%%
% In polynomial numerator and denominator, the transfer function
G1_tf = tf(G1)

%% 3b. Converting to zero-pole-gain form.
% Represent 

% the transfer function in polynomial numerator and denominator form
G2 = tf([1 17 99 223 140], [1 32 363 2092 5052 4320])

% $G_2(s) = \frac{s^4 + 17s^3+ 99s^2 + 223s + 140}
%                {s^5 + 32s^4 + 363s^3 + 2092s^2 + 5052s + 4320}}$

%%
% using factored forms of the polynomials in the numerator and
% denominator.

%%
% In zero-pole-gain form, the transfer function
G2_zpk = zpk(G2)
