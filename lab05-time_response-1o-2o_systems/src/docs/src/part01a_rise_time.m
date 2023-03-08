%% part01a_rise_time.m
% Calculates the rise time Tr given the following transfer function
% denominator linear coefficient, a, and sinusoidal frequency, w.
% By      : Leomar Duran
% When    : 2023-03-08t18:29
% For     : ECE 3413 Classical Control Systems
%

clear

% Given the transfer function
%       G2(s) = ((a/2)^2 + w^2)/((s + a/2)^2 + w^2)
% s.t.
a = 4           % linear coefficient of transfer function denominator
w = sqrt(21)    % sinusoidal frequency
G2 = tf((a/2)^2 + w^2, sum(convpow([1 1]', [1 a/2; 0 w], 2)) )

% set up time domain
syms t          % symbol for time [s]
% conditions for t: t must be non-negative
assume(t >= 0)

% handle to function c(t)
xC_t = @(t) 1 + (-cos(w*t) - a/(2*w) * sin(w*t))*exp(-a/2 * t);
% handle to inverse function c<-(t)
xT_c = @(c) solve(c == xC_t(t), t);

% find the final value of the step response
cf = limit(xC_t, t, inf)

% apply c<-(t) to cf*[.1, .9]
TrLims = arrayfun(xT_c, cf*[.1 .9])

% find rise time Tr = -t(.1)c + t(.9)c
Tr = TrLims*[-1 1]'

%% end

function [acc,rem] = convpow(init, base, power)
%% convpow(vector, power)
% Finds the convolution power $\mathbb{a}\mathbb{b}^{*n}$, that is,
% repeatedly convolves the given base row vector as many times as the
% given power to find 
%
%% Input Arguments
% *init* : double = initial accumulation value $\mathbb{a}$
%
% *base* : double = row vector to convolve $\mathbb{b}$
%
% *power* : int = the number of times to convolve $n$
%
%% Output Arguments
% *acc* : the resulting convolved row vector
%
% $\mathbb{p} := \mathbb{a}\mathbb{b}^{*n}$
%
% *rem* : the remainder of convolution
%
% $\left[\mathbf{0}^\top \middle| \mathbb{a}\right] - \mathbb{p}\mathbb{b}^{*-n}$
%

    % if power is negative
    if (power < 0)
        % initialize a one vector with the same # rows as base
        onesInit = ones(size(base, 1), 1);
        % find the corresponding positive convolution power and
        % deconvolve against the initial value
        [acc, rem] = deconvbyrow(init, convpow(onesInit, base, -power));
        return
    end % if (power < 0)

    % initialize
    acc = init;
    % half power until 0
    while (power > 0)
        % if odd power
        if (bitand(power, 1))
            % accumulate
            acc = convbyrow(acc, base);
            % even out power
            power = bitxor(power, 1);
        end % if (bitand(power, 1))

        % convolve square the vector
        base = convbyrow(base, base);
        % update power
        power = bitshift(power, -1);
    end % while (n > 0)
    % remainder is all zeroes bcs the power is non-negative
    rem = zeros(size(acc));
end % function conv_rows(matrix)

function UV = convbyrow(U, V)
%% convbyrow(U, V)
% Performs rowwise convolution of the given matrices U, V.
%
%% Input Arguments
% *U* : first input matrix
%
% *V* : second input matrix
%
%% Output Arguments
% *UV* : the resulting matrix of convolved rows
%

    % get the sizes of the arrays
    [nURows, nUCols] = size(U);
    [nVRows, nVCols] = size(V);
    assert(nURows == nVRows, ...
        sprintf('U = %d, V = %d must have an equal number of rows.', ...
            nURows, nVRows))

    % separate the rows
    URows = mat2cell(U, ones(nURows, 1), nUCols);
    VRows = mat2cell(V, ones(nURows, 1), nVCols);

    % convolution function handle
    xConv = @(U, V) conv(U, V);
    % apply to rows
    UVRows = cellfun(xConv, URows, VRows, 'UniformOutput', false);
    % convert to matrix
    UV = cell2mat(UVRows);
end % function convbyrow(U, V)

function [Q,R] = deconvbyrow(U, V)
%% deconvbyrow(U, V)
% Performs rowwise deconvolution of the given matrices U, V.
%
%% Input Arguments
% *U* : first input matrix
%
% *V* : second input matrix
%
%% Output Arguments
% *Q* : the matrix of quotient rows
%
% *R* : the matrix of remainder rows
%

    % get the sizes of the arrays
    [nURows, nUCols] = size(U);
    [nVRows, nVCols] = size(V);
    assert(nURows == nVRows, ...
        sprintf('U = %d, V = %d must have an equal number of rows.', ...
            nURows, nVRows))

    % separate the rows
    URows = mat2cell(U, ones(nURows, 1), nUCols);
    VRows = mat2cell(V, ones(nURows, 1), nVCols);

    % deconvolution function handle
    xDeconv = @(u, v) deconvlead(u, v);
    % apply to rows
    [QRows, RRows] = cellfun(xDeconv, URows, VRows, 'UniformOutput', false)
    % convert to matrices
    Q = cell2mat(QRows);
    R = cell2mat(RRows);
end % function deconvbyrow(U, V)

function [q, r] = deconvlead(u, v)
%% deconvlead(u, v)
% Performs deconvolution accounting for leading zeros.  Leading zeros
% are ignored in inputs, and the output is padded to match the inputs.
% E.g., each of the following will produce results of size 3
%       [1, 0, 0]/[1, 0]
%       [1, 0, 0]/[0, 1]
%       [0, 1, 0]/[1, 0]
%       [0, 1, 0]/[0, 1]
%       [0, 0, 1]/[1, 0]
%       [0, 0, 1]/[0, 1]
%
%% Input Arguments
% *u* : first input row vector
%
% *v* : second input row vector
%
%% Output Arguments
% *q* : the quotient row vector
%
% *r* : the remainder row vector
%

    % get the first nonzero of each vector
    uIdx = find(u, 1);
    vIdx = find(v, 1);

    % use the dividend as the ideal size for quotient and remainder
    % vectors
    uLen = numel(u)

    % perform the deconvolution
    [q, r] = deconv(u(uIdx:end), v(vIdx:end))
    % get the lengths of the output vectors
    qLen = numel(q);
    rLen = numel(r);
    % zero pad each
    q = [zeros(1, (uLen - qLen)) q]
    r = [zeros(1, (uLen - rLen)) r]
end % function function deconvlead(U, V)
