function [w, v] = Forces (F, M)

%Rigid Body Model

m = 0.04;                     % mass of MFWF in kg
g = 9.81;                   % acceleration due to gravity (in m/s2)

W_Component =

x_b = 0.05;                       % Breadth of body frame (in metres)
y_b = 0.25;                       % Length of body frame (in metres)
z_b = 0.15;                       % Height of flyer (in metres)
 
syms tx                        % theta 
syms ty                        % theta
syms tz                        % theta

tx = 30;
ty = 30;
tz = 30;

% Rotation matrice from inertial frame to body frame
R_1 = [1 0 0; 
    0 cos(tx) sin(tx);
    0  -sin(tx) cos(tx)];

R_2 = [cos(ty) 0 -sin(ty);
       0 1 0;
      sin(ty) 0 cos(ty)];
    
R_3 = [cos(tz) sin(tz) 0;
    sin(tz) cos(tz) 0;
    0 0 1];

R_I_B = R_1 * R_2 * R_3;

% Mass Moment of Inertia across x,y and z axes
I_xx = (square(y_b) + square(z_b)) * m;
I_yy = (square(x_b) + square(z_b)) * m;
I_zz = (square(x_b) + square(y_b)) * m;

%Inertia Tensor (assumption of perfect plane of symmetry)
I = [I_xx  0  0;
     0  I_yy  0;
     0   0  I_zz];
 
 
     
     
     
     


            

