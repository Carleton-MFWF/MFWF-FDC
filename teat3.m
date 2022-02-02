clear;
clc;

omega_RW = 1000*pi/180;
omega2_RW = 2000*pi/180;
omega3_RW = 3000*pi/180;
n=100
x = linspace(0,pi/2,100);
y = zeros(n,1);
y2 = zeros(n,1);
y3 = zeros(n,1);

for t=1:length(x)
    y(t) = cycleaveraging2(x(t), omega_RW)
    y2(t) = cycleaveraging2(x(t), omega2_RW)
    y3(t) = cycleaveraging2(x(t), omega3_RW)
end
figure(3);
hold on;

plot(x,y);
plot(x,y2);
plot(x,y3);

legend("10 Hz", "30 Hz", "20 Hz");
