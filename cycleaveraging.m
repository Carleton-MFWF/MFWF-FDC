function X_RW = cycleaveraging(alpha, omega_RW)
% X_RW,Y_RW,Z_RW,X_LW,Y_LW,Z_LW is the right and left cycle averaging x,y,z body axis force.
%A_RW,A_LW is wing beat amplitudes (constant)-pi/2 or pi/2.
%omega_RW,omega_LW is wing beat frequency. (input) 
%delta_LW,delta_RW is left and right wing upstroke split-cycle parameters (0).
%sigma_RW,sigma_LW is left and right wing downstroke split-cycle parameters (0).
%deltaA_RW,DELTA_LW is left and right wing amplitude adjustment terms (0).
%H_1 is struve function of order 1.
%J_1 is Bessel function of order 1.
%k_L = density * 0.5 * C_L * (alpha) * I_A (alpha - input) (set I_A is 1)
%k_D = density * 0.5 * C_D * (alpha) * I_A (alpha - input) (set I_A is 1)
%eta_RW, eta_LW is the left and right wing bias (0).
%I_A is area moment of inertia of the plantform (constant)
A_RW = pi;
k_L = 1.29 * 0.5 * (0.225 + 1.58 * sin(2.13 * alpha - 7.2 * pi/180)) * 0.00000417;
X_RW = k_L * omega_RW * 0.25 * (A_RW * A_RW * (omega_RW) + (omega_RW) * 0.5 * (A_RW * A_RW + (A_RW)));

end