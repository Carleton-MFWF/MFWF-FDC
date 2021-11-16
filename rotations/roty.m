function R = roty(x)
%ROTZ rotation matrix for rotation about z-axis in degrees
%   Detailed explanation goes here
R = [
        cosd(x), 0, sind(x);
        0, 1, 0;
        -sind(x), 0, cosd(x);
    ];
end

