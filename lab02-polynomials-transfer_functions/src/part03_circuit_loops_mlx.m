%% Part 3 $-$ Review of solving circuit loops

clear

% Find the loop current given the loop circuit in subsection 2.5 in the
% lab report.

% symbolic variables
syms s
syms V_s

% define the parameters

% resistors
R1 = 5; % [ohm]
R2 = 2;
R3 = 2;
R4 = 1;

% inductors
L1 = 1; % [H]
L2 = 1;

% currents
C1 = 1/5; % [F]
C2 = 1/3;
C3 = 1/4;

% the columns, representing the coefficients for each current
M_I1 = [ (1/(s*C1) + R1 + s*L1 + R2); (R2 + s*L1); R1 ];
M_I2 = [ (-s*L1 - R2); (1/(s*C2) - R2 - s*L1 + s*L2 + R3); (R3 + s*L2) ];
M_I3 = [ R1; (R3 + s*L2); (R4 + 1/(s*C3) - R3 + s*L2 - R1) ];

%%
% The matrix of coefficients
M = [ M_I1, M_I2, M_I3 ]

%%
% The expected total voltage of each loop
y = [ V_s ; 0 ; 0 ]

%%
% This requires that the current

% Solve for I
I = M^-1*y

