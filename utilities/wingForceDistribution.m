% This script calculates an approximate force distribution over the wing

clearvars;
clc;

% Set the density of air
p = 1.225; % [kg/m^3]

% Set the angular velocity (use maximum to test worst case scenario)
angVel = 300; % [rad/s], approximate maximum taken from 30 Hz flapping

% Set the angle of attack of the wing [deg]
aDeg = 30;     %[deg]
aRad = pi()/6; %[rad]

% Set the wing chord length (taken as a constant value)
c = 0.05; %[m]

% Set the bounds of the first wing slice along the spar
r1 = 0;    %[m]
r2 = 0.02; %[m]

% Loop over the wing to get the force over each section

for i = 1:5
    
    F(i) = generateWingForce(p,r1,r2,c,aDeg,aRad,angVel);
    
    r1 = r1 + 0.02;
    r2 = r2 + 0.02;
    
end

% Generate the force over the whole wing
F_total = sum(F);

% Plot the data
xLabels = categorical({'0-2','2-4','4-6','6-8','8-10'});
bar(xLabels,F)
title('Force Distribution over Wing');
xlabel('Wing Span (cm)');
ylabel('Force (N)');

% Determine area ratios and plot

F_corr = [ 0.0104 0.0869 0.2226 0.3762 0.3631 ];

F_ratio = (F_corr./F)*100;

xLabels = categorical({'0-2','2-4','4-6','6-8','8-10'});
bar(xLabels,F_corr)
title('Force Distribution over Wing');
xlabel('Wing Span (cm)');
ylabel('Force (N)');

function F = generateWingForce(p,r1,r2,c,aDeg,aRad,angVel)

cL = 1.58*sin((2.13*aDeg)-(7.2*(pi()/180))) + 0.225;

cD = 1.92 - 1.55*cos((2.04*aDeg)-(9.82*(pi()/180)));

F = (sqrt(angVel^4 * p^2 * c^2 * (r1-r2)^2 * ((r1^2)+(r2*r1)+(r2^2))^2 * (aRad^2 * cD^2 + cL^2)))/6;

end