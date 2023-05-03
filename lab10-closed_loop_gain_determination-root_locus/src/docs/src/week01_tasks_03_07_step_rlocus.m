%% week01_task03_07_step_rlocus.m
% Analyzing the input data.
% By      : Leomar Duran
% When    : 2023-04-26t22:53Q
% For     : ECE 3413 Classical Control Systems
%

clear

% load parameters
week01_task01_params

% encapsulate output and input data with time sampling
mydata = iddata(data.output_response, data.input_step, Tsamp)

% order of each transfer function
orders = [2 3 2 3 3]';
% # zeroes for each transfer function
zeroes = [0 0 1 1 2]';
% tabularize this data
tf_orders = table(orders, zeroes)

tf = [];

for tfIdx = 1:height(tf_orders)
    % load next row
    tf_order = tf_orders(tfIdx,:);
    % estimate next transfer function
    nextTf = tfest(mydata, tf_order.orders, tf_order.zeroes)
    % add next transfer function to array
    tf = [tf ;  nextTf];
    % plot the root locus
    figure
    rlocus(nextTf)
end

% plot the step responses
figure
step(tf, t)
