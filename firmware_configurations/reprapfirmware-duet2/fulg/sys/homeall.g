; homeall.g
; called to home all axes

; Relative positioning
G91

; Lower currents, speed & accel
M98 P"/macros/print_scripts/xy_current_low.g"
M98 P"/macros/print_scripts/z_current_low.g"
M98 P"/macros/print_scripts/speed_probing.g"

; Lift Z relative to current position if needed
if !move.axes[2].homed
  G1 Z10 F9000 H1
elif move.axes[2].userPosition < 10
  G1 Z10 F9000

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

; Absolute positioning
G90

; Home Z with the switch at the back
M98 P"/macros/print_scripts/goto_z_switch.g"
G30 K1 Z-9999

; Restore high currents, speed & accel
M98 P"/macros/print_scripts/xy_current_high.g"
M98 P"/macros/print_scripts/z_current_high.g"
M98 P"/macros/print_scripts/speed_printing.g"
