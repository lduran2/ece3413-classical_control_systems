%% week01_task01.m
% Analyzing the input data.
% By      : Leomar Duran
% When    : 2023-04-19t21:40Q
% For     : ECE 3413 Classical Control Systems
%

clear

% load the time series data from the data file
output_load = load('Lab10_data.mat')

% get the time domain
t = output_load.raw.Time;
% number of samples
[Nsamp, ~] = size(t)
% starting time for runtime
StartTime = t(1)
% sampling time 
Tsamp = (t(end) - StartTime)/Nsamp

% get the output data
output = output_load.raw.Data;
% recreate the step input
input_step = ones(size(output));
% as a time series
input_step_ts = timeseries(input_step, t)

% plot the data for inspection
hold on
plot(input_step_ts)
plot(output_load.raw)
hold off
title('signal vs time')
xlabel('time [s]')
ylabel('signal <1>')
legend(["step input", "output data"])

% create workspace structure
data = table(input_step, output);

% open System Identification Toolkit
% ident