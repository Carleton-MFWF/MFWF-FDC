function wingForce = wingForces(V_b, theta_b, alpha, phi, rotationalDerivative, wingDef, strokeDef)

% THIS LINE OF CODE IS TEMPORARY AND MUST BE REMOVED
psi = pi()/4;


% Define the r and c values:

syms r;
syms c;

r_max = 2;
c_max = 1;


% Calculate the coefficients:

densityCoeff = 1.225/2;

liftCoeff = 1.58*sin((2.13*alpha)-(7.2*(pi()/180))) + 0.225;

dragCoeff = 1.92 - 1.55*cos((2.04*alpha)-(9.82*(pi()/180)));


% Calculate the magnitude of the wing velocity:

wingVelocity_P = wingVelocity(V_b, wingDef, phi, strokeDef, alpha, theta_b, rotationalDerivative);

wingVelocityMagnitude = norm(wingVelocity_P);


% Calculate the infinitesimal lift and drag:

dL_V = densityCoeff * wingVelocityMagnitude * liftCoeff;

dD_V = densityCoeff * wingVelocityMagnitude * dragCoeff;


% Construct the force vector:

dF_V = [ sign(alpha)*dL_V ; dD_V ; 0 ];

% Generate the rotational matrix from the V to the P frame:

r_PP_V = R_PP_V(alpha);
r_V_PP = r_PP_V^(-1);

r_P_PP = R_P_PP(psi);
r_PP_P = r_P_PP^(-1);

r_V_P = r_V_PP * r_PP_P;

% Transform the force vector to the correct frame:

coder.extrinsic('vpa');

dF_P = vpa(r_V_P * dF_V);

wingForce = double(int(int(dF_P,c,-c_max,0),0,r_max));

end