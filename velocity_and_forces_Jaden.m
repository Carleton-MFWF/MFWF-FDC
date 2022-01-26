%%%%%%%%%%%%%%%%%%%%%%%%%
%{
    WING VELOCITY - JADEN
%}
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%
%        TESTING        %
%%%%%%%%%%%%%%%%%%%%%%%%%
%{

syms x;

y = 2*x;

output = sym2poly(int(y,0,4));


syms a b;

f = a*b;

output2 = sym2poly(int(int(f,a,0,4),0,4));

syms q w

g = [ q+w ; q*w ];

output3 = double(int(int(g,q,0,4),0,4));

%}

% Declare r and c:
syms r;
syms c;

% Generate the inputs required:
Vb = [0.5;0.5;0.5];
s = 1;
phi = 0;
a = 1;
alpha_p = -45;
theta = [0,0,0];
p = 1.225;
% placeholder value
psi = pi()/4;

% Wing dimensions:
c_max = 0.5;
r_max = 1;

% Calculate the magnitude of the wing velocity:

%Vw = WingVelocity(Vb, s, phi, a, alpha_p, theta);

%psi = atan(Vw(3)/Vw(2));

Vw = norm(WingVelocity(Vb, s, phi, a, alpha_p, theta));

% Generate the rotational matrix from the V to the P frame:

r_PP_V = R_PP_V(alpha_p);
r_V_PP = r_PP_V^(-1);

r_P_PP = R_P_PP(psi);
r_PP_P = r_P_PP^(-1);

r_V_P = r_V_PP * r_PP_P;

% Calculate the coefficients:

liftCoeff = 1.58*sin((2.13*alpha_p)-(7.2*(pi()/180))) + 0.225;

dragCoeff = 1.92 - 1.55*cos((2.04*alpha_p)-(9.82*(pi()/180)));

densityCoeff = p/2;

% Calculate the infinitesimal lift and drag:

dL_V = densityCoeff * Vw * liftCoeff;

dD_V = densityCoeff * Vw * dragCoeff;

% Construct the force vector:

dF_V = [ sign(alpha_p)*dL_V ; dD_V ; 0 ];

% Transform the force vector to the correct frame:

dF_P = vpa(r_V_P * dF_V);

F_P = double(int(int(dF_P,c,0,c_max),0,r_max));



%Estimation of wing velocity
function Vw = WingVelocity(Vb, s, phi, a, alpha_p, theta)                           % Free stream velocity on planform frame with respect to wing spar length and chord length              

% Definitions: B-Body Frame; S-Spar Frame; P- Planform Frame; wr- Wing Root; ws-Wing Spar;
% wp-Wing planform; 
 
 r_CG = [0;0;0];              % Centre of gravity of body frame.
 r_WR = [0;1;1];        % Origin of wing root/ position vector of wing root
 %r_WR_CG = @(c) r_CG - r_WR;                 
 
 % Rotation of rigid body from inertial frame to body frame
 r_I_B = R_I_B(theta);
 
 % rotation of spar frame to wing planform frame coordinates
 r_S_P = R_S_P(a, alpha_p);

% rotation of wing root frame to spar frame coordinates
r_WR_S = R_WR_S(s, phi);
 
% rotation of body frame in spar frame coordinates
R_B_S = r_WR_S *  r_S_P; 

 
% left wing and right wing definition
s = 1;             % Left wing
%s = -1;            % Right wing
 
% Position vector of infinitesimal point on body frame(r_B); spar frame (r_S), and planform (r_P)
syms r c;
r_P = [0; r; -c];                           % Position vector of infinitesimal point on wing planform (r_P)
r_B = (r_CG - r_WR)+ r_WR_S * r_S_P * r_P;   % Position vector of infinitesimal point on rigid body (r_B)
r_S = r_S_P * r_P;                          % Position vector of infinitesimal point on spar frame (r_S)

% Velocity due to rigid body rotation

Wb_B = transpose(r_I_B);                % angular velocity of body frame with respect to changng theta with time                   % 
V_r =  r_WR_S * Wb_B * r_B;           % FINAL 1

%{
if s == 1 && u == 1 
V_r = r_WR_S  * u * Wb_B * r_B;  % left wing upstroke
end 


if s == 1 && d == -1 
V_r = r_WR_S * d * Wb_B * r_B;  % left wing downstroke
end 
%}
if s == -1 && d == -1
V_r = r_WR_S * d * Wb_B * r_B;  % right wing downstroke 
end 

%{
if s == -1 && u == 1
V_r = r_WR_S * u * Wb_B * r_B;  % right wing upstroke 
end 
%}

% Velocity due to rigid body translation

 r_WR_CG = r_WR - r_CG;    % position vector for centre of gravity of rigid body to wing root on body frame
 
 V_b_B = Vb + (Wb_B * r_WR_CG);       % evaluation of rigid body velocity of body frame
 
 V_t = R_B_S * V_b_B;                % FINAL 2

%Velocity due to wing flapping

delta = r_WR_S;
dR_WR_S = gradient(delta);

%temp = arrayfun(@(colidx) diff(delta(:,colidx), colidx-1), 1:size(delta,2), 'uniform', 0);
%dR_WR_S = [temp{:}];

V_f = r_WR_S * dR_WR_S * r_S;                   % FINAL 3

Vw = vpa(V_r + V_t + V_f);                % Free stream velocity over an incremental area of wing planform (Addition of FINAL 1 to FINAL 3) 

end