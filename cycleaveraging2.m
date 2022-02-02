function Z_RW = cycleaveraging2(alpha1,omega_RW)
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

A_RW = pi/2;
k_D = 1 * 0.5 * (1.92 - 1.55 * cos(2.04 * alpha1 - 9.82 * pi/180)) * 1;
J = besselj(1,1);

Z_RW = k_D * A_RW * J * (A_RW) * omega_RW * (omega_RW) * 1 * 0.5 - k_D * omega_RW * (omega_RW) * 0.25 * (A_RW * (J * (A_RW) * 1)) - k_D * omega_RW * (omega_RW) * 0.25 * (A_RW) * (J * (A_RW) * 1);
 

end