%Estimation of wing velocity
function Vw = Vw_P(r,c)                           % Free stream velocity on planform frame with respect to wing spar length and chord length              

% Definitions: B-Body Frame; S-Spar Frame; P- Planform Frame; wr- Wing Root; ws-Wing Spar;
% wp-Wing planform; 

 r_C.G = [0 0 0];        % Centre of gravity of body frame.
 r_WR = [ ];             % origin of wing root/ positoon vector of wing root
 t = ;                   % estimated flight time
 
 R_I_B(TH)= ;                                           % TH- standard rotation angle theta
 R1 = [1 0 0; 0 cos TH sin TH; 0 -sin TH cos TH];
 R2 = [cos TH 0 -sin TH; 0 1 0; sin TH 0 cos TH];
 R3 = [cos TH sin TH 0; sin TH cos TH 0; 0 0 1]; 
 
 % Rotation of rigid body from inertial frame to body frame
 R_I_B = R1 * R2 * R3;
 
 
 % rotation of body frame in spar frame coordinates
 R_B_S = @(s, phi) R_WR_S(s, phi) * @(a, alpha_p) R_S_P(a, alpha_p); 

 % Wing movements definition 
 u= 1;    % upstroke 
 d = -1;  % downstroke 
 
% Position vector of infinitesimal point on body frame(r_B); spar frame (r_S), and planform (r_P)
r_P = [0; r; -c];                           %Position vector of infinitesimal point on wing planform (r_P)
r_B = (r_CG - r_WR)+ R_WR_S * R_S_P * r_P;  %Position vector of infinitesimal point on rigid body (r_B)
r_S = R_P_S * r_P;                          %Position vector of infinitesimal point on spar frame (r_S)

% Velocity due to rigid body rotation

Wb_B = transpose(R_I_B);                % angular velocity of body frame with reepect to chaning theta with time                   % 
V_r = @ (R_WR_S) * Wb_B * r_B;          % FINAL 1

if s = 1 & u = 1 
V_r_u = @(s, phi) R_WR_S(s, phi))* u * Wb_B * r_B;  % right and left wing upstroke
end 

if s = -1 & d = -1
V_r_d = @(s, phi) R_WR_S(s, phi)* d * Wb_B * r_B;  % right and left wing downstroke 
end 


% Velocity due to rigid body translation

 r_WR_CG = r_WR - r_CG;    % position vector for centre of gravity of rigid body to wing root
 Vb =                      % Linear velocity of rigid body in body frame (should be constantly changing)
 
 V_b_B = Vb + (Wb_B * r_WR_CG)       % evaluation of rigid body velocity 
 
 V_t = R_B_S * V_b_B;                % FINAL 2


%Velocity due to wing flapping
dR_WR_S = diff (@(s, phi) R_WR_S(s, phi), t);      % differential with respect to time of wing root with respect to time in spar frame

V_f = @(s, phi) R_WR_S(s, phi) * dR_WR_S * r_S;                   % FINAL 3

Vw = V_r + V_t + V_f;                 % Free stream velocity over an incremental area of wing planform 



