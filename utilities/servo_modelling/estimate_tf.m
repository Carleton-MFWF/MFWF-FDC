clc;
clear;
close all;

T = readtable('data2.csv');

% input time step from output timestamps
Ts = 16.62732131/1000;

data = iddata(T.y,T.u,Ts);

sys = tfest(data,2)

compare(data,sys);
% Simulink.data.dictionary.create('./data/servo.sldd')
dataDict =  Simulink.data.dictionary.open('servo.sldd');


%%
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