%% week01_task03_07_step_rlocus.m
% Analyzing the input data.
% By      : Leomar Duran
% When    : 2023-04-26t22:53Q
% For     : ECE 3413 Classical Control Systems
%

clear

% load parameters
week01_task01_params

rlocusTitleFormat = 'Root Locus: p in R^%d, z in R^%d';

% encapsulate output and input data with time sampling
mydata = iddata(data.output_response, data.input_step, Tsamp)

% order of each transfer function
poleCountRange = [2 3]
% # zeroes for each transfer function
zeroCounts = 0:2

% array for transfer functions
tf = [];

% loop through each (zeroCount, poleCount) combination
for zeroCount = zeroCounts
    % skip order to (zeroCount + 1) if (zeroCount + 1) > poleCountRange(1)
    for poleCount = max(poleCountRange(1), zeroCount + 1):poleCountRange(2)
        % create title
        rlocusTitle = sprintf(rlocusTitleFormat, poleCount, zeroCount)
        % estimate next transfer function
        nextTf = tfest(mydata, poleCount, zeroCount)
        % add next transfer function to array
        tf = [tf ;  nextTf];
        % plot the root locus
        figure
        rlocus(nextTf)
        title(rlocusTitle)
    end % next poleCount
end % next zeroCount

% plot the step responses
figure
step(tf, t)
