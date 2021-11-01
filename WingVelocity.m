%Estimation of wing velocity

% Definitions: B-Body Frame; S-Spar Frame; P- Planform Frame; wr- Wing Root; ws-Wing Spar;
% wp-Wing planform; 
 
% Position vector of infinitesimal point on rigid body (r_B); spar frame (r_S), and planform (r_P)
r_P = [0; r; -c];
r_B = (CG - WR)+ R_WR_S * R_S_P * r_P;
r_S = R_P_S * r_P;

% Velocity due to rigid body rotation

V_r = @ (R_WR_S) * Wb_B * r_B;     


% Velocity due to rigid body translation

V_t = R_B_S * V_b_B;     


%Velocity due to wing flapping

V_f = R_WR_WS * dR_S_WR * r_S;  % Due to Wing Flapping

