%% part01a_rise_time.m
% Calculates the rise time Tr given the following transfer function
% denominator linear coefficient, a, and sinusoidal frequency, w.
% By      : Leomar Duran
% When    : 2023-03-07t23:21
% For     : ECE 3413 Classical Control Systems
%

clear

% Given the transfer function
%       G2(s) = ((a/2)^2 + w^2)/((s + a/2)^2 + w^2)
% s.t.
a = 4           % linear coefficient of transfer function denominator
w = sqrt(21)    % sinusoidal frequency
G2 = tf((a/2)^2 + w^2, (convpow(1, [1 a/2], 2) + convpow(1, [0 w], 2)) )

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

function acc = convpow(init, base, power)
%% convpow(vector, power)
% Finds the convolution power $\mathbb{a}\mathbb{b}^{*n}$, that is,
% repeatedly convolves the given base row vector as many times as the
% given power.
%
%% Input Arguments
% *init* : double = initial accumulation value, $\mathbb{a}$
% *base* : double = row vector to convolve $\mathbb{b}$
% *power* : int = the number of times to convolve $n$
%
%% Output Arguments
% *acc* : the resulting convolved row vector
%

    % if power is negative
    if (power < 0)
        % find the corresponding positive convolution power and
        % deconvolve against the initial value
        acc = deconv(init, convpow(1, base, -power));
        return
    end % if (power < 0)

    % initialize
    acc = init;
    % half power until 0
    while (power > 0)
        % if odd power
        if (bitand(power, 1))
            % accumulate
            acc = conv(acc, base);
            % even out power
            power = bitxor(power, 1);
        end % if (bitand(power, 1))

        % convolve square the vector
        base = conv(base, base);
        % update power
        power = bitshift(power, -1);
    end % while (n > 0)
end % function conv_rows(matrix)
