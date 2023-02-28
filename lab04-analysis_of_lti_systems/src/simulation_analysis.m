%% simulation_analysis.m
% Sets the paraeters for a second order transfer function, then uses step
% analysis to characterize the system.
% By      : Leomar Duran
% When    : 2023-03-27t23:23
% For     : ECE 3413 Classical Control Systems
% Version : 0.0.1
%

clear

% constants for the script
SINK_FILE = 'out.mat';
SENTINEL = "yes";

% simulation parameters
TSTOP = 10.0    % [s]

% step function parameters
Tstep = 0       % [s]

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
[peak, peakIdx] = max(c)
% percent overshoot = (peak value - final value)/(final value) * 100%
pcOS = (peak - c(end))/c(end)* 100
% rise time = time for output to go from 10% to 90% of the final value
pc10Idx = find(c >= .10*c(end), 1)
pc90Idx = find(c >= .90*c(end), 1)
Tr = t(pc90Idx) - t(pc10Idx)
% peak time
Tp = t(peakIdx)
% settling time
% steady state error