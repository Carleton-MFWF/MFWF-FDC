MATLAB / Simulink Styleguide

# Naming Convetions
## Files
- use snake_case for file and function names

## variables 
- any constants should be accompinied by the units and name of constant
    - Example: `g % [m/s^2] gravitaional acceleration`
  
# Simulink Models
Simulink models inputs and outputs should be labeled with the symbol of the parameter as well as its units Example: `F_A (N)`.'

Any constants required for the model should be saved either in the model workspace or a linked data dictionary.

Models should be accompinied by a wiki page of the same name that includes a brief description of the model, a description of the input and output signals, revision history, assumptions, and additional notes.
