clear;
clc;

omega_RW = 10*2*pi;
omega2_RW = 20*2*pi;
omega3_RW = 30*2*pi;
n=100
x = linspace(0,pi/2,100);
y = zeros(n,1);
y2 = zeros(n,1);
y3 = zeros(n,1);

for t=1:length(x)
    y(t) = cycleaveraging(x(t), omega_RW)
    y2(t) = cycleaveraging(x(t), omega2_RW)
    y3(t) = cycleaveraging(x(t), omega3_RW)
end
figure(1);
hold on;

plot(x,y);
plot(x,y2);
plot(x,y3);

legend("10 Hz", "20 Hz", "30 Hz");


