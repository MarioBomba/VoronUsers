; bed.g
; Called to align the gantry to the bed plane via G32

; Clear any bed transform
M561

; Turn off noisy Extruder motor
M84 E

; Home all axes
G28

; Lower currents, speed & accel
M98 P"/macros/print_scripts/speed_probing.g"
M98 P"/macros/print_scripts/z_current_low.g"
M98 P"/macros/print_scripts/xy_current_low.g"

; Probe the bed at 4 points, x3 for more precision
M558 K0 H10 F1200 ; increase the depth range, gets the gantry mostly level immediately
M98 P"/sys/bed_probe_points.g"
M558 K0 H4 F240   ; reduce depth range, probe slower for better repeatability
M98 P"/sys/bed_probe_points.g"
M558 K0 H1 F60    ; reduce depth range, probe slower for better repeatability
M98 P"/sys/bed_probe_points.g"

; Restore high currents, speed & accel
M98 P"/macros/print_scripts/speed_printing.g"
M98 P"/macros/print_scripts/xy_current_high.g"
M98 P"/macros/print_scripts/z_current_high.g"

