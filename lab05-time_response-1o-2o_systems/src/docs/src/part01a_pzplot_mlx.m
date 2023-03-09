%% Plotting the poles and zeroes.

% part01_pzplot_mlx.m
% Plots the poles and zeroes of the given transfer function.
% By      : Leomar Duran
% When    : 2023-03-08t19:50
% For     : ECE 3413 Classical Control Systems
%

clear

%%
% The transfer function
G2 = tf(25, [1 4 25])
%%
% converts to zero-pole-gain form
G2_zpk = zpk(G2)

%%
% We find the zeroes
G2_zero = G2_zpk.Z{1}
%%
% and poles
G2_pole = G2_zpk.P{1}

%%
% Next we plot these as points with the real part as the x-component
% and the imaginary part as the y-component.

% get (x, y) from zeroes
G2_zero_x = real(G2_zero);
G2_zero_y = imag(G2_zero);
% get (x, y) from poles
G2_pole_x = real(G2_pole);
G2_pole_y = imag(G2_pole);

% generate the legends
G2pzLegends = ["zeroes of G2", "poles of G2"];
% ignore either if we might not find any zeroes or poles
G2pzLegendIdx = (cellfun(@numel, {G2_zero_x, G2_pole_x}) ~= 0);
G2pzLegends = G2pzLegends(G2pzLegendIdx);

% plot the zeroes, then poles
plot(G2_zero_x, G2_zero_y, 'o', ...
     G2_pole_x, G2_pole_y, 'x')
% label the plot and grid
grid
title('Pole-zero plot')
xlabel('\sigma [rad/s]')
ylabel('j\omega [rad/s]')
legend(G2pzLegends)
