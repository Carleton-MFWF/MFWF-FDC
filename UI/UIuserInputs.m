function UIuserInputs
%This function initializes the inputs struct. This allows the app and the
%model to talk to each other.

inputs = struct;

%Sensor Inputs
inputs.Sensor.Ideal = 1;
%Plant Inputs

%Controller Inputs

%Visualization Inputs
inputs.Vizualization.animation = 0;
%Commands Inputs

%Assigning inputs to base workspace
assignin('base', 'inputs', inputs);
end

