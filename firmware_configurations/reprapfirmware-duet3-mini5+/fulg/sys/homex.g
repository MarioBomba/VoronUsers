; homex.g
; called to home the X axis

; Setup low speed & accel
M98 P"/macros/print_scripts/setup_probing.g"

; Lift Z relative to current position
if !move.axes[2].homed
  G91
  G1 Z10 F9000 H1
  G90
elif move.axes[2].userPosition < 10
  G1 Z10 F9000

; Move quickly to X axis endstop and stop there (first pass)
G1 X600 F2400 H1

; Go back a few mm
G91
G1 X-5 F9000
G90

; Move slowly to X axis endstop once more (second pass)
G1 X600 F360 H1

; Restore normal speed & accel
M98 P"/macros/print_scripts/setup_printing.g"
