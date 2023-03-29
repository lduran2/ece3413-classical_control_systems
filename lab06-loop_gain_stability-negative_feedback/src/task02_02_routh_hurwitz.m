%% task02_02_routh_hurwitz.m
% Performs Routh=Hurwitz criterion on the given 
% By      : Leomar Duran
% When    : 2023-03-29t03:48
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

%% Routh=Hurwitz table
% Degree of denominator
degree = double(limit(log(Den_s)/log(s), s, Inf))

% Dimensions of the Routh=Hurwitz table
RowCount = (1 + degree)
ColCount = (1 + ceil(RowCount/2))

% allocate the Routh=Hurwitz table
RH_matrix = sym(zeros(RowCount, ColCount))

% Populate input rows.
% These are the rows for the degree of the polynomial and next highest
% power of s.

% start on row 1 if even degree, row 2 if odd degree
rowIdx = (bitand(degree, 1) + 1)
% start on penultimate column
colIdx = (ColCount - 1)
% copy the denominator
CurrDen_s = Den_s;

for power=1:(degree + 1)
    % get the constant from the current denominator
    constant = subs(CurrDen_s, s, 0)
    % add it to the Routh=Hurwitz table
    RH_matrix(rowIdx, colIdx) = constant;
    % update row index
    rowIdx = (rowIdx - 1)
    % differentiate for next denominator, divide by power
    CurrDen_s = (diff(CurrDen_s, s) / power)
    % wrap around row index
    if (rowIdx == 0)
        rowIdx = 2
        % update column index
        colIdx = (colIdx - 1)
    end % if (RowIdx == 1)
end % next power

% calculate remaining cells
for rowIdx=3:RowCount
    prevFirst = RH_matrix((rowIdx - 1), 1)
    for colIdx=1:(ColCount - 1)
        M = RH_matrix((rowIdx + (-2:-1)), [1 (colIdx + 1)])
        nextValue = det(M)/-prevFirst
        RH_matrix(rowIdx, colIdx) = nextValue;
    end % next colIdx
end % next rowIdx

%% RH table from the matrix
powerCells = num2cell(degree:-1:0);
powerRowNames = cellfun( ...
    @(d) sprintf('s^%d', d), powerCells, ...
    'UniformOutput', false ...
);
RH_table = array2table(RH_matrix, 'RowNames', powerRowNames)
