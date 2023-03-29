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
ColCount = floor(RowCount/2 + 1)

% allocate the Routh=Hurwitz table
RH_table = zeros(RowCount, ColCount);