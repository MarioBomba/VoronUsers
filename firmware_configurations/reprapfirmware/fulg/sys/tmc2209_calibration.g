; gcode snippet to calibrate TMC2209 drivers (this is not automatic in RRF)

M400    ; wait for current moves to finish
M18     ; disable all stepper motors

; Stallguard Sensitivy
M915 X S1 F0 H200 R0    ; Set X axis sensitivity  
M915 Y S2 F0 H200 R0	; Set Y axis sensitivity 

; StealthCop calibration
M17                     ; turn on _all_ steppers
G4 P150                 ; wait a bit, let the TMC2209 automatic tuning finish
G91                     
G1 H2 X-2 Y-2 Z2 F2000
G90
G4 S1
