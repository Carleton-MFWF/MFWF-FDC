function R = R_P_PP(psi_P)
%R_P_P Return rotation matrix for planform frame to PP frame
% psi_P - angle between x_P and v_inf in x_P, y_P plane

% convert radians to degrees
psi_P = rad2deg(psi_P);

% Rotate about y-axis
R = rotz(psi_P);
end