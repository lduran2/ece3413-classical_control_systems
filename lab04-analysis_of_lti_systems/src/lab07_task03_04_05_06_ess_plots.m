%% lab07_task03_04_05_06_ess_plots.m
% Plots the result and steady state error on the negative feedback
% systems given by the transfer functions of inputs in
% (5(t^n)u(t) : n in [0,2]).
% By      : Leomar Duran
% When    : 2023-04-05t23:01Q
% For     : ECE 3413 Classical Control Systems
%

clear

% Systems
G = zpk(-6, -[4 7 9 12], 1) * ...
    [
        1; ...
        zpk(-8, [], 1) * [1; zpk(-1, [], 1)]
    ]
H = tf(ones(size(G)))

% perform negative feedback given index of G, H
calc_G_CL = @(k) feedback(G(k), H(k))
G_CL = arrayfun(calc_G_CL, 1:prod(size(G)))

% loop through each system
for sys = G_CL
    % loop through the different inputs
    for derivativeNo=(0:2)
        % build the input
        R_s = zpk([], zeros(1, 1 + derivativeNo), ...
            5*factorial(derivativeNo))
        % create a new figure and plot the input signal
        figure
        step(zpk(0, [], 1)*R_s)
        % plot for K in [50, 100]
        hold on
        for K=[50 100]
            step(K*sys*R_s)
        end % next K
        hold off
        % label the plots
        legend(["input function", "response at K=50", "response at K=100"])
    end % next derivativeNo
end % next sys

disp('Done.')
