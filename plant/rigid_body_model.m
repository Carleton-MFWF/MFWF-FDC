%Rigid Body Model

% The system is modelled as an ODE, with q defined as a 12- element state
% vector

function qDOT = rigid_body_model(t, q, m, I, FM_at_t)

g = 9.81;                   % acceleration due to gravity (in m/s2)

% extracting forces and moments
FM = FM_at_t(t);
F = FM(1:3);            % Force vector
M = FM(4:6);            % Moment vector

% extract components from STATE Vector
v_B   = q(1:3);           % (m/s), translational velocity
w     = q(4:6);           % (rad/s), angular velocity
e     = q(7:9);           % (rad/s), euler angles
PosI = q(10:12);          % (m), Inertia frames position

% Force equation, F = m * V_B + m * w_x_v) Translational equation of motion
vDOT = F/M - cross(w, v_B);

% Moment equation, M = I * wDOT + w_x_(I * w) Rotational equation of motion
wDOT = inv(I) * (M - cross(w, I * w));

% euler rates from body rates
eDOT = LOC_get_eDOT(w,e);

%Inertial Velocity
R_I_B = LOC_get_R_I_B(e);
%B_I_R = R_I_B.';
PosIDOT = R_I_B * [0; 0; g] * v_B ;        

% assembling the final derivative vector
qDOT = [vDOT;
        wDOT; 
        eDOT;
        PosIDOT];

end

function R_I_B = LOC_get_R_I_B(e)

ph = e(1);
th = e(2);
ps = e(3);

R_I_B = [cos(th)*cps              cos (th)*sps              -sin(th);
               sin(ph)*sin(th)*cos(ps)-cos(ph)*sin(ps)  sin(ph)*sin(th)*sin(ps)+cos(ph)*cos(ps)  sin(ph)*cos(th);
               cos(ph)*sin(th)*cos(ps)+sin(ph)*sin(ps)  cos(ph)*sin(th)*sin(ps)-sin(ph)*cos(ps)  cos(ph)*cos(th)];
end

function euler_rates = LOC_get_eDOT(w,e)
 p= w(1);
 q = w(2);
 r = w(3);
 
 ph = e(1);
 th = e(2);
 ps = e(3);

euler_rates = [(r.* cos (ps) + q.* sin(ps))./cos(th);
                q.* cos(ps) - r.* sin(ps);
                (p.* cos(th) + r.* cos(ps).* sin(th) + q.* sin(ps).* sin(th))./cos(th)];
end
  
% Defining Flyer Mass, Inertia and Initial Conditions

%Inertia Tensor (assumption of perfect plane of symmetry) (kg.m^2)
%I_xx = 0.0034;
%I_yy = 0.001;
%I_zz = 0.0026;

%K = [0.0034  0  0; 0  0.001  0; 0   0  0.0026;];
I = [ 0.0034 0 0 ; 0 0.001 0 ; 0 0 0.0026 ];
 
 %Flyer Initial Conditions
 v_B_Initial = [0;0;0];     % (m/s) initial velocity in body axes
 w_Initial = [0;0;0];       % (rad/s) initial body rates
 e_Initial = [0;0;0];       % (rad) initial euler angles
 PosI_Initial = [0;0;0];    % (m) initial position in inertial axes
 
 % state vector initial conditions
 
 q_Initial = [VDOT_Initial;
                wDOT_Initial;
                eDOT_Initial;
                PosIDOT_Initial;];
           
%Solving the System
% FM_at_t = @(t)     to get input of forces and moments
dqdt_at_t = @ (t,q) rigid_body_model(t, q, m, I, FM_at_t);

%defining some ODE solver settings
t_span = [0 60];    % sec, [tstart tend]
my_options = odeset('ReTol', 1e-7, 'AbsTol', 1e-7);          % seconds

% using ODE solver
[T, qDOT] = ode45(dqdt_at_t, tspan, q_Initial, my_options);

figure 1;
plot(T, qDOT, 'b')
 

























































%{ 
W_Component = [0; 0; -g];

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
 
 
 %Method 2: Uising first order non-linear oDE
% Moment in x-direction
% Moment in x-direction
tspan = [0 5];
x0 = 0.5;
%[t,x] = ode45(@(t,x), (Mx/I_xx) - (x^2), tspan; x0);
[t,x] = ode45(@(t,x) -1.5625 - (x^2), tspan, x0);
%plot (t,x,'b')

% Moment in y-direction
tspan = [0 5];
y0 = 0.5;
%[t,x] = ode45(@(t,x), (My/I_yy) - (x^2), tspan; x0);
[t,y] = ode45(@(t,y) -0.7025 - (y^2), tspan, y0);
%plot (t,y,'b')

% Moment in z-direction
tspan = [0 5];
z0 = 0.5;
%[t,x] = ode45(@(t,x), (My/I_yy) - (x^2), tspan; x0);
[t,z] = ode45(@(t,z) -1.1725 - (z^2), tspan, z0);

%plot (t,z,'b')

figure(1)
plot (t, x, 'b', t, y, 'b', t, z, 'b')

%plot(t, x, 'b')
%hold on
%plot(t, y, 'y')
%plot(t, z, 'r')
%hold off
grid
xlabel('Time (s)')
ylabel ('Angular velocity (rad/s, E-14)')
title('Instantenous angular velocity vs time')
%legend('w_x', 'w_y', 'w_z', 'Location', 'SW')
 %}




























































































































% syms v_b_x  v_b_y  v_b_z  w_b_x  w_b_y  w_b_z;
 
% w_b_x = v_b_x;
% w_b_y = v_b_y;
% w_b_z = v_b_z; 
 
% eq1 = (0.4 * v_b_x) + 0.4 * ((w_b_y * v_b_z)-(w_b_z * v_b_y)) - Fx == 0;
% eq2 = (0.4 * v_b_y) + 0.4 * ((w_b_z * v_b_x)-(w_b_x * w_b_z)) - Fy == 0;
% eq3 = (0.4 * v_b_z) + 0.4 * ((w_b_x * v_b_y) - (w_b_y * v_b_x)) - Fz == 0;
% eq4 = (I_xx * w_b_x) + (w_b_x * (I_yy - I_zz) * w_b_x) - Mx == 0;
% eq5 = (I_yy * w_b_y) + (w_b_y * (I_zz - I_xx) * w_b_y) - My == 0;
% eq6 = (I_zz * w_b_z) + (w_b_z * (I_xx - I_yy)* w_b_z) - Mz == 0;
 
% Eq = [eq1, eq2, eq3, eq4, eq5, eq6];
% vars = [v_b_x, v_b_y, v_b_z, w_b_x, w_b_y, w_b_z];
% sol = solve(Eq, vars);

% A = double([sol.v_b_x; sol.v_b_y; sol.v_b_z; sol.w_b_x; sol.w_b_y; sol.w_b_z])%}     
     
     
     


            

