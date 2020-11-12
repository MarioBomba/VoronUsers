; bed.g
; called to perform automatic bed compensation via G32

; Clear any bed transform
M561

; Home all axes if needed
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  G28
else
  G1 Z5 F9000

; Setup low speed & accel
M98 P"/macros/print_scripts/speed_probing.g"

; lower the z motor currents
M98 P"/macros/print_scripts/z_current_low.g"

; Lower AB currents
M98 P"/macros/print_scripts/xy_current_low.g"

; Probe the bed at 4 points
M98 P"/sys/bed_probe_points.g"

; Repeat right away for more precision
M98 P"/sys/bed_probe_points.g"

; Repeat right away for more precision
M98 P"/sys/bed_probe_points.g"

; Restore normal speed & accel
M98 P"/macros/print_scripts/speed_printing.g"

; Restore high current
M98 P"/macros/print_scripts/xy_current_high.g"
M98 P"/macros/print_scripts/z_current_high.g"

; Load previously probed bed mesh (optional, use only if you know your bed is warped)
G29 S1

; Move to the center of the bed if not printing
echo state.status
if state.status != "Printing"
  M98 P"/macros/print_scripts/goto_bed_center.g"
