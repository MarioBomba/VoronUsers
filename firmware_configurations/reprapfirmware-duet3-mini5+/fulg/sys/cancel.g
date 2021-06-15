; cancel.g
; called when a print is cancelled after a pause.

; Turn off Bed, extruder and fan
M140 S0
M104 S0
M106 S0

; stop motors
M84

; stop bay cooling fan
M106 P2 S0
