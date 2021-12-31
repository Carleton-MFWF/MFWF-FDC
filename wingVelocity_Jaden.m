% Estimation of wing velocity
% Free stream velocity on planform frame with respect to wing spar length and chord length
function Vw = wingVelocity_Jaden(Vb, s,  phi, a, alpha_p, theta, dR_WR_S)

% Definitions: B-Body Frame; S-Spar Frame; P- Planform Frame; wr- Wing Root; ws-Wing Spar;
% wp-Wing planform; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SIMULINK %%%%%%%%%%%%%%%%%%%%%%%%%%
 r_CG = [0;0;0];        % Centre of gravity of body frame.
 r_WR = [0;1;1];       % origin of wing root/ position vector of wing root
 r_WR_CG = r_CG - r_WR;                 
 
 % Rotation of rigid body from inertial frame to body frame
 r_I_B = R_I_B(theta);

 % rotation of body frame in spar frame coordinates
r_WR_S = R_WR_S(s, phi);
 
  % rotation of spar frame to wing planform frame coordinates
r_S_P = R_S_P(a, alpha_p);

 R_B_S = r_WR_S * r_S_P; 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 syms r c;
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DEPENDS ON R AND C %%%%%%%%%%%55
% Position vector of infinitesimal point on body frame(r_B); spar frame (r_S), and planform (r_P)
r_P = [0; r; -c];                           % Position vector of infinitesimal point on wing planform (r_P)
r_B = (r_CG - r_WR)+ r_WR_S * r_S_P * r_P;  % Position vector of infinitesimal point on rigid body (r_B)
r_S = r_S_P * r_P;                          % Position vector of infinitesimal point on spar frame (r_S)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Velocity due to rigid body rotation
% SIMULINK %%%%%%%%%
Wb_B = transpose(r_I_B);                % angular velocity of body frame with respect to changng theta with time                   % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HALF & HALF

V_r = r_WR_S * Wb_B * r_B;           % FINAL 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 % SIMULINK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if s == 1 && a == 1 
V_r = r_WR_S * a * Wb_B * r_B;  % left wing upstroke
end 

if s == 1 && a == -1 
V_r = r_WR_S * a * Wb_B * r_B;  % left wing downstroke
end 

if s == -1 && a == -1
V_r = r_WR_S * a * Wb_B * r_B;  % right wing downstroke 
end 

if s == -1 && a == 1
V_r = r_WR_S * a * Wb_B * r_B;  % right wing upstroke 
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Velocity due to rigid body translation

% SIMULINK%%%%%%%%%%%%%%%%%%%%%%%%%
 r_WR_CG = r_WR - r_CG;    % position vector for centre of gravity of rigid body to wing root on body frame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%   SIMULINK %%%%%%%%%%%%%%%%%%%%%%%%
 V_b_B = Vb + (Wb_B * r_WR_CG);     % evaluation of rigid body velocity of body frame
 
 
 V_t = R_B_S * V_b_B;                % FINAL 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Velocity due to wing flapping

% THIS SECTION HAS BEEN DEFINED AS AN INPUT
% delta = r_WR_S;
% dR_WR_S = gradient(delta);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

V_f = r_WR_S * dR_WR_S * r_S;                   % FINAL 3

Vw = V_r + V_t + V_f;                % Free stream velocity over an incremental area of wing planform (Addition of FINAL 1 to FINAL 3) 

end