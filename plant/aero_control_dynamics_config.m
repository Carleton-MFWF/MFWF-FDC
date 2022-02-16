% command column - degrees
% F_x, F_y, F_z - gf
% M_x, M_y, M_z - Nmm

%% flapping frequency gain constants
K_w_F = 1; % [1/Hz]
K_w_M = 1; % [1/Hz]

%% conversions
gf2N = 1/101.971621;
Nmm2Nm = 1/1000;

%% Data Tables
% pitch
pitch_force = readtable('./data/control_dynamics/pitch_force.csv');
pitch_moment = readtable('./data/control_dynamics/pitch_moment.csv');

% roll
roll_force = readtable('./data/control_dynamics/roll_force.csv');
roll_moment = readtable('./data/control_dynamics/roll_moment.csv');

% yaw
yaw_force = readtable('./data/control_dynamics/yaw_force.csv');
yaw_moment = readtable('./data/control_dynamics/yaw_moment.csv');