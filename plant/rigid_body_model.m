function [w, v] = Forces (F, M)

%Rigid Body Model

m = 0.04;                     % mass of MFWF in kg
g = 9.81;                   % acceleration due to gravity (in m/s2)

x_b = 0.05;                       % Breadth of body frame (in metres)
y_b = 0.25;                       % Length of body frame (in metres)
z_b = 0.15;                       % Height of flyer (in metres)

syms p                         % stroke angle 
syms t                         % theta 
syms a                         % alpha

phi = 30;
theta = 30;

% Rotation matrice from inertial frame to body frame
R_I_B = [ 

% Mass Moment of Inertia across x,y and z axes
I_xx = (square(y_b) + square(z_b)) * m;
I_yy = (square(x_b) + square(z_b)) * m;
I_zz = (square(x_b) + square(y_b)) * m;

%Inertia Tensor (assumption of perfect plane of symmetry)
I = [I_xx  0  0;
     0  I_yy  0;
     0   0  I_zz];
     
     
     
     


            

