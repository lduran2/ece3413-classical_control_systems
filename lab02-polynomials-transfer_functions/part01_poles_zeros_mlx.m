%% Part 1 $-$ Poles and zeros

clear

%% Calculate the roots of the following polynomials
% $P_1 = s^6 + s^5 + 2s^4 + 8s^3 + 7s^2 + 15s + 12,$
% $P_2 = s^6 + s^5 + 4s^4 + 3s^3 + 7s^2 + 15s + 18.$

P12 = [ 1 1 2 8 7 15 12 ; ...
        1 1 4 3 7 15 18 ]

n_polynomials = size(P12, 1)

% allocate cell array of roots
P_roots = cell(1, n_polynomials);
% loop through the rows of P12
for k=1:n_polynomials
    % calculate the roots for each polynomial
    P_roots{k} = roots(P12(k,:));
end % next P

% store the values in variables
P1_roots = P_roots{1}
P2_roots = P_roots{2}
