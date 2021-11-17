function R = R_PP_V(theta_P)
%R_P_P Return rotation matrix for planform frame to PP frame
% angle - angle between x_PP and v_inf in x_PP, z_PP plane

% convert radians to degrees
theta_P = rad2deg(theta_P);

% Rotate about y-axis
R = roty(-theta_P);
end