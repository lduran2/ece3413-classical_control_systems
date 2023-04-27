%% week01_task01_params.m
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
output_raw = output_load.raw.Data;
% recreate the step input
input_step = ones(size(output_raw));
% as a time series
input_step_ts = timeseries(input_step, t)

% apply the median filter
% Find a way to filter the data to the best of your abilities and
% retain the rise time and settling time characteristics.
% However, to find the rise and settling time characteristics, we have
% to smoothen the curve in the first place.  In light of this, a median
% filter with 19o seems to smoothen out the function satisfactorily by
% inspection.
output_response = medfilt1(output_raw, 19);

% plot the data for inspection
hold on
plot(input_step_ts)
pOutput = plot(t, output_response);
pOutput.LineWidth = 8;
plot(output_load.raw)
hold off
title('signal vs time')
xlabel('time [s]')
ylabel('signal <1>')
legend(["step input", "filtered output", "unfiltered output data"])

% create workspace structure
data = table(input_step, output_response);
