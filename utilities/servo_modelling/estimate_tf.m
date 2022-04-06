% estimate_tf.m
% Author: Nabil Roberts
% Estimates transfer function from experimental data for servo response
% and saves to servo data dictionary.

clc;
clear;
close all;

% Read input data
% 'u'- servo input
% 'y' - servo output
T = readtable('data2.csv'); % change filename when required

% input time step from output timestamps
Ts = 16.62732131/1000; % [s] timestep

% create intput-output data 
data = iddata(T.y,T.u,Ts);

% Estimate a second-order transfer function from the data
sys = tfest(data,2);

compare(data,sys);

%% save estimated tf to servo data dict

% Simulink.data.dictionary.create('./data/servo.sldd')
dataDict =  Simulink.data.dictionary.open('servo.sldd');
[num, den] = tfdata(sys, 'v');

designData = getSection(dataDict,'Design Data');

if exist(designData,'tf_num')
      tfObj = designData.getEntry('tf_num');
      tfObj.setValue(num);
else
    tfObj = designData.addEntry('tf_num', num);
end

if exist(designData,'tf_den')
      tfObj = designData.getEntry('tf_den');
      tfObj.setValue(den);
else
    tfObj = designData.addEntry('tf_den', den);
end
dataDict.saveChanges();