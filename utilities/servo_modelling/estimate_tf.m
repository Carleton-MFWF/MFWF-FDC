clc;
clear;
close all;

T = readtable('data2.csv');

% input time step from output timestamps
Ts = 16.62732131;

data = iddata(T.y,T.u,Ts);

sys = tfest(data,2)

compare(data,sys);
