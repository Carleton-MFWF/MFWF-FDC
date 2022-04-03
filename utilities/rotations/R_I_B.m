function R = R_I_B(theta)
%R_S_P Return rotation matrix for inertial frame to body frame
%   3-2-1 Rotation
%  theta: vector of euler rotation angles 

theta = rad2deg(theta);

% perform 3-2-1 rotation
R = rotx(theta(1))*roty(theta(2))*rotz(theta(3));
end