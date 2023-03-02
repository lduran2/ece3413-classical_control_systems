%% Part 1 $-$ Translational mechanical system

clear

% masses
M1 = 1; % [kg]
M2 = 1; % [kg]
M3 = 1; % [kg]
% spring constants
K1 = 1; % [N/m]
K2 = 1; % [N/m]
% damping constants
D1 = 1; % [Ns/m]
D2 = 1; % [Ns/m]

%% As a state-space model
% is represented by the matrices of coefficients
Mssr = ss( ...
    [   [+D1 K1 -D1   0  0   0]/M1;
           1  0   0   0  0   0    ;
        [+D1  0 -D1 -K2  0 +K2]/M2;
           0  0   1   0  0   0    ;
        [  0  0   0 -K2 D2 +K2]/M3;
           0  0   0   0  1   0
    ], ...
    [1 0 0 0 0 0]', ...
    [      0  0   0   0  0   1     ], ...
    0 ...
)
