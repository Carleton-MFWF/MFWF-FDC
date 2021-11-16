function R = roty(x)
%ROTZ rotation matrix for rotation about z-axis in degrees
%   Detailed explanation goes here
R = [
        1, 0, 0;
        0, cosd(X), -sind(x);
        0, sind(x), cosd(x);
    ];
end

