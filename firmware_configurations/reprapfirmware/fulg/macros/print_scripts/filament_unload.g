; assumes hotend is hot
M291 P"Heating up nozzle..." R"Unloading Filament" T10 S0 ; Display message
M116 ; Wait for the temperatures to be reached
M291 P"Retracting..." R"Unloading Filament" T0 S0 ; Display new message
G1 E-100 F300 ; Retract 100mm of filament at 300mm/min
M400 ; Wait for moves to complete
M292 ; Hide the message
G10 S0 ; Turn off the heater
M84 E0 ; Turn off extruder drive
