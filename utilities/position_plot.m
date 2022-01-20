clc;
clear;
close all;

sim('MFWF_harness')
%% 
grid on;

x_c = control_ref(:,1);
y_c = control_ref(:,2);
z_c = control_ref(:,3);

x = simout(:,1);
y = simout(:,2);
z = simout(:,3);
% figure(1)
% h = animatedline('MaximumNumPoints', length(x));
% % Force a 3D view
% view(3);
% 
% for k = 1:length(x)

%     addpoints(h,x(k),y(k),z(k));
%     drawnow
% end

figure(1)
subplot(3,1,1)
grid on;
hold on;
plot(t,x)
plot(t,x_c, '-')
xlabel('Time (sec)')
ylabel('x (m)')


subplot(3,1,2)
grid on;
hold on;
plot(t,y)
plot(t,y_c, '-')
xlabel('Time (sec)')
ylabel('y (m)')

subplot(3,1,3)
grid on;
hold on;
plot(t,z);
plot(t,z_c, '-')
xlabel('Time (sec)');
ylabel('z (m)');
