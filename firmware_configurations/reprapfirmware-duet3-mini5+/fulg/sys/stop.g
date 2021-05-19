; stop.g
; called when M0 (Stop) is run (e.g. when a print from SD card is cancelled)

; Turn off Bed, Extruder and Fan
M140 S0
M104 S0
M106 S0

; stop motors
M84

; stop bay cooling fan
M106 P2 S0
