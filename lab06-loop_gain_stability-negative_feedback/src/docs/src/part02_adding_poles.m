%% part02_adding_poles.m
% Compares the resulting transfer functions of adding a nonpositive
% real root and a positive real root.
% By      : Leomar Duran
% When    : 2023-03-09t22:53
% For     : ECE 3413 Classical Control Systems
%

clear

%% The reference transfer function
G2_ref = tf(25, [1 4 25])

%% The new poles.
a_R = 200
% We also add an equivalent gain so that the new transfer function is
% within the original magnitude.
newPoles = [
    zpk([], [-a_R], a_R) ;
    zpk([], [+a_R], a_R)
]
% the number of poles
nPoles = numel(newPoles);

for k=1:nPoles
    % new reference figure
    figure(k)
    % create third order function
    G2_3o = (G2_ref * newPoles(k))
    % transient response
    stepinfo(G2_3o)
    % the poles and zeroes
    subplot 121
    pzmap(G2_3o)
    % step response of reference
    subplot 122
    step(G2_ref)
    % add the new pole to step response
    hold on
    step(G2_3o)
    hold off
    % label it
    legend("G2 reference", ...
        strcat("G2 with extra pole ", string(newPoles.P{k})) ...
    )
end % next k
