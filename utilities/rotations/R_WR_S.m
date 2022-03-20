function R = R_WR_S(s, phi)
%R_WR_S Return rotation matrix for wing root frame to wing spar frame
%   s - wing parameter
%       s = 1 left wing
%       s = -1 right wing
%   phi - stroke angle (rad) 

% left/right wing correction angle
x = -(1-s)*pi/2;

% convert radians to degrees
phi = rad2deg(phi);
x = rad2deg(x); % 

% Rotate about z-axis
R = rotz(x + s*phi);
end