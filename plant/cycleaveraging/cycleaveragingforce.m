function M1 = cycleaveragingforce(alpha,omega_LW,omega_RW)
A_RW = pi/2;
A_LW = pi/2;
k_L = 1.225 * 0.5 * (0.225 + 1.58 * sin(2.13 * alpha - 7.2 * pi/180)) * 0.00000417;
k_D = 1.225 * 0.5 * (1.92 - 1.55 * cos(2.04 * alpha - 9.82 * pi/180)) * 0.00000417;
deltaA = 0;
J_1 = besselj(1,A_RW);
H_1 = StruveH1(A_LW);
eta_RW = 0;
eta_LW = 0;
delta_RW = 0;
delta_LW = 0;
sigma_RW = 0;
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

M1 = [X,Y,Z];

end