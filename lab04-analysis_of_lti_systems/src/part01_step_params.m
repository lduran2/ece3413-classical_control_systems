%% simulation_analysis.m
% Sets the parameters for a second order transfer function, then uses step
% analysis to characterize the system.
% By      : Leomar Duran
% When    : 2023-03-28t18:39
% For     : ECE 3413 Classical Control Systems
%

clear

% constants for the script
SINK_FILE = 'out.mat';
SENTINEL = "yes";

% simulation parameters
TSTOP = 10.0    % [s]

% step function parameters
Tstep = 0       % [s]
stepFinal = 1   % [V]

% transfer function parameters
B = 2;
A = [1 5 9];
G = tf(B, A)
% indices expected in reverse order
b = B(end:-1:1);
a = A(end:-1:1);

% wait for simulation data
while (SENTINEL ~= input(sprintf( ...
        'Please run the simulation, and type "%s" afterward.\n> ', ...
        SENTINEL ...
        ), 's'))
end % while (SENTINEL ~= )

% read the data from the sink file
data = load(SINK_FILE)
% load the step response data and time
c = data.ans.Data;
t = data.ans.Time;


%% part01.3 perform step analysis
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
stepCharacteristics = struct('peak', peak, 'pcOS', pcOS, 'Tr', Tr, 'Tp', Tp, 'Ts', Ts, 'Ess', Ess)

% plot the steady state error
subplot(2,1,1)
hold on
plot(data.ans, 'LineWidth', 2)
plot(t([1 end]), [1 1]*stepFinal)
plot([1 1]*t(end), c(end) + [0 Ess])
hold off
title('comparison of input and response')
xlabel('time [s]')
ylabel('voltage [V]')
legend('step response', 'input signal', ...
    'steady state error')
%

% plot with these characteristics labeled
subplot(2,1,2)
plot(data.ans, 'LineWidth', 2)
hold on
plot([1 1 0]*Tp, [0 1 1]*peak)
plot([1 1 0]*t(pc10Idx), [0 1 1]*c(pc10Idx))
plot([1 1 0]*t(pc90Idx), [0 1 1]*c(pc90Idx))
hold off
title('response to input with characteristics')
xlabel('time [s]')
ylabel('voltage [V]')
legend('step response', 'peak', ...
    'settling lower limit', 'settling upper limit')
%

