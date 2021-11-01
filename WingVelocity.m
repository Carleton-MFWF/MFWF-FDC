%Estimation of wing velocity

% Input:Theta(θ)
TX = theta_x ; %[degrees] rotation about the X-axis
TY = theta_y; %[degrees] rotation about the Y-axis
TZ = theta_z; %[degrees] rotation about the Z-axis

% Wing Definition (s) = Left Wing (-1) and Right Wing (1) respectively 
s = [-1 ; 1];

% Wing Stroke (sn): diff(PH) = Upstroke (-1) and Downstroke (1) respectively
sn(diff(PH))= [-1; 1];

% Variable Definition 
%Vx= Rigid body velocity in X-axis
%Vy= Rigid body velocity in Y-axis
%Vz= Rigid body velocity in Z-axis
V_b_B = [Vx; Vy; Vz];

% Definitions
%B-Body Frame; S-Spar Frame; P- Planform Frame; wr- Wing Root; ws-Wing Spar;
% wp-Wing planform; 

R_B_S = [ ];    % Rotation Matrices of rigd body in spar frame 

R_WR_WS = [ ];  % Rotation Matrices of wing root on wing spar

R_B_WR = [ ];   % Rotation Matrices of rigid body on wing root frame

R_P_S = [ ];    % Rotation Matrices of wing spar in spar frame

R_S_WR = [ ];   % Rotation Matrices from wing spar to wing root frame

CG = [0, 0, 0]; % [m] location of centre of gravity in initial inertial frame
WR = [ ]; % origin of wing root in body frame. 

% Position of spar on rigid body (r_B); spar frame (r_S) and planform (r_P)
r_P = [0; r; -c];
r_B = (CG - WR)+ R_WR_WS * R_P_S * r_P;
r_S = R_P_S * r_P;

%time for MFWF in motion
t = 40;
% Angular velocity of rigid body in motion (Wb_B)
Wb_B = diff([TX; TY; TZ],t);

%Derivative of spar in wing root frame(R_S_WR)
dR_S_WR = diff(R_S_WR, t);


%Wing Velocity (Free stream velocity)
V_t = R_B_S * V_b_B;            % Due to Rigid Body Translation
V_r = R_WR_WS * Wb_B * r_B;     % Due to Rigid Body Rotation
V_f = R_WR_WS * dR_S_WR * r_S;  % Due to Wing Flapping

