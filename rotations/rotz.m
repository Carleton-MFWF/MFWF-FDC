function R = rotz(x)
%ROTZ rotation matrix for rotation about z-axis in degrees
%   Detailed explanation goes here
R = [
        cosd(x), -sind(x), 0;
        sind(x), cosd(x), 0;
        0, 0, 1;
    ];
end

