%***********************************************************************
%Luke Hendrikse, lukehendrikse@cmail.carleton.ca
%
%This code is primarily taken from this Matlab tutorial:
%https://www.mathworks.com/help/matlab/math/fourier-transforms.html
%
%Purpose: Perform a fast fourier transform on the accelerometer data to
%find a cut off frequency for a lowpass filter in the sensor processing
%***********************************************************************

%load accelData
load('accelData.mat');

%This is the sample time
Ts = 0.001;
%Sampling frequency
fs = 1/Ts;

%Chopping the unstable part off the accel output
accelData([2001:length(accelData)], :) = [];

%Performing the FFT on the x data
x = fft(accelData(:,1)); 
%Creating frequency domain
f = (0:length(x)-1)*fs/length(x);


%shifting the data to eliminate negative magnitudes
n = length(accelData(:,1));
fshift = (-n/2:n/2-1)*(fs/n);
xshift = fftshift(x);

%plotting the fft for X acceleration
figure(1);
hold on
title('X Accelerometer Data');
plot(fshift,abs(xshift))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([0 100]);
hold off

%Performing the FFT on the y data
y = fft(accelData(:,2)); 

%shifting the data to eliminate negative magnitudes
n = length(accelData(:,1));
fshift = (-n/2:n/2-1)*(fs/n);
yshift = fftshift(y);

%plotting the fft for the Y Accelerometer data
figure(2);
hold on
title('Y Accelerometer Data');
plot(fshift,abs(yshift))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([0 100]);
hold off


%Performing the FFT on the z data
z = fft(accelData(:,3)); 


%shifting the data to eliminate negative magnitudes
n = length(accelData(:,3));
fshift = (-n/2:n/2-1)*(fs/n);
zshift = fftshift(z);

%plotting the fft for the Z Acclerometer data
figure(3);
hold on
title('Z Accelerometer Data');
plot(fshift,abs(zshift))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([0 100]);
hold off

