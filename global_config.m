% simulation constants

g = [0,0,-9.81]; % [m/s/s] gravitational acceleration
CG = [0, 0, 0]; % [m] location of centre of gravity in initial inertial frame
WR = [ ]; % origin of wing root. 

%Definition of Coordinates Frames
    % X-axis: pointing out of page
    % Y-axis: pointing towards right
    % Z-zxis: pointing upwards

    % Angles or Rotation with respect to wing planform, wing spar and wing root
    % Input:Theta(θ)
TX = theta_x ; %[degrees] rotation about the X-axis
TY = theta_y; %[degrees] rotation about the Y-axis
TZ = theta_z; %[degrees] rotation about the Z-axis

    %Phil(φ): Stroke angle between wing spar and wing root from top view
PH = Phil;

% Alpha (α): Angle of attack between wing spar and wing planform from right view
% Input: 
   AL = Alpha; 

%Rotational Matices about rigid body frame [X,Y,Z]
R1 = [1 0 0; 0 cos theta_x sin theta_x; 0 -sin theta_x cos theta_x]; %Rotational Matices about X-axis
R2 = [cos theta_y 0 -sin theta_y; 0 1 0; sin theta_y 0 cos theta_y];  %Rotational Matices about Y-axis
R3 = [cos theta_z sin theta_z 0; sin theta_z cos theta_z 0; 0 0 1];   %Rotational Matices about Z-axis

%Wing Planform Coordinate
    % Input: r [m] spar position (length of spar)
    % Input: c [m] chord length
    
r_P = [0; r; -c];  % With repect to X-Y-Z rigid body coordinates

% Wing Definition (s) = Left Wing (-1) and Right Wing (1) respectively 
s = [-1 ; 1];

% Wing Stroke (sn): diff(PH) = Upstroke (-1) and Downstroke (1) respectively
sn(diff(PH))= [-1; 1];

% Relations between body frame and wing planform frames
R_B_WR = [ ];   % Rotation Matrices of rigid body on wing root frame 
R_P_S = [ ];    % Rotation Matrices of wing spar in spar frame
R_S_WR = [ ];   % Rotation Matrices from wing spar to wing root frame








