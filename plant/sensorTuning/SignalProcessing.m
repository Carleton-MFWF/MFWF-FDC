%***********************************************************************
%Luke Hendrikse, lukehendrikse@cmail.carleton.ca
%
%This code is primarily taken from this Matlab tutorial:
%https://www.mathworks.com/help/matlab/math/fourier-transforms.html
%
%Purpose: Perform a fast fourier transform on the accelerometer data to
%find a cut off frequency for a lowpass filter in the sensor processing
%***********************************************************************

%This is the sample time
Ts = 0.001;

%Chopping the unstable part off the accel output
accelData([2001:length(accelData)], :) = [];

%Performing the FFT on the y data
y = fft(accelData(:,1)); 
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);


%shifting the data to eliminate negative magnitudes
n = length(accelData(:,1));
fshift = (-n/2:n/2-1)*(fs/n);
yshift = fftshift(y);

%plotting the fft
plot(fshift,abs(yshift))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
xlim([0 100]);


