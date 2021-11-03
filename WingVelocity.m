%Estimation of wing velocity

% Definitions: B-Body Frame; S-Spar Frame; P- Planform Frame; wr- Wing Root; ws-Wing Spar;
% wp-Wing planform; 

 C.G = [0 0 0 ];        % Centre of gravity of body frame.
 WR = ;                 % 
 
 u= 1;    % upstroke 
 d = -1;  % downstroke 
 
% Position vector of infinitesimal point on body frame(r_B); spar frame (r_S), and planform (r_P)
r_P = [0; r; -c];                           %Position vector of infinitesimal point on wing planform (r_P)
r_B = (CG - WR)+ R_WR_S * R_S_P * r_P;      %Position vector of infinitesimal point on rigid body (r_B)
r_S = R_P_S * r_P;                          %Position vector of infinitesimal point on spar frame (r_S)

% Velocity due to rigid body rotation
V_r = @ (R_WR_S) * Wb_B * r_B; 

if s = 1
V_r_u = @ (R_WR_S)* u * Wb_B * r_B;  % Right Upstroke
end 

if s = -1
V_r_d = @ (R_WR_S)* d * Wb_B * r_B;  % Downstroke 
end 


% Velocity due to rigid body translation

V_t = R_B_S * V_b_B;     


%Velocity due to wing flapping

V_f = R_WR_S * dR_WR_S * r_S;  % Due to Wing Flapping

