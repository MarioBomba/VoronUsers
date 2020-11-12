; homeall.g
; called to home all axes

; Allow movements before homing
M564 H0

; Relative positioning
G91

; Setup low speed & accel
M98 P"/macros/print_scripts/speed_probing.g"

; Lower Z currents
M98 P"/macros/print_scripts/z_current_low.g"

; Lift Z relative to current position if needed
if !move.axes[2].homed
  G1 Z10 F9000
elif move.axes[2].userPosition < 10
  G1 Z10 F9000

; Lower AB currents
M98 P"/macros/print_scripts/xy_current_low.g"

; Coarse home X or Y
G1 X600 Y600 F2400 H1

; Coarse home X
G1 X600 H1

; Coarse home Y
G1 Y600 H1

; Move away from the endstops
G1 X-5 Y-5 F9000

; Fine home X
G1 X600 F360 H1

; Fine home Y
G1 Y600 H1

; Restore high AB currents
M98 P"/macros/print_scripts/xy_current_high.g"

; Absolute positioning
G90

; Coarse Z homing with the inductive probe
M98 P"/macros/print_scripts/goto_bed_center.g"
G30 K0 Z-9999

; Restore high Z currents
M98 P"/macros/print_scripts/z_current_high.g"

; Restore normal speed & accel
M98 P"/macros/print_scripts/speed_printing.g"

; Homing done, enforce limits
M564 S1 H1
