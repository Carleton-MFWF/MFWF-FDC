%%%%%%%%%%%%%%%%%%%%%%%%%
%{
    WING VELOCITY - JADEN
%}
%%%%%%%%%%%%%%%%%%%%%%%%%

%{

% Define the distance from the centre of gravity to the wing root

    % Define the centre of gravity in the body frame
    r_CG_B = [0;0;0];

    % Define the position of the wing root in the body frame
    r_WR_B = [0;1;1];
    
    r_CG_WR_B = r_WR_B - r_CG_B;
    
%}



% Vw = Vf + Vr + Vt

syms x;

y = 2*x;

output = sym2poly(int(y,0,4));


syms a b;

f = a*b;

output2 = sym2poly(int(int(f,a,0,4),0,4));

syms q w

g = [ q+w ; q*w ];

output3 = double(int(int(g,q,0,4),0,4));


syms r c;
a =1
b =2
g
d


Vw = Vf + a*b*g*r*c + (c*b)

%