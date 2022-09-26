function F = cycleAveragedForce(alpha, omega_LW, omega_RW)

% wing parameters
r = 10e-2;      % [m] wing length
c = 5e-2;       % [m] wing chord 

% Second moment of area of rectangular wing about wing root
% TODO change to numerical calculation based on actual wing shape
I_A = r^3*c/3;  % [m^4]

A_RW = pi/2; % wing amplitude 
A_LW = pi/2;
k_L = 1.225 * 0.5 * (0.225 + 1.58 * sin(2.13 * alpha - 7.2 * pi/180)) * I_A; %Calculation base on coefficient lift
k_D = 1.225 * 0.5 * (1.92 - 1.55 * cos(2.04 * alpha - 9.82 * pi/180)) * I_A; %Calculation base on coefficient drag
% I_A is area moment of inertia of wing planform
deltaA = 0; %wing amplitude adjustment
J_1 = besselj(1,A_RW); %Bessel function of order 1
H_1 = StruveH1(A_LW); %Struve function of order 1
eta_RW = 0; %wing bias
eta_LW = 0;
delta_RW = 0; %split cycle upstroke
delta_LW = 0;
sigma_RW = 0; %split cycle downstroke
sigma_LW = 0;

Z_RW = k_L * omega_RW * 0.25 * (A_RW * A_RW * (omega_RW - delta_RW) + (omega_RW + sigma_RW) * 0.5 * (A_RW * A_RW + (A_RW + deltaA) * (A_RW + deltaA)));
Z_LW = k_L * omega_LW * 0.25 * (A_LW * A_LW * (omega_LW - delta_LW) + (omega_LW + sigma_LW) * 0.5 * (A_LW * A_LW + (A_LW + deltaA) * (A_RW + deltaA)));
Z = Z_RW + Z_LW;
Y_RW = -k_D * A_RW * J_1 * (A_RW) * omega_RW * (omega_RW - delta_RW) * sin(eta_RW) * 0.5 + k_D * omega_RW * (omega_RW + sigma_RW) * 0.25 * (A_RW * (J_1 * (A_RW) * sin(eta_RW) - H_1 * (A_RW) * cos(eta_RW))) + k_D * omega_RW * (omega_RW + sigma_RW) * 0.25 * (A_RW + deltaA) * (J_1 * (A_RW + deltaA) * sin(eta_RW) + H_1 * (A_RW + deltaA) * cos(eta_RW));
Y_LW = k_D * A_LW * J_1 * (A_LW) * omega_LW * (omega_LW - delta_LW) * sin(eta_LW) * 0.5 - k_D * omega_LW * (omega_LW + sigma_LW) * 0.25 * (A_LW * (J_1 * (A_LW) * sin(eta_LW) - H_1 * (A_LW) * cos(eta_LW))) - k_D * omega_LW * (omega_LW + sigma_LW) * 0.25 * (A_LW + deltaA) * (J_1 * (A_LW + deltaA) * sin(eta_LW) + H_1 * (A_LW + deltaA) * cos(eta_LW));
Y = Y_RW + Y_LW;
X_RW = k_D * A_RW * J_1 * (A_RW) * omega_RW * (omega_RW - delta_RW) * cos(eta_RW) * 0.5 - k_D * omega_RW * (omega_RW + sigma_RW) * 0.25 * (A_RW * (J_1 * (A_RW) * cos(eta_RW) + H_1 * (A_RW) * sin(eta_RW))) - k_D * omega_RW * (omega_RW + sigma_RW) * 0.25 * (A_RW + deltaA) * (J_1 * (A_RW + deltaA) * cos(eta_RW) + H_1 * (A_RW + deltaA) * sin(eta_RW));
X_LW = k_D * A_LW * J_1 * (A_LW) * omega_LW * (omega_LW - delta_LW) * cos(eta_LW) * 0.5 - k_D * omega_LW * (omega_LW + sigma_LW) * 0.25 * (A_LW * (J_1 * (A_LW) * cos(eta_LW) + H_1 * (A_LW) * sin(eta_LW))) - k_D * omega_LW * (omega_LW + sigma_LW) * 0.25 * (A_LW + deltaA) * (J_1 * (A_LW + deltaA) * cos(eta_LW) + H_1 * (A_LW + deltaA) * sin(eta_LW));
X = X_RW + X_LW;

F = [X,Y,Z];

end