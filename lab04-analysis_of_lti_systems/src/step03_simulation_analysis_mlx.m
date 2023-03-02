%% Simulation analysis

% step03_simulation_analysis_mlx.m
% Uses step analysis to characterize the simulation of the system.
% By      : Leomar Duran
% When    : 2023-02-28t18:49
% For     : ECE 3413 Classical Control Systems
%

%% Read the data file and load its data

% constants for the script
SINK_FILE = 'out.mat';

% simulation parameters
TSTOP = 10.0    % [s]

% step function parameters
Tstep = 0       % [s]
stepFinal = 1   % [V]

% read the data from the sink file
data = load(SINK_FILE)
% load the step response data and time
c = data.ans.Data;
t = data.ans.Time;

%% Part 01-03 perform step analysis
% We calculate the analysis using these intermediate values.

[peak, peakIdx] = max(c);
% percent overshoot = (peak value - final value)/(final value) * 100%
pcOS = (peak - c(end))/c(end)* 100;
% rise time = time for output to go from 10% to 90% of the final value
pc10Idx = find(c >= .10*c(end), 1)
pc90Idx = find(c >= .90*c(end), 1)
Tr = t(pc90Idx) - t(pc10Idx);
% peak time = time for the output to reach its maximum value
Tp = t(peakIdx);
% settling time = time for output to be bound within 5% of its final value
TsIdx = find(abs(c - c(end)) >= 0.05*c(end), 1, 'last')
Ts = t(TsIdx);
% steady state error
Ess = (stepFinal - c(end));

%%
% The results are
stepCharacteristics = struct('peak', peak, 'pcOS', pcOS, 'Tr', Tr, 'Tp', Tp, 'Ts', Ts, 'Ess', Ess)

%%
% Plot the steady state error, followed by the plot with characteristics
% traced.
subplot(2,1,1)
hold on
plot(data.ans, 'LineWidth', 2)
plot(t([1 end]), [1 1]*stepFinal)
plot([1 1]*t(end), c(end) + [0 Ess])
hold off
title('Comparison of input, response')
xlabel('time [s]')
ylabel('voltage [V]')
legend('step response', 'input signal', ...
    'steady state error')
%

subplot(2,1,2)
plot(data.ans, 'LineWidth', 2)
hold on
plot([1 1 0]*Tp, [0 1 1]*peak)
plot([1 1 0]*t(pc10Idx), [0 1 1]*c(pc10Idx))
plot([1 1 0]*t(pc90Idx), [0 1 1]*c(pc90Idx))
hold off
title('Response with characteristics')
xlabel('time [s]')
ylabel('voltage [V]')
legend('step response', 'peak', ...
    'settling lower limit', 'settling upper limit')
%
