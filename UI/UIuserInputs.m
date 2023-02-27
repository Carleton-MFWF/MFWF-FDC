function UIuserInputs
%This function initializes the inputs struct. This allows the app and the
%model to talk to each other.

inputs = struct;

%Sensor Inputs
inputs.Sensor.Ideal = 1;

%Plant Inputs
inputs.Plant.Aerodynamics.cycleAverage = 0;
%Controller Inputs

%Visualization Inputs
inputs.Visualization.animation = 0;
inputs.Visualization.presentation = 0;

%Commands Inputs
inputs.Commands.xCommand = timeseries;
inputs.Commands.xCommand.data = [0;2;0;0];
inputs.Commands.xCommand.time = [0;20;40;100];

inputs.Commands.yCommand = timeseries;
inputs.Commands.yCommand.data = [0;1.5;0;0];
inputs.Commands.yCommand.time = [0;5;15;100];

inputs.Commands.zCommand = timeseries;
inputs.Commands.zCommand.data = [0;1;0;0];
inputs.Commands.zCommand.time = [0;10;80;100];

inputs.Commands.psiCommand = timeseries;
inputs.Commands.psiCommand.data = [0;0.4;0;0];
inputs.Commands.psiCommand.time = [0;5;8;100];

inputs.Commands.thetaCommand = timeseries;
inputs.Commands.thetaCommand.data = [0;1;0;0];
inputs.Commands.thetaCommand.time = [0;1;8;100];

inputs.Commands.phiCommand = timeseries;
inputs.Commands.phiCommand.data = [1;0  ;1;  0; 1;   0; 1;   0; 1;  0];
inputs.Commands.phiCommand.time = [0;2.5;5;7.5;10;12.5;15;17.5;20;100];

%Command Enables
inputs.Commands.xCommandEnable = 0;
inputs.Commands.yCommandEnable = 0;
%Z is the only enabled command by default
inputs.Commands.zCommandEnable = 1;
inputs.Commands.psiCommandEnable = 0;
inputs.Commands.thetaCommandEnable = 0;
inputs.Commands.phiCommandEnable = 0;



%Assigning inputs to base workspace
assignin('base', 'inputs', inputs);
end

