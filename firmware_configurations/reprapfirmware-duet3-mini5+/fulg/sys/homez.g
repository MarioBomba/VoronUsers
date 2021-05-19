; homez.g
; called to home the Z axis

; do nothing if XY is not homed yet
if move.axes[0].homed && move.axes[1].homed
  M98 P"/macros/print_scripts/setup_probing.g"      ; Setup low speed & accel
  if move.axes[2].userPosition <= 0                 ; Lift Z relative to current position
    G1 Z5 F9000
  M98 P"/macros/print_scripts/goto_z_switch.g"
  G30 K1 Z-99999                                    ; Probe the Z pin at the back
  M98 P"/macros/print_scripts/setup_printing.g"     ; Restore normal speed & accel
