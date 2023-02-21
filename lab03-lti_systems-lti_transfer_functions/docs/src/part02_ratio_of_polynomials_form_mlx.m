%% Part 2 $-$ Rational of polynomials form

% use Mssr the state-space representation from part 01

%% 1. Conversion using Matlab
% The transfer function from the state-space representation
Mtf = tf(Mssr)

%% 2. Equation for transfer functions

% create a transfer function that is just s
s = tf([1 0], 1);
T = Mssr.C*(s*eye(size(Mssr.A)) - Mssr.A)^-1*Mssr.B

%% Coefficient of determination $R^2$
% To compare the transfer functions, let's find the $R^2$ value of all
% coefficients.

% calculate the needed padding
MtfMinusTNum = (numel(T.Num{1}) - numel(Mtf.Num{1}));
MtfMinusTDen = (numel(T.Den{1}) - numel(Mtf.Den{1}));
% zero pad the numerators if necessary
MtfNumPadded = [ zeros(1, MtfMinusTNum), Mtf.Num{1} ];
TNumPadded = [ zeros(1, -MtfMinusTNum), T.Num{1} ];
% zero pad the denominators if necessary
MtfDenPadded = [ zeros(1, MtfMinusTDen), Mtf.Den{1} ];
TDenPadded = [ zeros(1, -MtfMinusTDen), T.Den{1} ];

% group the terms together
MtfTerm = [MtfNumPadded MtfDenPadded];
TTerm = [TNumPadded TDenPadded];

%%
% Then the R^2
R2 = prod(corrcoef(MtfTerm, TTerm), 'all')^2
assert(abs(1 - R2) < 0.05, ...
    'Unexpectedly low correlation between converted and calculated transfer functions.')
disp('shows that the coefficients have a strong correlation')
disp('and are therefore equivalent.')
