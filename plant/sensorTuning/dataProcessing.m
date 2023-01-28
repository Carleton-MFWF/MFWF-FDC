%This function is being used to determine the parameters within the AHRS
%block inside the IMU model.
%the input data came from a hardware test where the raw data output of the
%ICM20948 sensor was collected for 7 hours. the test involved
%
%The desired inputs for the AHRS are as follows:
%   -accelerometer noise (m/s^2)^2
%   -gyroscope noise (dps)^2
%   -Magnetometer noise ((µT)²)
%   -Gyroscope drift noise ((rad/s)²)
%
%These are all variance values that can be found using allan variance and
%their respective data sets.



%Reading in raw data
data = readtable("Data7Hr_V2.txt");

%accelerometer noise

%Creating Omega matrix from acceleration values
accelOmega = data(:,[1,2,3]);
%Removing zeros in the first column
accelOmega(1,:) = []; 

%Allan variance function applied to the whole matrix
accelVar(:,1) = allanvar(accelOmega(:,1));
