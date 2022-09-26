function M = cycleAveragedMoment(alpha,omega_LW,omega_RW)
%% Constants

% wing amplitude 
A_RW = pi/2;    % [rad]
A_LW = pi/2;    % [rad]

% wing parameters
r = 10e-2;      % [m] wing length
c = 5e-2;       % [m] wing chord 

% Second moment of area of rectangular wing about wing root
% TODO change to numerical calculation based on actual wing shape
I_A = r^3*c/3;  % [m^4]

% Calculation base on coefficient drag
k_D = 1.225 * 0.5 * (1.92 - 1.55 * cos(2.04 * alpha - 9.82 * pi/180)) * I_A; 
% Calculation base on coefficient lift
k_L = 1.225 * 0.5 * (0.225 + 1.58 * sin(2.13 * alpha - 7.2 * pi/180)) * I_A; 

% I_A is area moment of inertia of wing planform
deltaA = 0; %wing amplitude adjustment

J = besselj(1,A_LW); %Bessel function of order 1
J1 = besselj(1,A_LW + deltaA); %Bessel function of order 1 at the wing amplitude change adjustment

H = StruveH1(A_LW); %Struve function of order 1
H1 = StruveH1(A_LW + deltaA); %Struve function of order 1 at the wing amplitude change adjustment

% wing bias
eta_RW = 0; 
eta_LW = 0;

% split cycle upstroke
delta_RW = 0;
delta_LW = 0;

% split cycle downstroke
sigma_RW = 0; 
sigma_LW = 0;

% vehicle width
w = 5e-2;       % [m] 

% location of wing center of pressure in local wing planform frame
x_cp = 0;       % [m]
y_cp = 2.5e-2;  % [m]
z_cp = 7.5e-2;  % [m]

%vector from center of gravity to left or right wing root in body frame.
deltaz = 2.5e-2;% [m]
deltax = 0;     % [m]

%% Account for NaN generated when wing bias is zero
if eta_RW ~= 0
    kx_RW = J * sin(eta_RW) * (-k_D * (sin(alpha) * z_cp + deltaz) - cos(alpha) * z_cp * k_L - y_cp * k_L * cos(eta_RW) / sin(eta_RW));
else
    kx_RW = 0;
end

if eta_LW ~= 0
    kx_LW = J * sin(eta_LW) * (-k_D * (sin(alpha) * z_cp + deltaz) - cos(alpha) * z_cp * k_L - y_cp * k_L * cos(eta_LW) / sin(eta_LW));
else
    kx_LW = 0;
end

%% Moment about x-axis (roll)
% Right Wing
Mx_RW =  A_RW * omega_RW * (omega_RW - delta_RW) * 0.5 * (kx_RW - w * k_L * A_RW * 0.25) + k_D * A_RW * omega_RW * (omega_RW + sigma_RW) * 0.25 * (sin(alpha) * z_cp + deltaz) * (J * sin(eta_RW) - H * cos(eta_RW)) - k_L * A_RW * omega_RW * (omega_RW + sigma_RW) * 0.25 * (-cos(alpha) * z_cp * (J * sin(eta_RW) - H * cos(eta_RW)) + y_cp * (J * cos(eta_RW) + H * sin(eta_RW)) + w * A_RW * 0.25) + k_D * (A_RW + deltaA) * omega_RW * (omega_RW + sigma_RW) * 0.25 * (sin(alpha) * z_cp + deltaz) * (J1 * sin(eta_RW) + H1 * cos(eta_RW)) - k_L * (A_RW + deltaA) * omega_RW * (omega_RW + sigma_RW) * 0.25 * (-cos(alpha) * z_cp * (J1 * sin(eta_RW) + H1 * cos(eta_RW)) + y_cp * (J1 * cos(eta_RW) - H1 * sin(eta_RW)) + w * (A_RW + deltaA) * 0.25);
% Left Wing
Mx_LW = -A_LW * omega_LW * (omega_LW - delta_LW) * 0.5 * (kx_LW - w * k_L * A_LW * 0.25) - k_D * A_LW * omega_LW * (omega_LW + sigma_LW) * 0.25 * (sin(alpha) * z_cp + deltaz) * (J * sin(eta_LW) - H * cos(eta_LW)) + k_L * A_LW * omega_LW * (omega_LW + sigma_LW) * 0.25 * (-cos(alpha) * z_cp * (J * sin(eta_LW) - H * cos(eta_LW)) + y_cp * (J * cos(eta_LW) + H * sin(eta_LW)) + w * A_LW * 0.25) - k_D * (A_LW + deltaA) * omega_LW * (omega_LW + sigma_LW) * 0.25 * (sin(alpha) * z_cp + deltaz) * (J1 * sin(eta_LW) + H1 * cos(eta_LW)) + k_L * (A_LW + deltaA) * omega_LW * (omega_LW + sigma_LW) * 0.25 * (-cos(alpha) * z_cp * (J1 * sin(eta_LW) + H1 * cos(eta_LW)) + y_cp * (J1 * cos(eta_LW) - H1 * sin(eta_LW)) + w * (A_LW + deltaA) * 0.25);
% combine left and right wing
Mx = Mx_RW + Mx_LW;

%% Moment about y-axis (pitch)
% Right Wing
My_RW1 = - A_RW * omega_RW * (omega_RW - delta_RW) * 0.5 * (cos(alpha) * x_cp * k_L + (sin(alpha) * x_cp + deltaz) * k_D) * (J * cos(eta_RW) - y_cp * k_L * J * sin(eta_RW) - deltax * k_L * A_RW * 0.5);
My_RW2 = omega_RW * (omega_RW + sigma_RW) * 0.25 / A_RW * (cos(alpha) * x_cp * k_L + (sin(alpha) * x_cp + deltaz) * k_D) * (A_RW * A_RW * (J * cos(eta_RW) + H * sin(eta_RW)) + A_RW * (A_RW + deltaA) * (J1 * cos(eta_RW) - H1 * sin(eta_RW)));
My_RW3 = y_cp * k_L * omega_RW * (omega_RW + sigma_RW) * 0.25 / A_RW * (A_RW * A_RW * (J * sin(eta_RW)- H * cos(eta_RW)) + A_RW * (A_RW + deltaA) * (J1 * sin(eta_RW) + H1 * cos(eta_RW)));
My_RW4 = deltax * k_L * omega_RW * (omega_RW + sigma_RW) * 0.125 * (A_RW * A_RW + (A_RW + deltaA) * (A_RW + deltaA));
My_RW =  My_RW1 + My_RW2 + My_RW3 + My_RW4;

% Left Wing
My_LW1 = - A_LW * omega_LW * (omega_LW - delta_LW) * 0.5 * (cos(alpha) * x_cp * k_L + (sin(alpha) * x_cp + deltaz) * k_D) * (J * cos(eta_LW) - y_cp * k_L * J * sin(eta_LW) - deltax * k_L * A_LW * 0.5);
My_LW2 = omega_LW * (omega_LW + sigma_LW) * 0.25 / A_LW * (cos(alpha) * x_cp * k_L + (sin(alpha) * x_cp + deltaz) * k_D) * (A_LW * A_LW * (J * cos(eta_LW) + H * sin(eta_LW)) + A_LW * (A_LW + deltaA) * (J1 * cos(eta_LW) - H1 * sin(eta_LW)));
My_LW3 = y_cp * k_L * omega_LW * (omega_LW + sigma_LW) * 0.25 / A_LW * (A_LW * A_LW * (J * sin(eta_LW) - H * cos(eta_LW)) + A_LW * (A_LW + deltaA) * (J1 * sin(eta_LW) + H1 * cos(eta_LW)));
My_LW4 = deltax * k_L * omega_LW * (omega_LW + sigma_LW) * 0.125 * (A_LW * A_LW + (A_LW + deltaA) * (A_LW + deltaA));
My_LW = My_LW1 + My_LW2 + My_LW3 + My_LW4;

% combine left and right wing
My = My_RW + My_LW;

%% Moment about z-axis (yaw)
% Right Wing
Mz_RW = k_D * A_RW * omega_RW * (omega_RW - delta_RW) * 0.25 * (y_cp * A_RW + J * (w * cos(eta_RW) + 2 * deltaz * sin(eta_RW))) - k_D * A_RW * omega_RW * (omega_RW + sigma_RW) * 0.125 * (y_cp * A_RW + w * (J * cos(eta_RW) + H * sin(eta_RW)) + 2 * deltaz * (J * sin(eta_RW) - H * cos(eta_RW))) - k_D * (A_RW + deltaA) * omega_RW * (omega_RW + sigma_RW) * 0.125 * (y_cp * (A_RW + deltaA) + w * (J1 * cos(eta_RW) + H1 * sin(eta_RW))) - k_D * (A_RW + deltaA) * omega_RW * (omega_RW + sigma_RW) * 0.125 * (2* deltaz * (J1 * sin(eta_RW) + H1 * cos(eta_RW)));
% Left Wing
Mz_LW = - k_D * A_LW * omega_LW * (omega_LW - delta_LW) * 0.25 * (y_cp * A_LW + J * (w * cos(eta_LW) + 2 * deltaz * sin(eta_LW))) + k_D * A_LW * omega_LW * (omega_LW + sigma_LW) * 0.125 * (y_cp * A_LW + w * (J * cos(eta_LW) + H * sin(eta_LW)) + 2 * deltaz * (J * sin(eta_LW) - H * cos(eta_LW))) + k_D * (A_LW + deltaA) * omega_LW * (omega_LW + sigma_LW) * 0.125 * (y_cp * (A_LW + deltaA) + w * (J1 * cos(eta_LW) + H1 * sin(eta_LW))) + k_D * (A_LW + deltaA) * omega_LW * (omega_LW + sigma_LW) * 0.125 * (2* deltaz * (J1 * sin(eta_LW) + H1 * cos(eta_LW)));
% combine left and right wing
Mz = Mz_RW + Mz_LW;

%% Moments as vector
M = [Mx,My,Mz];
