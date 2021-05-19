; assumes hotend is hot
M291 P"Please wait while the nozzle is being heated up" R"Loading Filament" T5 ; Display message
M116 ; Wait for the temperatures to be reached
M291 P"Feeding filament..." R"Loading Filament" T5 ; Display new message
G1 E100 F300 ; Feed 100mm of filament at 300mm/min
G4 P1000 ; Wait one second
G1 E-4 F1800 ; Retract 4mm of filament at 1800mm/min
M400 ; Wait for moves to complete
M292 ; Hide the message
G10 S0 ; Turn off the heater again
