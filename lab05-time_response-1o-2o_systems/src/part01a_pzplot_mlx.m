%% Plotting the poles and zeroes.

% part01_pzplot_mlx.m
% Plots the poles and zeroes of the given transfer function
% using both a custom plot (pzplot) and the builtin pzmap.
% By      : Leomar Duran
% When    : 2023-03-15t08:12
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
G2count = numel(G2)
%%
% convert to zero-pole-gain form
G2_zpk = zpk(G2)

%%
% Set up the figure.
figure
%%
% use pzplot for subplot #1
subplot 121

for G2Idx=1:G2count
    %%
    % We find the zeroes
    G2_zero = G2_zpk.Z{G2Idx}
    %%
    % and poles
    G2_pole = G2_zpk.P{G2Idx}

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
            'DisplayName', strcat("zeroes of ", G2_name(G2Idx)), ...
            'DisplayName', strcat("poles of ", G2_name(G2Idx)) ...
    )
    hold off
end % next G2Idx

%% add lines from origin to marker
for G2Idx=1:G2count
    % We find the zeroes
    G2_zero = G2_zpk.Z{G2Idx}
    % and poles
    G2_pole = G2_zpk.P{G2Idx}

    % get (x, y) from zeroes
    G2_zero_x = real(G2_zero);
    G2_zero_y = imag(G2_zero);
    % get (x, y) from poles
    G2_pole_x = real(G2_pole);
    G2_pole_y = imag(G2_pole);

    % combine the coordinates
    G2_coord = [ G2_zero_x' G2_pole_x'
                 G2_zero_y' G2_pole_y'];

    % loop through coordinates
    hold on
    for coord=G2_coord
        p = plot([0 coord(1)], [0 coord(2)], 'k:');
        p.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end % next coord
    hold off

end % next G2Idx

%% label the plot and grid
grid
title('Pole-zero plot')
xlabel('\sigma [rad/s]')
ylabel('j\omega [rad/s]')
legend(gca,'show')

%%
% use pzmap in subplot #2
subplot 122
for G2Idx=1:G2count
    hold on
    pzmap(G2(G2Idx))
    hold off
end % next G2Idx
grid
legend(G2_name(:))
