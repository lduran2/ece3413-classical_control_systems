%% Plotting the poles and zeroes.

% part01_pzplot_mlx.m
% Plots the poles and zeroes of the given transfer function
% using both a custom plot (pzplot) and the builtin pzmap.
% By      : Leomar Duran
% When    : 2023-03-09t20:11
% For     : ECE 3413 Classical Control Systems
%

clear

%%
% The transfer functions
G2 = [
    tf(25, [1 4 25]) ;
    tf(37, [1 8 37]) ;
    tf(37/4, [1 4 37/4]) ;
    tf(400, [1 16 400])
]
%%
% name the transfer functions
G2_name = [
    "G2" ;
    "G2 with 2\Re(s_0)" ;
    "G2 with (^1/_2)\Im(s_0)" ;
    "G2 with 4\omega_n" ;
]
%%
% get the number of transfer functions
nG2 = numel(G2)
%%
% convert to zero-pole-gain form
G2_zpk = zpk(G2)

%%
% Set up the figure.
figure
%%
% use pzplot for subplot #1
subplot 121

for k=1:nG2
    %%
    % We find the zeroes
    G2_zero = G2_zpk.Z{k}
    %%
    % and poles
    G2_pole = G2_zpk.P{k}

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
    hold on
    plot(G2_zero_x, G2_zero_y, 'o', ...
         G2_pole_x, G2_pole_y, 'x', ...
            'LineWidth', 2, ...
            'DisplayName', strcat("zeroes of ", G2_name(k)), ...
            'DisplayName', strcat("poles of ", G2_name(k)) ...
    )
    hold off
end % next k

% label the plot and grid
grid
title('Pole-zero plot')
xlabel('\sigma [rad/s]')
ylabel('j\omega [rad/s]')
legend(gca,'show')

%%
% use pzmap in subplot #2
subplot 122
for k=1:nG2
    hold on
    pzmap(G2(k))
    hold off
end % next k
grid
legend(G2_name(:))
