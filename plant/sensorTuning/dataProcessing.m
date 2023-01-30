%Luke Hendrikse, 101101824, lukehendrikse@cmail.carleton.ca
%Last updated: 2023-01-28
%
%This function is being used to determine the parameters within the AHRS
%block inside the IMU model.
%the input data came from a hardware test where the raw data output of the
%ICM20948 sensor was collected for 7 hours at 30Hz sample rate. the test involved
%
%The desired inputs for the AHRS are as follows:
%   -accelerometer noise (m/s^2)^2
%   -gyroscope noise (dps)^2
%   -Magnetometer noise ((µT)²)
%   -Gyroscope drift noise ((rad/s)²)
%
%These are all variance values that can be found using allan variance and
%their respective data sets.
%
%Help code can be found here:
%https://www.mathworks.com/help/fusion/ug/inertial-sensor-noise-analysis-using-allan-variance.html



%Reading in raw data
data = readmatrix("Data7Hr_V2.txt");

%***************************
%Gyroscope Noise
%***************************

    %Modifying data for the allan function
    %Creating Omega matrix from gyroscope values
    gyroOmega = data(:,[4,5,6]);
    %Removing zeros in the first column
    gyroOmega(1,:) = []; 

    %Allan variance function applied to the whole matrix
    fs = 30; %sample frequency in hertz
    t0 = 1/fs; %Sampl period
    n = 7*60*60*30; %sample count %hrs*mins*secs*sampling ~822647
    
    %Time integrated output angle
    thetax = cumsum(gyroOmega(:,1), 1)*t0; % can use cumulative sum for discrete samples
    thetay = cumsum(gyroOmega(:,2), 1)*t0; 
    thetaz = cumsum(gyroOmega(:,3), 1)*t0; 


    maxNumM = 200;
    L = size(thetax, 1);
    maxM = 2.^floor(log2(L/2));
    m = logspace(log10(1), log10(maxM), maxNumM).';
    m = ceil(m); % m must be an integer.
    m = unique(m); % Remove duplicates.

    [gyroVar,gyrotau] = allanvar(gyroOmega,m,fs);

    loglog(gyrotau,gyroVar(:,1));
    xlabel('\tau')
    ylabel('\sigma(\tau)')
    title('Gyroscope Allan Variance')
    grid on

%***************************
%Magnetometer Noise
%***************************
    %Modifying data for the allan function
    %Creating Omega matrix from acceleration values
    magOmega = data(:,[7,8,9]);
    %Removing zeros in the first column
    magOmega(1,:) = [];

    %Finding the m value
    theta = cumsum(magOmega(:,1), 1)*t0;


    maxNumM = 125;
    L = size(theta, 1);
    maxM = 2.^floor(log2(L/2));
    m = logspace(log10(1), log10(maxM), maxNumM).';
    m = ceil(m); % m must be an integer.
    m = unique(m); % Remove duplicates.


    [magVar,magtau] = allanvar(magOmega,m,fs);
% 
%     loglog(magtau,magVar(:,1));
%     xlabel('\tau')
%     ylabel('\sigma(\tau)')
%     title('Magnetometer Allan Variance')
%     grid on

%based on the spec sheet
%gyro variance
%gyro = 0.253125 dps^2
%accel 6.18400995E-10 m/s^2

