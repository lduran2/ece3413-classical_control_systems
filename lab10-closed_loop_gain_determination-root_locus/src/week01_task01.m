%% week01_task01.m
% Analyzing the input data.
% By      : Leomar Duran
% When    : 2023-04-19t21:40Q
% For     : ECE 3413 Classical Control Systems
%

clear

% load the time series data from the data file
output_data = load('Lab10_data.mat')

% recreate the step input
input_step_data = ones(size(output_data.raw.Data));
input_step = timeseries(input_step_data, output_data.raw.Time)

% plot the data for inspection
hold on
plot(input_step)
plot(output_data.raw)
hold off
title('signal vs time')
xlabel('time [s]')
ylabel('signal <1>')
legend(["step input", "output data"])

% open System Identification Toolkit
ident