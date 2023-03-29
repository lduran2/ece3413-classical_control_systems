%% Performs Routh=Hurwitz criterion on the given 

% task02_02_routh_hurwitz_mlx.m
% By      : Leomar Duran
% When    : 2023-03-29t01:39
% For     : ECE 3413 Classical Control Systems
%

clear

%% Symbolic representation of the system
% Given the negative feedback system with

task02_00_simulation_params

%%
% The equivalent transfer function

C_per_R_s = simplify(G_s/(1 + G_s*H_s))

%% The limit of K
% We start by solving for $K$ in terms of $s$.

% The transfer function is some polynomial function Den(s) s.t.
% (C/R)(s) = K/Den(s).
% Thus Den(s) = K/(C/R)(s)

Den_s = K/C_per_R_s

%% Degree of denominator
degree = double(limit(log(Den_s)/log(s), s, Inf))

%% Dimensions of the Routh=Hurwitz table
RowCount = (1 + degree)
ColCount = (1 + ceil(RowCount/2))

% allocate the Routh=Hurwitz table
syms RH_matrix [RowCount, ColCount]

%% Populate input rows.
% These are the rows for the degree of the polynomial and next highest
% power of s.

% start on row 1 if even degree, row 2 if odd degree
RowIdx = (bitand(degree, 1) + 1)
% start on penultimate column
ColIdx = (ColCount - 1)
% copy the denominator
CurrDen_s = Den_s;

for power=1:(degree + 1)
    % get the constant from the current denominator
    constant = subs(CurrDen_s, s, 0)
    % add it to the Routh=Hurwitz table
    RH_matrix(RowIdx, ColIdx) = constant;
    % update row index
    RowIdx = (RowIdx - 1)
    % differentiate for next denominator, divide by power
    CurrDen_s = (diff(CurrDen_s, s) / power)
    % wrap around row index and update column index if necessary
    if (RowIdx == 0)
        RowIdx = 2
        ColIdx = (ColIdx - 1)
    end % if (RowIdx == 1)
end % next power

RH_matrix