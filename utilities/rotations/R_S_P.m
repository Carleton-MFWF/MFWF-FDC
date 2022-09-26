function R = R_S_P(a, alpha_p)
%R_S_P Return rotation matrix for wing spar frame to planform frame
%   a - stroke parameter
%       a = 1 upstroke
%       a = -1 downstroke
%  alpha_p - angle of wing chord relative to wing spar x-axis (rad) 

% rotation of wing about the spar 
alpha_wp = -a*alpha_p + (1-a)*pi/2;

% convert radians to degrees
alpha_wp = rad2deg(alpha_wp);

% Rotate about y-axis
R = roty(alpha_wp);
end