; homez.g
; called to home the Z axis

; Allow movements before homing
M564 H0

; Setup low speed & accel
M98 P"/macros/print_scripts/speed_probing.g"

; Lower Z currents
M98 P"/macros/print_scripts/z_current_low.g"

; Lift Z relative to current position
if !move.axes[2].homed
  G91
  G1 Z10 F9000
  G90
elif move.axes[2].userPosition < 10
  G1 Z10 F9000

; Coarse homing with the inductive probe
M98 P"/macros/print_scripts/goto_bed_center.g"
G30 K0 Z-9999

; Restore high Z currents
M98 P"/macros/print_scripts/z_current_high.g"

; Restore normal speed & accel
M98 P"/macros/print_scripts/speed_printing.g"

; Homing done, enforce limits
M564 S1 H1
