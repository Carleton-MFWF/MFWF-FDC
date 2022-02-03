%function [v_b w_b] = Forces (F, M)

%Rigid Body Model

m = 0.04;                     % mass of MFWF in kg
g = 9.81;                   % acceleration due to gravity (in m/s2)

%W_Component = [0; 0; -g];

x_b = 0.05;                       % Breadth of body frame (in metres)
y_b = 0.25;                       % Length of body frame (in metres)
z_b = 0.15;                       % Height of flyer (in metres)
 
syms tx                        % theta 
syms ty                        % theta
syms tz                        % theta

syms v_b_x  v_b_y  v_b_z  w_b_x  w_b_y  w_b_z;       % translational velocity and angular velocity

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
 
  % Method 1
 % Forces and moment equations using 6 unknowns, 6 equations solver
 
 Fx = 0.75;
 Fy = 0.00;
 Fz = 1.00;
 Mx = -0.125;
 My = -0.0562;
 Mz = 0.0938;
 
 syms v_b_x  v_b_y  v_b_z  w_b_x  w_b_y  w_b_z;
 
 w_b_x = v_b_x;
 w_b_y = v_b_y;
 w_b_z = v_b_z; 
 
 eq1 = (0.4 * v_b_x) + 0.4 * ((w_b_y * v_b_z)-(w_b_z * v_b_y)) - Fx == 0;
 eq2 = (0.4 * v_b_y) + 0.4 * ((w_b_z * v_b_x)-(w_b_x * w_b_z)) - Fy == 0;
 eq3 = (0.4 * v_b_z) + 0.4 * ((w_b_x * v_b_y) - (w_b_y * v_b_x)) - Fz == 0;
 eq4 = (I_xx * w_b_x) + (w_b_x * (I_yy - I_zz) * w_b_x) - Mx == 0;
 eq5 = (I_yy * w_b_y) + (w_b_y * (I_zz - I_xx) * w_b_y) - My == 0;
 eq6 = (I_zz * w_b_z) + (w_b_z * (I_xx - I_yy)* w_b_z) - Mz == 0;
 
 Eq = [eq1, eq2, eq3, eq4, eq5, eq6];
 vars = [v_b_x, v_b_y, v_b_z, w_b_x, w_b_y, w_b_z];
 sol = solve(Eq, vars);

 A = double([sol.v_b_x; sol.v_b_y; sol.v_b_z; sol.w_b_x; sol.w_b_y; sol.w_b_z])
 
 %Method 2: Uising first order non-linear oDE
 % Moment in x-direction
tspan = [0 5];
x0 = 5000;
%[t,x] = ode45(@(t,x), (Mx/I_xx) - (x^2), tspan; x0);
[t,x] = ode45(@(t,x) -1.5625 - (x^2), tspan, x0);
plot (t,x,'b')
     
     
     
     


            

