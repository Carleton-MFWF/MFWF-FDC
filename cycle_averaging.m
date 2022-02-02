% X_RW,Y_RW,Z_RW,X_LW,Y_LW,Z_LW is the right and left cycle averaging x,y,z body axis force.
%A_RW,A_LW is wing beat amplitudes (constant)pi/2 to -pi/2.
%omega_RW,omega_LW is wing beat frequency. (input) 
%delta_LW,delta_RW is left and right wing upstroke split-cycle parameters (0).
%sigma_RW,sigma_LW is left and right wing downstroke split-cycle parameters (0).
%deltaA_RW,DELTA_LW is left and right wing amplitude adjustment terms (0).
%H_1 is struve function of order 1.
%J_1 is Bessel function of order 1.
%k_L = density * 0.5 * C_L * (alpha) * I_A (alpha - input)
%k_D = density * 0.5 * C_D * (alpha) * I_A (alpha - input)
%eta_RW, eta_LW is the left and right wing bias (0).
%
X_RW = k_L * omega_RW * 0.25 * (A_RW * A_RW * (omega_RW - delta_RW) + (omega_RW + sigma_RW) * 0.5 * {A_RW * A_RW + (A_RW + deltaA_RW)});
X_LW = k_L * omega_LW * 0.25 * (A_LW * A_LW * (omega_LW - delta_LW) + (omega_LW + sigma_LW) * 0.5 * {A_LW * A_LW + (A_LW + deltaA_LW)});
Y_RW = -k_D * A_RW * J_1 * (A_RW) * omega_RW * (omega_RW - delta_RW) * sin(eta_RW) * 0.5 + k_D * omega_RW * (omega_RW + sigma_RW) * 0.25 * (A_RW * (J_1 * (A_RW) * sin(eta_RW) - H_1 * (A_RW) * cos(eta_RW))) + k_D * omega_RW * (omega_RW + sigma_RW) * 0.25 * (A_RW + deltaA_RW) * (J_1 * (A_RW + deltaA_RW) * sin(eta_RW) + H_1 * (A_RW + deltaA_RW) * cos(eta_RW));
Y_LW = k_D * A_LW * J_1 * (A_LW) * omega_LW * (omega_LW - delta_LW) * sin(eta_LW) * 0.5 - k_D * omega_LW * (omega_LW + sigma_LW) * 0.25 * (A_LW * (J_1 * (A_LW) * sin(eta_LW) - H_1 * (A_LW) * cos(eta_LW))) - k_D * omega_LW * (omega_LW + sigma_LW) * 0.25 * (A_LW + deltaA_LW) * (J_1 * (A_LW + deltaA_LW) * sin(eta_LW) + H_1 * (A_LW + deltaA_LW) * cos(eta_LW));
Z_RW = k_D * A_RW * J_1 * (A_RW) * omega_RW * (omwga_RW - delta_RW) * cos(eta_RW) * 0.5 - k_D * omega_RW * (omega_RW + sigma_RW) * 0.25 * (A_RW * (J_1 * (A_RW) * COS(eta_RW) + H_1 * (A_RW) * sin(eta_RW))) - k_D * omega_RW * (omega_RW + sigma_RW) * 0.25 * (A_RW + deltaA_RW) * (J_1 * (A_RW + deltaA_RW) * cos(eta_RW) + H_1 * (A_RW + deltaA_RW) * sin(eta_RW));
Z_LW = k_D * A_LW * J_1 * (A_LW) * omega_LW * (omwga_LW - delta_LW) * cos(eta_LW) * 0.5 - k_D * omega_LW * (omega_LW + sigma_LW) * 0.25 * (A_LW * (J_1 * (A_LW) * COS(eta_LW) + H_1 * (A_LW) * sin(eta_LW))) - k_D * omega_LW * (omega_LW + sigma_LW) * 0.25 * (A_LW + deltaA_LW) * (J_1 * (A_LW + deltaA_LW) * cos(eta_LW) + H_1 * (A_LW + deltaA_LW) * sin(eta_LW));