%Estimation of wing velocity
function R = R_I_B(TH)

% Definitions: B-Body Frame; S-Spar Frame; P- Planform Frame; wr- Wing Root; ws-Wing Spar;
% wp-Wing planform; 

 R1 = [1 0 0; 0 cos TH sin TH; 0 -sin TH cos TH];
 R2 = [cos TH 0 -sin TH; 0 1 0; sin TH 0 cos TH];
 R3 = [cos TH sin TH 0; sin TH cos TH 0; 0 0 1]; 
 
 
 C.G = [0 0 0 ];        % Centre of gravity of body frame.
 WR = I;                % origin of wing root
 
 % Rotation of rigid body from inertial frame to body frame
 R_I_B = R1 * R2 * R3;
 
 % rotation of body frame in spar frame coordinates
 R_B_S = @(s, phi) R_WR_S(s, phi) * @(a, alpha_p) R_S_P(a, alpha_p); 

 % Wing movements definition 
 u= 1;    % upstroke 
 d = -1;  % downstroke 
 
% Position vector of infinitesimal point on body frame(r_B); spar frame (r_S), and planform (r_P)
r_P = [0; r; -c];                           %Position vector of infinitesimal point on wing planform (r_P)
r_B = (CG - WR)+ R_WR_S * R_S_P * r_P;      %Position vector of infinitesimal point on rigid body (r_B)
r_S = R_P_S * r_P;                          %Position vector of infinitesimal point on spar frame (r_S)

% Velocity due to rigid body rotation

Wb_B = transpose(R_I_B) * ;
V_r = @ (R_WR_S) * Wb_B * r_B; 

if s = 1 & u = 1 
V_r_u = @ (R_WR_S)* u * Wb_B * r_B;  % right and left wing upstroke
end 

if s = -1 & d = -1
V_r_d = @ (R_WR_S)* d * Wb_B * r_B;  % right and left wing downstroke 
end 


% Velocity due to rigid body translation

 r_WR_CG =      % position vector for centre of gravity of rigid body to wing root
 Vb =           % Linear velocity of rigid body in body frame
 
 V_b_B = V + (Wb_B * r_WR_CG)       % evaluation of rigid body velocity 
 
 V_t = R_B_S * V_b_B;     


%Velocity due to wing flapping

V_f = R_WR_S * dR_WR_S * r_S;  % Due to Wing Flapping

