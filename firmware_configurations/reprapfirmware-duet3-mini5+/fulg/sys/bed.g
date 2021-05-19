; bed.g
; Called to align the gantry to the bed plane via G32

; Clear any bed transform
M561

; Turn off noisy Extruder motor
M84 E0

; Home all axes
G28

; Lower currents, speed & accel
M98 P"/macros/print_scripts/setup_probing.g"

; Probe the bed at 4 points, x3 for more precision
M558 K0 H10 F1200 ; increase the depth range, gets the gantry mostly level immediately
M98 P"/sys/bed_probe_points.g"
M558 K0 H4 F240   ; reduce depth range, probe slower for better repeatability
M98 P"/sys/bed_probe_points.g"
; last attempt will be auto-repeated
M558 K0 H1 F60    ; reduce depth range, probe slower for better repeatability
while move.calibration.initial.deviation > 0.003
  if iterations > 3
    abort "Too many leveling attempts! Canceling print."
  M98 P"/sys/bed_probe_points.g"
  echo "Current deviation: " ^ move.calibration.initial.deviation ^ "mm"
echo "Leveling complete"

; Restore high currents, speed & accel
M98 P"/macros/print_scripts/setup_printing.g"
