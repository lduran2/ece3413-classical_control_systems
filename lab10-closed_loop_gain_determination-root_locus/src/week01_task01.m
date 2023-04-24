%% week01_task01.m
% Analyzing the input data.
% By      : Leomar Duran
% When    : 2023-04-19t21:40Q
% For     : ECE 3413 Classical Control Systems
%

clear

% load the time series data from the data file
output_data = load('Lab10_data.mat')

% get the time domain
t = output_data.raw.Time;
% number of samples
Nsamp = length(t)
% starting time for runtime
StartTime = t(1)
% sampling time 
Tsamp = (t(end) - StartTime)/Nsamp

% recreate the step input
input_step_data = ones(size(output_data.raw.Data));
input_step = timeseries(input_step_data, t)

% plot the data for inspection
hold on
plot(input_step)
plot(output_data.raw)
hold off
title('signal vs time')
xlabel('time [s]')
ylabel('signal <1>')
legend(["step input", "output data"])

% create the workspace variable
ident_workspace = [ t , input_step_data , output_data.raw.Data ];
inputIdx = [1 2]
outputIdx = [1 3]


% open System Identification Toolkit
% ident